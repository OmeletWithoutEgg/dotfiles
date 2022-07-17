#!/bin/bash
cd "$(dirname "$0")"

FILES=(
    vimrc zshrc gitconfig
    p10k.zsh
    tmux.conf
    config/qutebrowser/config.py
)

if [[ -n `git status -s -uall` ]]; then
    git status
    exit
fi

for f in ${FILES[@]}; do
    echo "cp ~/.$f $f"
    cp --preserve=mode ~/.$f $f
done
