#!/bin/bash
cd "$(dirname "$0")"

DIRS=(
    config/git
    config/python
)

FILES=(
    vimrc zshrc zshenv
    p10k.zsh
    tmux.conf
    gnupg/gpg-agent.conf
    config/git/config
    config/python/pythonrc
    config/redshift/redshift.conf
    config/fontconfig/fonts.conf
    config/systemd/user/ibus.service
    config/qutebrowser/config.py
    config/qutebrowser/greasemonkey/youtube-autoskip.user.js
)

echo "SHELL=$SHELL"
for f in "vim zsh git curl"; do
    if ! command -v $f; then
        echo "Please remember to install $f"
        exit
    fi
done

if [[ ! -f "$HOME/.vim/autoload/plug.vim" ]]; then
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
    vim -es -u vimrc -i NONE -c "PlugInstall" -c "qa"
fi

echo "chsh /usr/bin/zsh"
chsh -s /usr/bin/zsh
if [[ ! -d "$HOME/.zi" ]]; then
    mkdir -p "$HOME/.zi" && chmod g-rwX "$HOME/.zi"
    git clone --depth=1 \
        --branch "main" https://github.com/z-shell/zi "$HOME/.zi/bin"
fi

if [[ ! -d "$HOME/.tmux/plugins/tpm" ]]; then
    mkdir -p "$HOME/.tmux/plugins/"
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

for d in ${DIRS[@]}; do
    echo "mkdir -p ~/.$d"
    mkdir -p ~/.$d
done

for f in ${FILES[@]}; do
    if [ -d `dirname $HOME/.$f` ]; then
        cp --interactive --preserve=mode $f ~/.$f
    else
        echo "Parent directory $(dirname $HOME/.$f) does not exist"
    fi
done

# cp reflector.conf /etc/xdg/reflector/reflector.conf
