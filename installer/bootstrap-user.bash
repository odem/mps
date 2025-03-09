#!/bin/bash
# --- Default Config ----------------------------------------------------------
DEFAULT="sudo lsb-release locales apt-utils"
IFS=', ' read -r -a ALL <<< "$DEFAULT"
ACTION=all
MPS_USER=dummy
MPS_PASS=dummy
# --- Prepare Environment -----------------------------------------------------
export DEBIAN_FRONTEND=noninteractive
USER=$(whoami)
if [ ! "$(id -u)" -eq 0 ] ; then
    echo "Please start as root"
    echo "Aborting..."
    exit 1
fi
# --- Read opt ----------------------------------------------------------------
while getopts "a:u:p:" o; do
    case "${o}" in
        a)
            ACTION=${OPTARG}
            ;;
        u)
            MPS_USER=${OPTARG}
            ;;
        p)
            MPS_PASS=${OPTARG}
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
    apt --yes update
    apt --yes upgrade
    apt --yes install "${ALL[@]}"
    apt --yes autoremove
}
function do_uninstall() {
    # === packages ===
    apt --yes remove "${ALL[@]}"
}
function do_configure() {
    # === Check params ===
    if [ "$MPS_USER" == "" ] || [ "$MPS_PASS" == "" ]  ; then
        echo "User or password empty: '$MPS_USER:$MPS_PASS' "
        echo "Aborting..."
        exit 3
    fi
    # === Add user ===
    echo "Adding user: $MPS_USER"
    TESTUSER=$(cat /etc/passwd | grep "$MPS_USER")
    if [[ "$TESTUSER" == "" ]] ; then
        useradd -s /bin/bash -m "$MPS_USER"
    fi
    # === Modify user ===
    TESTUSER=$(cat /etc/passwd | grep "$MPS_USER")
    if [[ "$TESTUSER" != "" ]] ; then
        usermod -aG sudo "$MPS_USER"
        touch /etc/sudoers.d/"$MPS_USER"
        echo "$MPS_USER ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/mps
        echo "${MPS_USER}:${MPS_PASS}" | chpasswd
        echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
        locale-gen
    fi
}
# --- Do action ---------------------------------------------------------------
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
        echo "Not a valid target: '$1'"
        echo "Aborting..."
        exit 4
        ;;
esac
