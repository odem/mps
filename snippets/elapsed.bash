#!/bin/bash

if [[ $# -ge 1 ]] ; then
    start_time=$(date +%s)
    bash -c "$*"
    end_time=$(date +%s)
    echo "Time elapsed: $(($end_time - $start_time)) seconds"
fi
