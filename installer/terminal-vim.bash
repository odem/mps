#!/bin/bash
# --- Packages ----------------------------------------------------------------
REQUIRED="git make gcc wget bzip2 curl build-essential libncurses-dev"
TOOLS="xclip"
IFS=', ' read -r -a ALL <<< "$REQUIRED $TOOLS"
# --- Font-URLs ---------------------------------------------------------------
INSTALL_DIR=/opt/mps/tools/
VIM90_URL=https://ftp.nluug.nl/pub/vim/unix/vim-9.0.tar.bz2
VIMPLUG_FOLDER=~/.vim/autoload/plug.vim
VIMPLUG_URL=https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# --- Prepare Environment -----------------------------------------------------
ACTION=all
export DEBIAN_FRONTEND=noninteractive
USER=$(whoami)
# --- Read opt ----------------------------------------------------------------
while getopts "a:u:p:" o; do
    case "${o}" in
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
    if [[ "$(which vim)" != "" ]] ; then
        return 0
    fi
    # === packages ===
    sudo -E apt --yes install "${ALL[@]}"
    # === vim ===
    sudo mkdir -p $INSTALL_DIR
    sudo wget $VIM90_URL -O $INSTALL_DIR/vim-9.0.tar.bz2
    sudo tar xjvf $INSTALL_DIR/vim-9.0.tar.bz2 -C $INSTALL_DIR
    sudo rm -rf $INSTALL_DIR/vim-9.0.tar.bz2
    cd $INSTALL_DIR/vim90 || exit 1
    ./configure --enable-clipboard
    make -j32
    sudo make install
    cd - || exit 1
}
function do_uninstall() {
    # === packages ===
    sudo -E apt --yes remove "${ALL[@]}"
    # === vim ===
    cd $INSTALL_DIR/vim90 || exit 1
    sudo make uninstall
}
function do_configure() {
    # === vim config ===
    cp dotfiles/.vimrc ~/.vimrc
    curl -fLo $VIMPLUG_FOLDER --create-dirs $VIMPLUG_URL
    #bash -c "vim +PlugInstall +PlugUpdate +qall"
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
