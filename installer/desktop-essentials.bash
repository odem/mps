#!/bin/bash
# --- Packages ----------------------------------------------------------------
REQ="galculator numlockx xclip arandr lxappearance psutils iw xcwd"
WMTOOLS="feh lightdm picom xbacklight "
TERM="kitty tilda ssh-askpass"
SOUND="pulseaudio pavucontrol volumeicon-alsa libmpg123-dev"
ICONS="lxde-icon-theme gnome-extra-icons"
OSTOOLS="dconf-cli dconf-editor"
GNOME="gnome-system-monitor network-manager-gnome gnome-screenshot"
TXT="gedit gedit-plugins"
XORG="xorg xserver-xorg-video-nouveau xserver-xorg-video-vesa xterm"
OGL="mesa-utils freeglut3-dev "
XLIBS="libglm-dev libao-dev libxinerama-dev libxft-dev libglu1-mesa-dev"
FULL="$REQ $WMTOOLS $TERM $SOUND $ICONS $OSTOOLS $TXT $XORG $OGL $XLIBS $GNOME"
IFS=', ' read -r -a ALL <<< "$FULL"
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
    # === packages ===
    sudo -E apt --yes install "${ALL[@]}"
    sudo update-alternatives --set x-terminal-emulator /usr/bin/kitty
    sudo chsh -s /bin/bash "$USER"
    sudo service dbus enable
}
function do_uninstall() {
    # === packages ===
    sudo -E apt --yes remove "${ALL[@]}"
}
function do_configure() {
    # === copy files ===
    sudo chown "$USER":"$USER" -R ~
    sudo chmod u+w -R ~/.config
    cp -r dotfiles/.config/* ~/.config
    cp dotfiles/.gtkrc-2.0 ~
    cp snippets/autostart.sh ~/mps/snippets
    cp snippets/autostart_clean.sh ~/mps/snippets
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
