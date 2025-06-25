#!/bin/sh

THEME_FOLDER=/usr/share/rofi/themes
THEME_NAME=rofi-boot-powermenu.rasi

CMD=sudo
DISTRO=$(lsb-release -si)
if [ "$DISTRO" = "Arch" ] ; then
    CMD=gksudo
else
    CMD="sudo -A"
    export SUDO_ASKPASS=$(which ssh-askpass)
fi
chosen=$(printf "Power Off\nRestart\nLogout\nLock Screen\n" | rofi -dmenu -theme "$THEME_FOLDER/$THEME_NAME")
case "$chosen" in
        "Power Off")    /usr/sbin/poweroff ;;
        "Restart")      /usr/sbin/reboot ;;
        "Logout")       kill -9 -1 ;;
        "Lock Screen")  physlock ;;
        *)              false ;;
esac
