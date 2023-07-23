#!/bin/bash

if [[ $# -eq 2 ]] ; then
    sudo find "$1" -type f -nowarn -exec grep -l "$2" {} \; 2>/dev/null | fzf
fi
