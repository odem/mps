#!/bin/sh


# Force always
#xrandr -s 1680x1050 &
#xrandr -s 1920x1080 &
#feh --image-bg black

# dconf settings
dconf dump / | tee ~/.config/dconf/config.ini

COMPOSITOR=picom
NETMON=nm-applet
VOLMON=volumeicon
SCRATCHTERM=tilda
SYSMON=gnome-system-monitor
POLKIT=lxpolkit
MAILTRAY=birdtray
ALL="$COMPOSITOR $NETMON $VOLMON $SCRATCHTERM $SYSMON $POLKIT $MAILTRAY"
for comp in $ALL
do
    killall $comp
done
