#!/bin/bash
# --- Packages ----------------------------------------------------------------
REQUIRED="git make gcc wget bzip2 curl build-essential lldb libncurses-dev"
TOOLS="yarn ruby npm fzf fd-find ripgrep shellcheck xclip xsel luarocks"
PYTHON_BASE="python3 python3-venv python3-pip"
PYTHON_EXTRAS="black flake8 pylint mypy python3-neovim python3-pynvim"
IFS=', ' read -r -a ALL <<<"$REQUIRED $TOOLS $PYTHON_BASE $PYTHON_EXTRAS"
IFS=', ' read -r -a CARGO <<<"fd-find tree-sitter-cli"
IFS=', ' read -r -a NPM <<<"neovim"
# --- Font-URLs ---------------------------------------------------------------
NEOVIM_FOLDER=/opt/mps/tools/nvim
RUSTUP_FOLDER=/opt/mps/tools/rustup
LAZYGIT_FOLDER=/opt/mps/tools/lazygit
NEOVIM_URL=https://github.com/neovim/neovim/releases/download/v0.9.4/nvim-linux64.tar.gz
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
    nvim/bin/python -m pip install debugpy pynvim
    cd - || exit 1
    # === npm ===
    sudo npm install -g "${NPM[@]}"
    # === lazygit ===
    LAZYGIT_VERSION=$(curl -s "$LAZYGITLATEST_URL" |
        grep -Po '"tag_name": "v\K[^"]*')
    sudo mkdir -p "$LAZYGIT_FOLDER"
    sudo chown "$USER":"$USER" -R "$LAZYGIT_FOLDER"
    curl -o "$LAZYGIT_FOLDER/lazygit.tar.gz" -L \
        "${LAZYGIT_URL}_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
    tar xf "$LAZYGIT_FOLDER"/lazygit.tar.gz -C "$LAZYGIT_FOLDER"
    sudo install "$LAZYGIT_FOLDER"/lazygit /usr/local/bin
    rm -rf "$LAZYGIT_FOLDER"/lazygit.tar.gz #$LAZYGIT_FOLDER/lazygit
    # === Rustup ===
    sudo mkdir -p "$RUSTUP_FOLDER"
    sudo wget "$RUSTUP_URL" -O "$RUSTUP_FOLDER"/rustup.sh
    sudo chmod a+x "$RUSTUP_FOLDER"/rustup.sh
    "$RUSTUP_FOLDER"/rustup.sh -y
    export PATH=$PATH:~/.cargo/bin
    # shellcheck source=/dev/null
    source "$HOME/.cargo/env"
    cargo install "${CARGO[@]}"

    # === nvim ===
    sudo mkdir -p "$NEOVIM_FOLDER"
    sudo wget "$NEOVIM_URL" -O "$NEOVIM_FOLDER"/nvim-linux64.tar.gz
    sudo tar xzvf "$NEOVIM_FOLDER"/nvim-linux64.tar.gz -C "$NEOVIM_FOLDER"
    cd /usr/local/bin || exit 1
    sudo ln -s "$NEOVIM_FOLDER"/nvim-linux64/bin/nvim
    cd - || exit 1
}
function do_uninstall() {
    # === packages ===
    sudo -E apt --yes remove "${ALL[@]}"
    rm -rf /usr/local/bin/nvim
    # === npm ===
    sudo npm uninstall -g "${NPM[@]}"
    # === cargo ===
    cargo uninstall install "${CARGO[@]}"
}
function do_configure() {
    mkdir -p ~/.config/nvim
    # === nvim config ===
    cp dotfiles/.NERDTreeBookmarks ~/.config/
    cp -r dotfiles/.config/nvim -t ~/.config/
    mkdir -p ~/mps/secrets
    echo '#!/bin/bash' >~/mps/secrets/chatgpt-token.bash
    echo 'export OPENAI_API_KEY=""' >>~/mps/secrets/chatgpt-token.bash
    chmod +x ~/mps/secrets/chatgpt-token.bash
    sudo chown "$USER":"$USER" -R ~/.config
    sudo chmod u+w -R ~/.config
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
