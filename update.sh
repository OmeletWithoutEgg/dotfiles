#!/bin/bash

FILES="vimrc zshrc gitconfig"

for f in $FILES; do
	cp ~/.$f $f
done

# cat ibus-env >> /etc/environment
cp ~/.config/qutebrowser/config.py qutebrowser/config.py
