#!/bin/sh


# Force always
#xrandr -s 1680x1050 &
#xrandr -s 1920x1080 &
#feh --image-bg black

COMPOSITOR=picom
NETMON=nm-applet
VOLMON=volumeicon
SCRATCHTERM=tilda 
SYSMON=gnome-system-monitor
POLKIT=lxpolkit
ALL="$COMPOSITOR $NETMON $VOLMON $SCRATCHTERM $SYSMON $POLKIT"
for comp in $ALL
do
    killall $comp
done
