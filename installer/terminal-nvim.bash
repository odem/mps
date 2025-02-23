#!/bin/bash
# --- Packages ----------------------------------------------------------------
REQUIRED="git make gcc wget bzip2 curl build-essential lldb libncurses-dev"
TOOLS="yarn ruby npm fzf fd-find ripgrep shellcheck xclip xsel luarocks"
PYTHON_BASE="python3 python3-venv python3-pip python3-neovim python3-pynvim"
PYTHON_EXTRAS="black flake8 pylint mypy chktex mono-mcs cmake-format"
IFS=', ' read -r -a ALL <<<"$REQUIRED $TOOLS $PYTHON_BASE $PYTHON_EXTRAS"
IFS=', ' read -r -a UNINSTALL <<<"$TOOLS $PYTHON_EXTRAS"
IFS=', ' read -r -a CARGO <<<"fd-find tree-sitter-cli"
IFS=', ' read -r -a NPM <<<"neovim"
# --- Font-URLs ---------------------------------------------------------------
NEOVIM_FOLDER=/opt/mps/tools/nvim
RUSTUP_FOLDER=/opt/mps/tools/rustup
LAZYGIT_FOLDER=/opt/mps/tools/lazygit
NEOVIM_URL=https://github.com/neovim/neovim/releases/download/v0.10.3/nvim-linux64.tar.gz
LAZYGITLATEST_URL="https://api.github.com/repos/jesseduffield/lazygit/releases/latest"
LAZYGIT_URL="https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit"
RUSTUP_URL=https://sh.rustup.rs
# --- Prepare Environment -----------------------------------------------------
ACTION=all
export DEBIAN_FRONTEND=noninteractive
USER=$(whoami)
# --- Read opt ----------------------------------------------------------------
while getopts "a:u:p:" o; do
    case "$o" in
    a)
        ACTION=${OPTARG}
        ;;
    *)
        echo "Unknown option: '${OPTARG}'"
        echo "Aborting..."
        exit 2
        ;;
    esac
done
# --- Core functions ----------------------------------------------------------
function do_install() {
    if [[ "$(which nvim)" != "" ]]; then
        return 0
    fi
    # # === packages ===
    sudo -E apt --yes install "${ALL[@]}"
    # === Python ===
    mkdir -p ~/mps/venv
    cd ~/mps/venv/ || exit 1
    python3 -m venv nvim
    source ./nvim/bin/activate
    pip install debugpy pynvim cmake-tidy ruff-lsp vint
    deactivate
    cd - || exit 1
    # === npm ===
    sudo npm install -g "${NPM[@]}"
    # === lazygit ===
    LAZYGIT_VERSION=$(curl -s "$LAZYGITLATEST_URL" |
        grep -Po '"tag_name": "v\K[^"]*')
    mkdir -p "$LAZYGIT_FOLDER"
    curl -o "$LAZYGIT_FOLDER/lazygit.tar.gz" -L \
        "${LAZYGIT_URL}_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
    tar xf "$LAZYGIT_FOLDER"/lazygit.tar.gz -C "$LAZYGIT_FOLDER"
    sudo install "$LAZYGIT_FOLDER"/lazygit /usr/local/bin
    rm -rf "$LAZYGIT_FOLDER"/lazygit.tar.gz #$LAZYGIT_FOLDER/lazygit
    # === Rustup ===
    mkdir -p "$RUSTUP_FOLDER"
    wget "$RUSTUP_URL" -O "$RUSTUP_FOLDER"/rustup.sh
    chmod a+x "$RUSTUP_FOLDER"/rustup.sh
    "$RUSTUP_FOLDER"/rustup.sh -y
    export PATH=$PATH:~/.cargo/bin
    # shellcheck source=/dev/null
    source "$HOME/.cargo/env"
    cargo install "${CARGO[@]}"

    # === nvim ===
    mkdir -p "$NEOVIM_FOLDER"
    wget "$NEOVIM_URL" -O "$NEOVIM_FOLDER"/nvim-linux64.tar.gz
    tar xzvf "$NEOVIM_FOLDER"/nvim-linux64.tar.gz -C "$NEOVIM_FOLDER"
    cd /usr/local/bin || exit 1
    sudo ln -s "$NEOVIM_FOLDER"/nvim-linux64/bin/nvim
    cd - || exit 1
    # nvim --headless --startuptime nvim_startup.log
}
function do_uninstall() {
    # === npm ===
    sudo npm uninstall -g "${NPM[@]}"
    # === cargo ===
    cargo uninstall "${CARGO[@]}"
    # === packages ===
    sudo -E apt --yes remove "${UNINSTALL[@]}"
    # sudo -E apt --yes remove "${PYTHON_EXTRAS[@]}"
    sudo rm -rf /usr/local/bin/nvim
}
function do_configure() {
    # mkdir -p ~/.config/nvim
    # === nvim config ===
    cp dotfiles/.NERDTreeBookmarks ~
    cp -r dotfiles/.config/nvim -t ~/.config/
    rm -rf ~/.local/share/nvim
    rm -rf ~/.local/state/nvim

}
# --- Execute task ------------------------------------------------------------
export DEBIAN_FRONTEND=noninteractive
case "$ACTION" in
"install")
    do_install
    ;;
"uninstall")
    do_uninstall
    ;;
"configure")
    do_configure
    ;;
"all")
    do_install
    do_configure
    ;;
"list")
    echo "${ALL[@]}"
    ;;
*)
    echo "Not a valid target: $1"
    ;;
esac
