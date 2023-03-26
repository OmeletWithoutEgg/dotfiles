#!/bin/bash
cd "$(dirname "$0")"

EXCLUDE_FILES=(
    dot.sh
    reflector.conf
    README.md
    bashrc
    simple-vimrc
)

function exclude_opt {
    for f in ${EXCLUDE_FILES[@]}; do
        printf -- "-not -path ./$f "
    done
}

FILES=(
    $(find -type f \
        -not -path '*/\.git*' \
        -not -path '*/dconf\.d*' \
        `exclude_opt` \
        -printf '%P\n')
)

MKDIRS=(
    $(find -depth -type d \
        -not -path '*/\.git*' \
        -not -path '*/dconf\.d*' \
        `exclude_opt` \
        -printf '%P\n')
)

# echo ${FILES[@]}
# echo ${MKDIRS[@]}
# exit

DCONF_ENTRIES=(
    desktop/ibus
    org/freedesktop/ibus/engine/anthy/common
)

CPDIRS=(
    config/nvim
    # config/doom
)

function warn {
    printf "\033[33m"
    printf "$@"
    printf "\033[0m\n"
}

function info {
    printf "\033[32m"
    printf "$@"
    printf "\033[0m\n"
}

function confirm {
    while true; do
        read -p "${@} ? [y/n]: " yn
        case $yn in
            [Yy]* ) return 0;;
            [Nn]* ) return 1;;
            * ) echo "Please answer yes or no.";;
        esac
    done
}

function check_git_status() {
    if [[ -n `git status -s -uall` ]]; then
        git status
        warn "**git status is not clean**"
        if ! confirm "continue"; then
            exit
        fi
    fi
}

function install {
    info "INSTALL"
    check_git_status
    echo "SHELL = $SHELL"
    for f in vim zsh git curl; do
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

    if [[ $SHELL != "/usr/bin/zsh" ]]; then
        echo "chsh -s /usr/bin/zsh"
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

    for d in ${MKDIRS[@]}; do
        if [ ! -d ~/.$d ]; then
            if confirm "mkdir -p ~/.$d"; then
                mkdir -p ~/.$d
            fi
        fi
    done

    for f in ${FILES[@]}; do
        if [ ! -d $(dirname $HOME/.$f) ]; then
            warn "Parent directory $(dirname $HOME/.$f) does not exist."
        elif diff -q $f ~/.$f >/dev/null 2>/dev/null; then
            echo "File $f not changed"
        else
            if [ -r $HOME/.$f ]; then
                cp --interactive --preserve=mode $f ~/.$f
            else
                info "cp $f ~/.$f"
                cp --preserve=mode $f ~/.$f
            fi
        fi
    done

    for e in ${DCONF_ENTRIES[@]}; do
        cat dconf.d/$e
        if confirm "dconf load /$e/ < dconf.d/$e"; then
            dconf load /$e/ < dconf.d/$e
        fi
    done
}

function update {
    info "UPDATE"
    check_git_status
    for d in ${CPDIRS[@]}; do
        info "mkdir -p $d/"
        mkdir -p $d/
        info "cp -r ~/.$d/* $d/"
        cp -r --preserve=mode ~/.$d/* $d/
    done

    for f in ${FILES[@]}; do
        if [ -r ~/.$f ]; then
            info "cp ~/.$f $f"
            cp --preserve=mode ~/.$f $f
        fi
    done

    for e in ${DCONF_ENTRIES[@]}; do
        local dir=`dirname dconf.d/$e`
        info "mkdir -p $dir"
        mkdir -p $dir
        info "dconf dump /$e/ > dconf.d/$e"
        dconf dump /$e/ > dconf.d/$e
    done
}

case "$@" in
    install|i)
        install
        exit
        ;;
    update|u)
        update
        exit
        ;;
    *)
        info "usage: "
        info "	$0 install"
        info "	$0 udpate"
        exit
esac

# cp reflector.conf /etc/xdg/reflector/reflector.conf
