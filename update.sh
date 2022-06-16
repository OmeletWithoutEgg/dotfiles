#!/bin/bash

FILES="vimrc zshrc gitconfig"

for f in $FILES; do
	cp ~/.$f $f
done

cp ~/.config/qutebrowser/config.py config/qutebrowser/config.py
