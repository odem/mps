#!/bin/bash
SKELDIR=~/mps/skeletons
if [[ $# -eq 1 ]] ; then
    NAME=$1
    DEST=.
fi
if [[ $# -eq 2 ]] ; then
    NAME=$1
    DEST=$2
fi
if [[ -f "$SKELDIR/$NAME" ]] ; then
    cp "$SKELDIR/$NAME" "$DEST"
else
    echo "'$NAME' skeleton does not exist in template-dir ($SKELDIR)"
fi
