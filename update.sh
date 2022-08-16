#!/bin/bash
cd "$(dirname "$0")"

warn() {
    printf "\033[33m"
    printf "$@"
    printf "\033[0m\n"
}

if [[ -n `git status -s -uall` ]]; then
    git status
    warn "GIT STATUS IS NOT CLEAN :("

    while true; do
        read -p "CONTINUE? [y/n]: " yn
        case $yn in
            [Yy]* ) break;;
            [Nn]* ) exit;;
            * ) echo "Please answer yes or no.";;
        esac
    done
fi

COPY_DIRS=(
    config/nvim
    config/doom
)

FILES=(
    $(find -type f -not -path '*/\.git*' -printf '%P\n' \
        | grep -v -P "(install\\.sh|update\\.sh|reflector\\.conf|README\\.md)")
)

for f in ${FILES[@]}; do
    echo "cp ~/.$f $f"
    cp --preserve=mode ~/.$f $f
done

for d in ${COPY_DIRS[@]}; do
    echo "rm -r $d/"
    rm -r $d/
    echo "cp -r ~/.$d/ $d/"
    cp -r --preserve=mode ~/.$d/ $d/
done
