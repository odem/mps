#!/bin/bash
# --- Read opt ----------------------------------------------------------------
MPS_USER=mps
MPS_PASS=mps
while (( "$#" )); do
    case "$1" in
        "-u")
            MPS_USER=$2
            shift 2
            ;;
        "-p")
            MPS_PASS=$2
            shift 2
            ;;
        *)
            echo "Unknown option: '${OPTARG}'"
            echo "Aborting..."
            exit 1
            ;;
    esac
done

# Bootstrap
./installer/bootstrap-user.bash -u "$MPS_USER" -p "$MPS_PASS"

# terminal config as root
sudo -u "root" ./installer/terminal-essentials.bash -a configure
sudo -u "root" ./installer/terminal-homedir.bash -a configure
sudo -u "root" ./installer/terminal-fonts.bash -a configure
sudo -u "root" ./installer/terminal-vim.bash -a configure
sudo -u "root" ./installer/terminal-nvim.bash -a configure

# terminal
sudo -u "$MPS_USER" ./installer/terminal-essentials.bash
sudo -u "$MPS_USER" ./installer/terminal-homedir.bash
sudo -u "$MPS_USER" ./installer/terminal-fonts.bash
sudo -u "$MPS_USER" ./installer/terminal-vim.bash
sudo -u "$MPS_USER" ./installer/terminal-nvim.bash


# desktop
sudo -u "$MPS_USER" ./installer/desktop-essentials.bash
sudo -u "$MPS_USER" ./installer/desktop-guitools.bash
sudo -u "$MPS_USER" ./installer/desktop-rofi.bash
sudo -u "$MPS_USER" ./installer/desktop-qtile.bash
sudo -u "$MPS_USER" ./installer/desktop-extras.bash
sudo -u "$MPS_USER" ./installer/extras-spotify.bash


# Set boot splash
WP_GRUB=dotfiles/.config/images/bootsplash.png
sudo cp "$WP_GRUB" /boot/grub/bootsplash.png
sudo chmod 644 /boot/grub/bootsplash.png
echo 'GRUB_GFXMODE=1280x800' | sudo tee -a /etc/default/grub
echo 'GRUB_BACKGROUND="/boot/grub/bootsplash.png"' | sudo tee -a /etc/default/grub
sudo update-grub

# Set lightdm background
WP_LIGHTDM=/opt/mps/dotfiles/.config/images/wallpaper/wormhole.jpg
echo "background=$WP_LIGHTDM" | sudo tee -a /etc/lightdm/lightdm-gtk-greeter.conf

