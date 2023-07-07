#!/bin/bash

# Configure
LANGUAGES="python c shell "
COMMANDS="git tar"

# Chosen default languages or commands
if [[ $# -eq 0 ]] ; then
    LANGUAGES=`echo "$LANGUAGES" | tr ' ' '\n'`
    COMMANDS=`echo "$COMMANDS" | tr ' ' '\n'`
    selected=`printf "$COMMANDS\n$LANGUAGES\n" | fzf`
else
    selected=$1
fi

# Exit if nothing selected
if [[ -z $selected ]] ; then
    exit 1
fi

# Chose query
if [[ $# -le 1 ]] ; then
    read -p "Enter Query: " query
    query=`echo $query | tr ' ' '+'`
else
    shift
    query=$*
fi

# Query and print
curled=`curl -s cht.sh/$selected/$query`
printf "$curled" | less -R
