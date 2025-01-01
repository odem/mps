#!/bin/bash

case "$1" in
    notify-send)
        # Example action: Open a terminal

        [[ -f $2 ]] && xdg-open "$2"
        ;;
    *)
        echo "Unknown action: $1"
        ;;
esac

