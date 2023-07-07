#!/bin/bash

if [[ $# -eq 1 ]] ; then
    start_time=$(date +%s)
    $1
    end_time=$(date +%s)
    echo "Time elapsed: $(($end_time - $start_time)) seconds"
fi
