#!/bin/bash
# --- Packages ----------------------------------------------------------------
OFFICE="firefox-esr thunderbird birdtray gsimplecal evince keepass2 gparted"
GVFS="gvfs gvfs-backends gvfs-fuse"
MMEDIA="vlc thunar-media-tags-plugin mumble"
THUNAR="thunar thunar-data thunar-volman thunar-gtkhash file-roller "
THUNAREXTRA="thunar-vcs-plugin thunar-archive-plugin"
XFCE="xfce4-goodies xfce4-places-plugin"
IFS=', ' read -r -a ALL <<< "$OFFICE $MMEDIA $THUNAR $THUNAREXTRA $XFCE $GVFS"
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
    echo "Nothing to configure. All fine..."
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
