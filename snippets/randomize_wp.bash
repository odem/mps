#!/bin/bash

IMGFOLDER=~/.config/images
WPFOLDER=~/.config/images/wallpaper

CHOSEN=$(find $WPFOLDER -type f | shuf -n 1)
cp "$CHOSEN" $IMGFOLDER/wallpaper.jpg
echo "New wallpaper: $CHOSEN"

feh --no-fehbg --bg-scale $IMGFOLDER/wallpaper.jpg &



