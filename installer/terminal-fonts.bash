#!/bin/bash
# --- Packages ----------------------------------------------------------------
DEFAULT="fonts-font-awesome fonts-fork-awesome wget unzip"
IFS=', ' read -r -a ALL <<< "$DEFAULT"
# --- Font-URLs ---------------------------------------------------------------
FONTDIR=/opt/mps/tools/fonts
FONTS_URL_AWESOME=https://use.fontawesome.com/releases/v6.2.1/fontawesome-free-6.2.1-desktop.zip
FONTS_URL_JETBRAINS=https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/JetBrainsMono.zip
FONTS_URL_MONOID=https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/Monoid.zip
FONTS_URL_SYMBOLS=https://github.com/microsoft/vscode-codicons/releases/download/0.0.36/codicon.ttf
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
    # === packages ===
    sudo -E apt --yes install "${ALL[@]}"
}
function do_uninstall() {
    # === packages ===
    sudo -E apt --yes remove "${ALL[@]}"
}
function do_configure() {
    # === prepare ===
    sudo rm -rf "$FONTDIR"
    rm -rf ~/.local/share/fonts
    sudo mkdir -p "$FONTDIR"
    # === Awesome ===
    if [[ ! -d $FONTDIR/Awesome/ ]] ; then
        sudo wget "$FONTS_URL_AWESOME" -O "$FONTDIR"/Awesome.zip
        sudo unzip "$FONTDIR"/Awesome.zip -d "$FONTDIR"/Awesome/
        sudo cp "$FONTDIR"/Awesome/fontawesome-free-6.2.1-desktop/otfs/*.otf \
            "$FONTDIR"/Awesome/
        sudo rm -rf "$FONTDIR"/Awesome.zip
        sudo rm -rf "$FONTDIR"/Awesome/fontawesome-free-6.2.1-desktop/
    fi
    # === Monoid ===
    if [[ ! -d $FONTDIR/Monoid/ ]] ; then
        sudo wget "$FONTS_URL_MONOID" -O "$FONTDIR"/Monoid.zip
        sudo unzip "$FONTDIR"/Monoid.zip -d "$FONTDIR"/Monoid
        sudo rm -rf "$FONTDIR"/Monoid.zip
    fi
    # === JetBrainsMono ===
    if [[ ! -d $FONTDIR/JetBrainsMono/ ]] ; then
        sudo wget "$FONTS_URL_JETBRAINS" -O "$FONTDIR"/JetBrainsMono.zip
        sudo unzip "$FONTDIR"/JetBrainsMono.zip \
            -d "$FONTDIR"/JetBrainsMono
        sudo rm -rf "$FONTDIR"/JetBrainsMono.zip
    fi
    # === Symbols ===
    if [[ ! -d $FONTDIR/codicon/ ]] ; then
        sudo mkdir "$FONTDIR"/codicon/
        sudo wget "$FONTS_URL_SYMBOLS" -O "$FONTDIR"/codicon/codicon.ttf
    fi
    # === Deploy ===
    mkdir -p ~/.local/share/fonts
    sudo cp -r "$FONTDIR"/* ~/.local/share/fonts
    sudo chown "$USER":"$USER" -R ~/.local/share/fonts
    fc-cache -f -v
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
