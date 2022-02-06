#!/bin/bash

FILES="vimrc zshrc gitconfig"

for f in $FILES; do
	mv $f $f.old
	cp ~/.$f $f
done

# cat ibus-env >> /etc/environment
# cp ~/.config/qutebrowser/config.py .
