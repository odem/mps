#!/bin/bash

# Kill old instances
SNIPPETS=~/mps/snippets
"$SNIPPETS"/autostart_clean.sh

# Force always
xrandr --output eDP-1 --mode 1920x1080 --primary --pos 0x0 --rotate normal \
    --output DP-1 --mode 3440x1440 --pos 1920x0 --rotate normal \
    --output HDMI-1 --off \
    --output DP-2 --off 
xset dpms 36000 36000 36000 &
xset dpms 0 0 0 &
xset s off &
xset s off -dpms &
xset r rate 250 50 &
setxkbmap de &

# dconf settings
dconf load / <~/.config/dconf/config.ini

# Tray apps and daemons
COMPOSITOR=picom
NETMON=nm-applet
VOLMON=volumeicon
SYSMON=gnome-system-monitor
#POLKIT=lxpolkit
MAILTRAY=birdtray

"$COMPOSITOR" &

"$NETMON" &
"$VOLMON" &
"$SYSMON" &
"$POLKIT" &
"$MAILTRAY" &


# Start tunnel
qtile cmd-obj -o group 6 -f toscreen
qtile run-cmd -f kitty bash -c "tmuxinator start 'cit'" &
sleep 1
qtile cmd-obj -o group 1 -f toscreen

