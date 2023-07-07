#!/bin/sh

THEME_FOLDER=/usr/share/rofi/themes
THEME_NAME=rofi-boot-launcher.rasi

rofi -modi drun,run,window,filebrowser,ssh,keys -show drun \
    -theme $THEME_FOLDER/$THEME_NAME
