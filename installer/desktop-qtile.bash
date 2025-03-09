#!/bin/bash
# --- Packages ----------------------------------------------------------------
PYTHON="python3-psutil python3-pip python-dbus-dev python3-pulsectl git"
PANGO="libpangocairo-1.0-0 python3-xcffib python3-cairocffi"
DESKTOP="lightdm lightdm-gtk-greeter"
X11="x11vnc tigervnc-standalone-server"
IFS=', ' read -r -a ALL <<< "$PYTHON $PANGO $X11 $DESKTOP"
IFS=', ' read -r -a QTILEPIP <<< "xcffib cairocffi"
# --- Folders -----------------------------------------------------------------
QTILE_FOLDER=/opt/mps/tools/qtile
MPS_QTILE_CFG=dotfiles/.config/qtile
QTILEURL=https://github.com/qtile/qtile
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
function do_install {
    # === packages ===
    sudo -E apt --yes install "${ALL[@]}"
    # === qtile ===
    pip3 install --no-cache-dir "${QTILEPIP[@]}" --break-system-packages
    pip install psutil --break-system-packages
    sudo chown "$USER":"$USER" ~
    sudo mkdir -p "$QTILE_FOLDER"
    sudo chown "$USER":"$USER" "$QTILE_FOLDER"
    if [[ "$(which qtile)" == "" ]] ; then
        git clone "$QTILEURL" "$QTILE_FOLDER"
        cd "$QTILE_FOLDER" || exit 1
        pip3 install . --break-system-packages
        cd - || exit 1
    fi
}
function do_uninstall {
    # === packages ===
    sudo -E apt --yes remove "${ALL[@]}"
    # === qtile ===
    pip3 uninstall "${QTILEPIP[@]}"
    pip uninstall psutil
}
function do_configure {
    # === config ===
    sudo mkdir -p /usr/share/xsessions
    sudo cp -r dotfiles/.local ~
    sudo cp -r dotfiles/.config/dconf ~/.config
    sudo cp -r dotfiles/.config/Thunar ~/.config
    sudo cp -r dotfiles/.config/gtk-2.0 ~/.config
    sudo cp -r dotfiles/.config/gtk-3.0 ~/.config
    sudo cp "$MPS_QTILE_CFG"/qtile.desktop /usr/share/xsessions/qtile.desktop
    sudo sed "s/dummy/$USER/g" -i /usr/share/xsessions/qtile.desktop
    mkdir -p ~/.config/qtile
    sudo cp "$MPS_QTILE_CFG"/config.py ~/.config/qtile/config.py
    sudo chown "$USER":"$USER" -R ~
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
