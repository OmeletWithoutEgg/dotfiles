#!/bin/bash
cd "$(dirname "$0")"

COPY_DIRS=(
    config/nvim/
    config/doom/
)

FILES=(
    vimrc zshrc zshenv
    p10k.zsh
    tmux.conf
    config/git/config
    config/fontconfig/fonts.conf
    config/qutebrowser/config.py
    vim/UltiSnips/tex.snippets
)

if [[ -n `git status -s -uall` ]]; then
    git status
    exit
fi

for f in ${FILES[@]}; do
    echo "cp ~/.$f $f"
    cp --preserve=mode ~/.$f $f
done

for d in ${COPY_DIRS[@]}; do
    echo "rsync -r -v ~/.$d $d"
    rsync -r -v ~/.$d $d
done
