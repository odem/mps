#!/bin/bash
# Set lightdm background
WP_LIGHTDM=/opt/mps/dotfiles/.config/images/wallpaper/wormhole.jpg
echo "background=$WP_LIGHTDM" | sudo tee -a /etc/lightdm/lightdm-gtk-greeter.conf

