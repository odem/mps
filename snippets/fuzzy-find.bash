#!/bin/bash

FDCMD="fdfind -H -L -a"

if [[ $# -eq 0 ]] ; then
    export FZF_DEFAULT_COMMAND="$FDCMD ."
else
    while getopts ":o:" arg; do
        case $arg in
            o)
                FILEOPEN=$OPTARG
                ;;
        esac
    done
    shift $(($OPTIND-1))

    # Choose search root
    if [ -f $1 ] | [ -d $1 ] ; then
        FILE=$1
    else
        case "$1" in 
            "etc")
                FILE=/etc
                ;;
            "mps")
                FILE=$HOME/mps
                ;;
            "repo")
                FILE=$HOME/mps/repo
                ;;
            "*")
                exit 1
                ;;
        esac
    fi
fi

# Fuzzy find
export FZF_DEFAULT_COMMAND="$FDCMD . $FILE"
THEFILE=`fzf --bind shift-up:preview-page-up,shift-down:preview-page-down \
    --height=80 --min-height=10 --border=rounded \
    --info=inline --preview='batcat  --color=always --style=numbers {}'`

# Print or open result
if [[ -f $THEFILE ]] || [[ -d $THEFILE ]] ; then
    if [[ "$FILEOPEN" != "" ]] ; then
        $FILEOPEN $THEFILE
    else
        echo "$THEFILE"
    fi
fi

