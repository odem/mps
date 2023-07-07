#!/bin/sh
THEMEFILE=/usr/share/rofi/themes/rofi-boot-dwmswitch.rasi
{
echo "[]= Tiled                        Layout	0"
echo "><> Floating                     Layout	1"
echo "[M] Monocle                      Layout	2"
echo "TTT BottomStack    (Vertical)    Layout	3"
echo "=== BottomStack    (Horizontal)  Layout	4"
echo "|M| CenteredMaster (Default)     Layout	5"
echo ">M> CenteredMaster (Floating)    Layout	6"
} | cat |rofi -dmenu -theme $THEMEFILE | tail -c 2
