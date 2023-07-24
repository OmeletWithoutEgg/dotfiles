#!/bin/bash

if [[ $# -ne 1 ]]; then
    echo "wrong number of param"
    echo "$@"
    exit 3
fi

file=$1

if [[ ! -r $file ]]; then
    echo "$file"
elif [[ $(file --mime "$file") =~ binary ]]; then
    echo "$file is a binary file"
    # TODO imgcat or something like that
else
    bat --style=numbers -f "$file"
fi
