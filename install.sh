#!/bin/bash

FILES="vimrc zshrc gitconfig"

if ! command -v vim zsh; then
    echo "Remember to install vim, zsh"
    exit
fi

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim -es -u vimrc -i NONE -c "PlugInstall" -c "qa"

chsh -s /usr/bin/zsh
if [[ ! -d ~/.zplug ]]; then
    curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
fi

for f in $FILES; do
	cp $f ~/.$f
done

# cat ibus-env >> /etc/environment
# cp .config.py ~/.config/qutebrowser/
# cp ibus-daemon.desktop ~/.config/autostart/
# chmod +x ~/.config/autostart/ibus-daemon.desktop
