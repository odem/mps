#!/bin/bash
# --- Packages ----------------------------------------------------------------
REQUIRED="meson glslang-tools "
MESA="libgl1-mesa-dri:i386 mesa-vulkan-drivers mesa-vulkan-drivers:i386"
WINE="wine winetricks wine64 wine32 goverlay mangohud gamemode steam"
SOUND="libasound2-plugins:i386"
LIBS="libsdl2-2.0-0:i386 libdbus-1-3:i386 libsqlite3-0:i386"
NVLIBS="nvidia-driver nvidia-driver-libs:i386"
VKLIBS="nvidia-vulkan-icd:i386 nvidia-vulkan-common:i386 libvulkan1 libvulkan1:i386"
OCLLIBS="nvidia-opencl-common:i386"
GCCLIB="gcc-multilib g++-multilib"
FULL="$REQUIRED $MESA $WINE $SOUND $LIBS $GCCLIB $NVLIBS $VKLIBS $OCLLIBS"
IFS=', ' read -r -a ALL <<< "$FULL"
# --- Prepare Environment -----------------------------------------------------
DXVK_URL="https://github.com/doitsujin/dxvk.git"
DXVK_REPODIR=/opt/mps/tools/dxvk
LUTRIS_DEB="http://download.opensuse.org/repositories/home:/strycore/Debian_12/"
LUTRIS_SOURCES="/etc/apt/sources.list.d/home:strycore.list"
LUTRIS_KEY="https://download.opensuse.org/repositories/home:strycore/Debian_12/Release.key"
LUTRIS_KEYFOLDER="/etc/apt/trusted.gpg.d/home_strycore.gpg"
LUTRIS_RUNTIME="$HOME/.local/share/lutris/runtime/dxvk"
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
    sudo sed 's/main/main contrib non-free/g' -i /etc/apt/sources.list
    sudo -E apt update && sudo -E apt upgrade
    sudo -E dpkg --add-architecture i386
    sudo -E apt update && sudo -E apt upgrade
    sudo -E apt --yes remove xserver-xorg-video-nouveau
    sudo -E apt --yes install "${ALL[@]}"

    echo "deb $LUTRIS_DEB /" | sudo tee $LUTRIS_SOURCES
    curl -fsSL $LUTRIS_KEY | gpg --dearmor \
        | sudo tee $LUTRIS_KEYFOLDER > /dev/null
    sudo -E apt --yes update
    sudo -E apt --yes install lutris

    sudo update-alternatives --set x86_64-w64-mingw32-gcc /usr/bin/x86_64-w64-mingw32-gcc-posix
    sudo update-alternatives --set x86_64-w64-mingw32-g++ /usr/bin/x86_64-w64-mingw32-g++-posix
    sudo update-alternatives --set i686-w64-mingw32-gcc /usr/bin/i686-w64-mingw32-gcc-posix
    sudo update-alternatives --set i686-w64-mingw32-g++ /usr/bin/i686-w64-mingw32-g++-posix

    #sudo rm -rf $DXVK_REPODIR
    if [[ ! -d "$DXVK_REPODIR" ]] ; then
        sudo mkdir -p "$DXVK_REPODIR"
        sudo git clone --recursive "$DXVK_URL" "$DXVK_REPODIR"
        cd "$DXVK_REPODIR" || exit 1
        sudo mkdir build
        sudo ./package-release.sh master build --no-package
        cd - || exit 1
        mkdir -p "$LUTRIS_RUNTIME"
        sudo cp -r "$DXVK_REPODIR"/build/dxvk-master "$LUTRIS_RUNTIME"
        sudo chown "$USER":"$USER" -R ~/.local/share/lutris
    fi



#!/bin/sh
# Create and switch to a temporary directory writeable by current user. See:
#   https://www.tldp.org/LDP/abs/html/subshells.html
cd "$(mktemp -d)" || exit 1

# Use a BASH "here document" to create an updater shell script file.
# See:
#   https://www.tldp.org/LDP/abs/html/here-docs.html
# >  outputs stdout to a file, overwriting any pre-existing file
# << takes input, directly from the script itself, till the second '_EOF_SCRIPT' marker, as stdin
# the cat command hooks these 2 streams up (stdin and stdout)
###### create update_winetricks START ########
cat > update_winetricks <<_EOF_SCRIPT
#!/bin/sh

# Create and switch to a temporary directory writeable by current user. See:
#   https://www.tldp.org/LDP/abs/html/subshells.html
cd "\$(mktemp -d)"

# Download the latest winetricks script (master="latest version") from Github.
wget https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks

# Mark the winetricks script (we've just downloaded) as executable. See:
#   https://www.tldp.org/LDP/GNU-Linux-Tools-Summary/html/x9543.htm
chmod +x winetricks

# Move the winetricks script to a location which will be in the standard user PATH. See:
#   https://www.tldp.org/LDP/abs/html/internalvariables.html
sudo mv winetricks /usr/bin

# Download the latest winetricks BASH completion script (master="latest version") from Github.
wget https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks.bash-completion

# Move the winetricks BASH completion script to a standard location for BASH completion modules. See:
#   https://www.tldp.org/LDP/abs/html/tabexpansion.html
sudo mv winetricks.bash-completion /usr/share/bash-completion/completions/winetricks

# Download the latest winetricks MAN page (master="latest version") from Github.
wget https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks.1

# Move the winetricks MAN page to a standard location for MAN pages. See:
#   https://www.pathname.com/fhs/pub/fhs-2.3.html#USRSHAREMANMANUALPAGES
sudo mv winetricks.1 /usr/share/man/man1/winetricks.1
_EOF_SCRIPT
###### create update_winetricks FINISH ########

    # Mark the update_winetricks script (we've just written out) as executable. See:
    #   https://www.tldp.org/LDP/GNU-Linux-Tools-Summary/html/x9543.htm
    chmod +x update_winetricks

    # We must escalate privileges to root, as regular Linux users do not have write access to '/usr/bin'.
    sudo mv update_winetricks /usr/bin/
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

