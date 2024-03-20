#!/bin/bash
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
    wget -qO - https://hub.unity3d.com/linux/keys/public \
        | gpg --dearmor \
        | sudo tee /usr/share/keyrings/Unity_Technologies_ApS.gpg > /dev/null
    sudo sh -c \
        'echo "deb [signed-by=/usr/share/keyrings/Unity_Technologies_ApS.gpg] https://hub.unity3d.com/linux/repos/deb stable main" > /etc/apt/sources.list.d/unityhub.list'
    sudo apt update
    sudo apt-get install unityhub
    wget -qO code.deb https://go.microsoft.com/fwlink/?LinkID=760868
    sudo dpkg -i code.deb
    rm code.deb
    wget https://dot.net/v1/dotnet-install.sh -O dotnet-install.sh
    chmod a+x ./dotnet-install.sh
    ./dotnet-install.sh --version latest
    rm dotnet-install.sh

}
function do_uninstall() {
    # === packages ===
    echo "Nothing to uninstall. Please do it manually... :-("
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
        echo ""
        ;;
     *)
        echo "Not a valid target: $1"
        ;;
esac

