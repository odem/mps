#!/bin/bash
# --- Packages ----------------------------------------------------------------
BUILDER="check automake bison flex"
XCB="libxcb-icccm4-dev libxcb-ewmh-dev libxcb-cursor-dev libxcb-randr0-dev"
XCBUTIL="libxcb-util0-dev libxcb-xinerama0-dev"
XORG="libxkbcommon-x11-dev libstartup-notification0-dev libglib2.0-dev"
CAIRO="libcairo2-dev libpangocairo-1.0-0"
PANGO="libpango1.0-dev libgdk-pixbuf-2.0-dev"
IFS=', ' read -r -a ALL <<< "$BUILDER $XCB $XCBUTIL $XORG $CAIRO $PANGO"
# --- Folders -----------------------------------------------------------------
MPS_FOLDER_SNIPPETS=~/mps/snippets
MPS_FOLDER_THEMES=/usr/share/rofi/themes
MPS_FOLDER_REPO=/opt/mps/tools/rofi
MPS_ROFI_URL=https://github.com/davatorium/rofi.git
MPS_ROFI_CFG=dotfiles/.config/rofi
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
function do_install {
    # === packages ===
    sudo -E apt --yes install "${ALL[@]}"
    # === rofi ===
    sudo rm -rf $MPS_FOLDER_REPO

    if [[ ! -d "$MPS_FOLDER_REPO" ]] ; then
        sudo mkdir -p $MPS_FOLDER_REPO
        sudo git clone $MPS_ROFI_URL $MPS_FOLDER_REPO
        cd $MPS_FOLDER_REPO || exit 1
        sudo git submodule update --init
        sudo autoreconf -i
        cd - || exit 1
    fi

    ROFI=$(which rofi)
    if [[ "$ROFI" == "" ]] ; then
        sudo mkdir -p $MPS_FOLDER_REPO/build
        cd $MPS_FOLDER_REPO/build || exit 1
        sudo ../configure --prefix=/usr/
        sudo make
        sudo make install
        cd - || exit 1
    fi
}
function do_uninstall {
    # === packages ===
    sudo -E apt --yes remove "${ALL[@]}"
    # === rofi ===
    cd $MPS_FOLDER_REPO/build || exit 1
    sudo make uninstall
    sudo rm -rf $MPS_FOLDER_REPO
    cd - || exit 1
}
function do_configure {
    # === config ===
    sudo mkdir -p $MPS_FOLDER_SNIPPETS
    sudo cp snippets/rofi* $MPS_FOLDER_SNIPPETS
    mkdir -p ~/.config/rofi
    sudo cp $MPS_ROFI_CFG/config.rasi ~/.config/rofi/config.rasi
    sudo mkdir -p $MPS_FOLDER_THEMES
    sudo cp -r $MPS_ROFI_CFG/themes/* $MPS_FOLDER_THEMES
    sudo chown "$USER":"$USER" -R ~/mps/snippets
    sudo chown "$USER":"$USER" -R ~/.config
}
function listall {
    echo "${ALL[@]}"
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
