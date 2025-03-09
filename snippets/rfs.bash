#!/bin/bash

if [[ $# -eq 2 ]] ; then
    sudo find "$1" -type f -name "$2" | fzf
fi
