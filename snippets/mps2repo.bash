#!/bin/bash

REPO=~/mps/repo/github/odem/mps
HOMECONFIG=~/.config
REPODOTFILES=$REPO/dotfiles
REPOCONFIG=$REPO/dotfiles/.config
HOMESNIPPETS=~/mps/snippets
REPOSNIPPETS=$REPO/snippets

# Copy Snippets
cp $HOMESNIPPETS/* $REPOSNIPPETS/

# Copy bashrc stuff
cp ~/.bashrc $REPODOTFILES/.bashrc
cp ~/.bashrc_alias $REPODOTFILES/.bashrc_alias
cp ~/.bashrc_colors $REPODOTFILES/.bashrc_colors
cp ~/.bashrc_distro $REPODOTFILES/.bashrc_distro
cp ~/.bashrc_prompt $REPODOTFILES/.bashrc_prompt

# Copy .config
cp -r $HOMECONFIG/birdtray-config.json $REPOCONFIG/birdtray-config.json
cp -r $HOMECONFIG/mimeapps.list $REPOCONFIG/mimeapps.list
cp -r $HOMECONFIG/picom.conf $REPOCONFIG/picom.conf
cp -r $HOMECONFIG/dconf/* $REPOCONFIG/dconf
cp -r $HOMECONFIG/gedit/* $REPOCONFIG/gedit
cp -r $HOMECONFIG/gtk-2.0/* $REPOCONFIG/gtk-2.0
cp -r $HOMECONFIG/gtk-3.0/* $REPOCONFIG/gtk-3.0
cp -r $HOMECONFIG/KeePass/* $REPOCONFIG/KeePass
cp -r $HOMECONFIG/kitty/* $REPOCONFIG/kitty
cp -r $HOMECONFIG/neofetch/* $REPOCONFIG/neofetch
cp -r $HOMECONFIG/nvim/* $REPOCONFIG/nvim
cp -r $HOMECONFIG/nvim/* $REPOCONFIG/nvim
cp -r $HOMECONFIG/qtile/* $REPOCONFIG/qtile
cp -r $HOMECONFIG/rofi/* $REPOCONFIG/rofi
cp -r $HOMECONFIG/Thunar/* $REPOCONFIG/Thunar
cp -r $HOMECONFIG/tilda/* $REPOCONFIG/tilda
cp -r $HOMECONFIG/tmux/* $REPOCONFIG/tmux
cp -r $HOMECONFIG/volumeicon/* $REPOCONFIG/volumeicon
cp -r $HOMECONFIG/xfce4/* $REPOCONFIG/xfce4
