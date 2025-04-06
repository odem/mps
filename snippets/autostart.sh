#!/bin/bash

# Kill old instances
SNIPPETS=~/mps/snippets
"$SNIPPETS"/autostart_clean.sh

# Setup X
PRIMARY_DISPLAY=DP-4
SECONDARY_DISPLAY=HDMI-0
xrandr --output "$PRIMARY_DISPLAY" --primary --auto --mode 3840x2160 --pos 0x0 --rotate normal \
    --output "$SECONDARY_DISPLAY" --mode 1920x1080 --pos 3840x1080 --rotate normal 
xset s off &
xset -dpms &
xset r rate 250 50 &
setxkbmap de &

# dconf settings
dconf load / <~/.config/dconf/config.ini

# Tray apps and daemons
COMPOSITOR=picom
NETMON=nm-applet
DUNST=dunst
VOLMON=volumeicon
SCRATCHTERM=tilda
SYSMON=gnome-system-monitor
POLKIT=lxpolkit
MAILTRAY=birdtray
ALL="$COMPOSITOR $NETMON $VOLMON $DUNST $SCRATCHTERM $SYSMON $POLKIT $MAILTRAY"
# for comp in "${ALL[@]}"; do
#     "$comp" &
# done
"$COMPOSITOR" &
"$NETMON" &
"$VOLMON" &
"$DUNST" &
"$SCRATCHTERM" &
"$SYSMON" "$POLKIT" &
"$MAILTRAY" &
#
# Trigger resurrect plugin (tmux) with dummy session
#kitty bash -c "tmux start-server; tmux new-session -d -s autostart ; sleep 3"
#kitty bash -c "tmux kill-session -t autostart"

# Default tmux sessions
#kitty bash -c "tmux new-session -d -s scratchpad -c ~/mps/scratch"
kitty bash -c "tmuxinator start scratchpad &"
