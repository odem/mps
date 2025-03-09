#!/bin/bash

if [[ $# -eq 2 ]] ; then
    sudo find "$1" -type f -name "$2" 2>/dev/null | fzf
else
    echo "Only $# arguments. Please give two arguments: DIR EXPRESSION"
fi
