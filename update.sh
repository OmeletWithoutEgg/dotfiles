#!/bin/bash
cd "$(dirname "$0")"

FILES=(
    vimrc zshrc zshenv
    p10k.zsh
    tmux.conf
    config/git/config
    config/qutebrowser/config.py
    vim/UltiSnips/tex.snippets

    config/nvim/init.lua
    config/nvim/lua/lsp.lua
    config/nvim/lua/plugins.lua

    config/doom/config.el
    config/doom/custom.el
    config/doom/init.el
    config/doom/lisp/markdown-agda-mode.el
    config/doom/packages.el
)

if [[ -n `git status -s -uall` ]]; then
    git status
    exit
fi

for f in ${FILES[@]}; do
    echo "cp ~/.$f $f"
    cp --preserve=mode ~/.$f $f
done
