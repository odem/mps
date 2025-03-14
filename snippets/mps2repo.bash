#!/bin/bash

REPO=/opt/mps
HOMECONFIG=~/.config
HOMESNIPPETS=~/mps/snippets
HOMESKELETONS=~/mps/skeletons
REPOSNIPPETS=$REPO/snippets
REPOSKELETONS=$REPO/skeletons
REPODOTFILES=$REPO/dotfiles
REPOCONFIG=$REPODOTFILES/.config

# Copy Snippets
cp "$HOMESNIPPETS"/* "$REPOSNIPPETS"/

# Copy Skeletons
cp -r "$HOMESKELETONS"/* "$REPOSKELETONS"/

# Copy bashrc stuff
cp ~/.bashrc "$REPODOTFILES"/.bashrc
cp ~/.common_alias.sh "$REPODOTFILES"/.common_alias.sh
cp ~/.custom_alias.sh "$REPODOTFILES"/.custom_alias.sh
cp ~/.zshrc "$REPODOTFILES"/.zshrc
cp ~/.bashrc_colors "$REPODOTFILES"/.bashrc_colors
cp ~/.bashrc_distro "$REPODOTFILES"/.bashrc_distro
cp ~/.bashrc_prompt "$REPODOTFILES"/.bashrc_prompt

# Copy .config
cp -r "$HOMECONFIG"/birdtray-config.json "$REPOCONFIG"/birdtray-config.json
cp -r "$HOMECONFIG"/mimeapps.list "$REPOCONFIG"/mimeapps.list
cp -r "$HOMECONFIG"/picom.conf "$REPOCONFIG"/picom.conf
cp -r "$HOMECONFIG"/dconf/* "$REPOCONFIG"/dconf
cp -r "$HOMECONFIG"/gedit/* "$REPOCONFIG"/gedit
cp -r "$HOMECONFIG"/gtk-2.0/* "$REPOCONFIG"/gtk-2.0
cp -r "$HOMECONFIG"/gtk-3.0/* "$REPOCONFIG"/gtk-3.0
cp -r "$HOMECONFIG"/dunst/* "$REPOCONFIG"/dunst
cp -r "$HOMECONFIG"/kitty/* "$REPOCONFIG"/kitty
cp -r "$HOMECONFIG"/neofetch/* "$REPOCONFIG"/neofetch
cp -r "$HOMECONFIG"/nvim/* "$REPOCONFIG"/nvim
cp -r "$HOMECONFIG"/qtile/* "$REPOCONFIG"/qtile
cp -r "$HOMECONFIG"/rofi/* "$REPOCONFIG"/rofi
cp -r "$HOMECONFIG"/Thunar/* "$REPOCONFIG"/Thunar
cp -r "$HOMECONFIG"/tilda/* "$REPOCONFIG"/tilda
cp -r "$HOMECONFIG"/tmux/tmux.conf "$REPOCONFIG"/tmux
cp -r "$HOMECONFIG"/tmux/tmux.conf.local "$REPOCONFIG"/tmux
cp -r "$HOMECONFIG"/volumeicon/* "$REPOCONFIG"/volumeicon
