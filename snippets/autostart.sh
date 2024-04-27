#!/bin/bash

# Kill old instances
SNIPPETS=~/mps/snippets
"$SNIPPETS"/autostart_clean.sh

# Force always
#xrandr -s 1680x1050 &
#xrandr -s 1920x1080 &
xrandr --output DP-2 --primary --auto --mode 3840x2160 --pos 0x0 --rotate normal \
    --output HDMI-0 --mode 1920x1080 --pos 3840x1080 --rotate normal

xset s off &
#xset -dpms &
xset dpms 36000 36000 36000 &
xset r rate 250 50 &
setxkbmap de &
#feh --bg-scale ~/.config/images/wallpaper.jpg &

# dconf settings
dconf load / <~/.config/dconf/config.ini

# Tray apps and daemons
COMPOSITOR=picom
NETMON=nm-applet
VOLMON=volumeicon
SCRATCHTERM=tilda
SYSMON=gnome-system-monitor
POLKIT=lxpolkit
MAILTRAY=birdtray
ALL="$COMPOSITOR $NETMON $VOLMON $SCRATCHTERM $SYSMON $POLKIT $MAILTRAY"
for comp in "${ALL[@]}"; do
    echo "$comp" #&
done
"$COMPOSITOR" &
"$NETMON" &
"$VOLMON" &
"$SCRATCHTERM" &
"$SYSMON" "$POLKIT" &
"$MAILTRAY" &

# Trigger resurrect plugin (tmux) with dummy session
#kitty bash -c "tmux start-server; tmux new-session -d -s autostart ; sleep 3"
#kitty bash -c "tmux kill-session -t autostart"

# Default tmux sessions
#kitty bash -c "tmux new-session -d -s scratchpad -c ~/mps/scratch"
kitty bash -c "tmuxinator start scratchpad &"
