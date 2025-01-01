#!/bin/bash
SUMMARY=$2
BODY=$3
ICON=$4
URGENCY=$5
if [[ "$URGENCY" == "CRITICAL" ]]; then
    zenity --warning --timeout=0 \
        --width=640 --height=480 \
        --icon-name="$ICON" \
        --title="Critical Alert: $SUMMARY" \
        --text="<u><b>Critical Message: $SUMMARY</b></u>\n$BODY"
fi

