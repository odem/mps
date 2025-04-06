#!/bin/bash

DEFAULT_SESSION=scratch
DEFAULT_DIR="$HOME/mps/scratch"
DEFAULT_CMD=""
[[ $# -eq 1 ]] && DEFAULT_CMD=$1
[[ $# -eq 2 ]] && DEFAULT_DIR=$1 && DEFAULT_CMD=$2
[[ $# -eq 3 ]] && DEFAULT_SESSION=$1 && DEFAULT_DIR=$2 && DEFAULT_CMD=$3

HAS_SESSION=$(tmux ls | grep -c "${DEFAULT_SESSION}: ")
if [[ $HAS_SESSION -eq 0 ]] ; then
    tmux new -d -s "$DEFAULT_SESSION"
    tmux send  "cd $DEFAULT_DIR" ENTER
    tmux send  "$DEFAULT_CMD" ENTER
    tmux attach -t "$DEFAULT_SESSION"
else
    tmux attach -t "$DEFAULT_SESSION"
fi

