#!/bin/bash

THEFILE=""
if [[ $# -eq 0 ]] ; then
    for f in ~/.ssh/*.pub; do cat "$f" ; done
else
    while (( "$#" )); do
        case "$1" in
            *)
                THEFILE=$1
                shift 1
                ;;
        esac
    done
    if [ -f "$HOME/.ssh/$THEFILE.pub" ] ; then
        cat "$HOME/.ssh/$THEFILE.pub"
    elif [ -f "$HOME/.ssh/id_rsa_$THEFILE.pub" ] ; then
        cat "$HOME/.ssh/id_rsa_$THEFILE.pub"
    else
        echo "No pubkey available"
    fi
fi

