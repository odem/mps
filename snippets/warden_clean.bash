#!/bin/bash

if [[ -f ~/.cache/kpm.session ]] ; then
    echo "Deleting active session"
    rm ~/.cache/kpm.session
else
    echo "No session active"
fi

