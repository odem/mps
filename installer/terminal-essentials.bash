#!/bin/bash
# --- Packages ----------------------------------------------------------------
ESSENTIALS="git tmux tmuxinator kitty python3 python3-pip lsb-release"
OS="debconf debconf-utils fontconfig neofetch figlet"
PS="psmisc psutils htop bpytop"
FILES="fd-find fzf bat exa tree ranger ncdu zoxide entr"
TRANSPORT="ca-certificates curl wget gnupg apt-utils apt-transport-https"
ARCHIVES="zip unzip bzip2 dtrx"
BASHUTILS="cowsay fortune fortunes-de cmatrix console-setup bash-completion"
BUILD="gcc gdb lldb build-essential check flex bison automake"
NETWORK="net-tools iptables tcpdump iw ssh nmap dnsutils"
IFS=', ' read -r -a ALL <<< "$ESSENTIALS $OS $PS $FILES $TRANSPORT $ARCHIVES $BASHUTILS $BUILD $NETWORK"
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
