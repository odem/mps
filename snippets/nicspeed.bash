#!/bin/bash

for iface in /sys/class/net/*; do
    SPEED=$(ethtool "$(basename $iface)" 2>/dev/null | grep -i "Speed:" | awk '{print $2}')
    [ -z "$SPEED" ] && SPEED="Unknown"
    printf "%-20s\t%s\n" "$(basename $iface):" "$SPEED"
done

