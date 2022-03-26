#!/bin/bash

FILES="vimrc zshrc gitconfig"

check() {
    if ! command -v $1; then
        echo "Please Remember to install $1"
        exit
    fi
}

echo "SHELL=$SHELL"
check vim
check zsh
check git
check curl

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim -es -u vimrc -i NONE -c "PlugInstall" -c "qa"

chsh -s /usr/bin/zsh
if [[ ! -d ~/.zi ]]; then
    mkdir -p "$HOME/.zi" && chmod g-rwX "$HOME/.zi"
    git clone -q --depth=1 \
        --branch "main" https://github.com/z-shell/zi "$HOME/.zi/bin"
fi

for f in $FILES; do
    cp $f ~/.$f
done

# cat ibus-env >> /etc/environment
# cp .config.py ~/.config/qutebrowser/
# cp ibus-daemon.desktop ~/.config/autostart/
# chmod +x ~/.config/autostart/ibus-daemon.desktop
