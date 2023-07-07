#!/bin/sh

# Kill old instances
SNIPPETS=~/mps/snippets
$SNIPPETS/autostart_clean.sh

# Force always
#xrandr -s 1680x1050 &
#xrandr -s 1920x1080 &
xrandr --output DP-1 --primary --auto --mode 1920x1080 --pos 0x0 --rotate normal \
    --output HDMI-1 --mode 1920x1080 --pos 1920x0 --rotate normal

xset s off &
#xset -dpms &
xset dpms 36000 36000 36000 &
xset r rate 250 50 &
setxkbmap de &
#feh --bg-scale ~/.config/images/wallpaper.jpg &

# Tray apps and daemons
COMPOSITOR=picom
NETMON=nm-applet
VOLMON=volumeicon
SCRATCHTERM=tilda
SYSMON=gnome-system-monitor
POLKIT=lxpolkit
MAILTRY=birdtry
ALL="$COMPOSITOR $NETMON $VOLMON $SCRATCHTERM $SYSMON $POLKIT $BIRDTRAY"
for comp in $ALL
do
    $comp &
done
