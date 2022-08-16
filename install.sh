#!/bin/bash
cd "$(dirname "$0")"

warn() {
    printf "\033[33m"
    printf "$@"
    printf "\033[0m\n"
}

if [[ -n `git status -s -uall` ]]; then
    git status
    warn "GIT STATUS IS NOT CLEAN :("
    exit
fi

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

if [[ $SHELL  != "/usr/bin/zsh" ]]; then
    echo "chsh /usr/bin/zsh"
    chsh -s /usr/bin/zsh
fi

if [[ ! -d "$HOME/.zi" ]]; then
    mkdir -p "$HOME/.zi" && chmod g-rwX "$HOME/.zi"
    git clone --depth=1 \
        --branch "main" https://github.com/z-shell/zi "$HOME/.zi/bin"
fi

if [[ ! -d "$HOME/.tmux/plugins/tpm" ]]; then
    mkdir -p "$HOME/.tmux/plugins/"
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

CREATE_DIRS=(
    config/git
    config/python
    vim/UltiSnips
)

FILES=(
    $(find -type f -not -path '*/\.git*' -printf '%P\n' \
        | grep -v -P "(install\\.sh|update\\.sh|reflector\\.conf|README\\.md)")
)

for d in ${CREATE_DIRS[@]}; do
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
