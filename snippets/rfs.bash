#!/bin/bash

if [[ $# -eq 2 ]] ; then
    sudo find "$1" -type f -exec grep -l "$2" {} \;
fi
