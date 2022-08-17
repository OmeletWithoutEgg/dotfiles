#!/bin/bash

abort() {
    echo "some thing wrong in copy.sh" 1>&2
}

while (( $# > 0 )); do
    case "$1" in
        --history)
            is_history=1
            ;;
        *)
            abort
    esac
    shift
done

while read line; do
    if [[ -n $is_history ]]; then
        line=`echo $line | awk '{ cmd=$0; sub(/^[ \t]*[0-9]+\**[ \t]+/, "", cmd); print cmd }'`
    fi
    echo $line | xclip -sel c && echo "Copied $line"
done
