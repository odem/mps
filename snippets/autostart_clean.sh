#!/bin/bash


# Force always
#xrandr -s 1680x1050 &
#xrandr -s 1920x1080 &
#feh --image-bg black

# dconf settings
dconf dump / > ~/.config/dconf/config.ini

# Kill tmux sessions
~/mps/snippets/warden_clean.bash
tmuxinator stop citmux
tmuxinator stop scratchpad
tmux kill-server

# Kill Desktop stuff
COMPOSITOR=picom
NETMON=nm-applet
VOLMON=volumeicon
#SCRATCHTERM=tilda
SYSMON=gnome-system-monitor
POLKIT=lxpolkit
MAILTRAY=birdtray
ALL="$COMPOSITOR $NETMON $VOLMON $SYSMON $POLKIT $MAILTRAY"
for comp in "${ALL[@]}"
do
    killall "$comp" 2>&1 /dev/null
done

