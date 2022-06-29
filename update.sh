#!/bin/bash

FILES=(
    vimrc zshrc gitconfig
    p10k.zsh
    tmux.conf
    config/qutebrowser/config.py
)

for f in ${FILES[@]}; do
    cp --interactive --preserve=mode ~/.$f $f
done
