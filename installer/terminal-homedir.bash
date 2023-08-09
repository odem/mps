#!/bin/bash
# --- Packages ----------------------------------------------------------------
DEFAULT="neofetch openssh-client"
IFS=', ' read -r -a ALL <<< "$DEFAULT"
# --- Folders ----------------------------------------------------------------
MPS_ROOT=~/mps
MPS_ROOT_DISKS=/media/disks
MPS_FOLDERS="scratch snippets iso repo tools vm disks docs wsp secrets venv vpn"
MPS_SYMLINKS=""
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
}
function do_uninstall() {
    # === packages ===
    sudo -E apt --yes remove "${ALL[@]}"
}
function do_configure() {
    # === dotfiles ===
    mkdir -p ~/.config
    cp dotfiles/.bashrc* ~
    cp -r dotfiles/.config/tmux -t ~/.config/
    cp -r dotfiles/.config/neofetch -t ~/.config/
    # === skeletons ===
    mkdir -p ~/mps/skeletons
    cp skeletons/* ~/mps/skeletons
    # === keypair ===
    [[ -f ~/.ssh/id_rsa ]] || \
        echo "y" | ssh-keygen -f ~/.ssh/id_rsa -t rsa -N '' 1>/dev/null
    # === folders ===
    mkdir -p ~/.local/bin
    for mpsdir in $MPS_FOLDERS ; do
        mkdir -p "$MPS_ROOT/$mpsdir" ;
        echo "Creating folder: '$mpsdir'"
    done
    # === symlinks ===
    if [ ! "$MPS_SYMLINKS" = "" ] ; then
        cd "$MPS_ROOT/disks/" || exit 1
        for drives in $MPS_SYMLINKS ; do
            rm "$MPS_ROOT/disks/$drives"
            ln -s "$MPS_ROOT_DISKS/$drives" .
        done
        cd - || exit 1
    fi
    # === snippets ===
    cp snippets/* $MPS_ROOT/snippets
    chmod a+x $MPS_ROOT/snippets/*
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
