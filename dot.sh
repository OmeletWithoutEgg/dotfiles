#!/bin/bash

cd "$(dirname "$0")" || exit

EXCLUDE_FILES=(
    dot.sh
    reflector.conf
    README.md
    screenshot.png
    bashrc
    simple-vimrc
)

function get_find_opt {
    printf -- "-not -path ./%s " "${EXCLUDE_FILES[@]}"
    cat <<EOF
-not -path '*/\.git*'
-not -path '*/dconf\.d*'
-printf '%P\n'
EOF
}

FILES=()
while IFS='' read -r line; do
    FILES+=("$line")
done < <(get_find_opt | xargs find -type f)

MKDIRS=()
while IFS='' read -r line; do
    MKDIRS+=("$line")
done < <(get_find_opt | xargs find -depth -type d)

# echo "${FILES[@]}"
# echo "${MKDIRS[@]}"
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
    echo "$@"
    printf "\033[0m"
}

function info {
    printf "\033[32m"
    echo "$@"
    printf "\033[0m"
}

function confirm {
    while true; do
        read -r -p "${*} ? [y/n]: " yn
        case $yn in
            [Yy]* ) return 0;;
            [Nn]* ) return 1;;
            * ) echo "Please answer yes or no.";;
        esac
    done
}

function check_git_status() {
    if [[ -n $(git status -s -uall) ]]; then
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
        echo "download vim-plug and install plugins"
        curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
            "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
        vim -es -u vimrc -i NONE -c "PlugInstall" -c "qa"
    fi

    if [[ $SHELL != "/usr/bin/zsh" ]]; then
        echo "chsh -s /usr/bin/zsh"
        chsh -s /usr/bin/zsh
    fi

    info "run 'exec zsh' to install zsh plugins with zinit"
    
    # if [[ ! -d "$HOME/.zi" ]]; then
    #     mkdir -p "$HOME/.zi" && chmod g-rwX "$HOME/.zi"
    #     git clone --depth=1 \
    #         --branch "main" https://github.com/z-shell/zi "$HOME/.zi/bin"
    # fi

    if [[ ! -d "$HOME/.tmux/plugins/tpm" ]]; then
        mkdir -p "$HOME/.tmux/plugins/"
        git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    fi

    for d in "${MKDIRS[@]}"; do
        if [ ! -d "$HOME/.$d" ]; then
            if confirm "mkdir -p ~/.$d"; then
                mkdir -p "$HOME/.$d"
            fi
        fi
    done

    for f in "${FILES[@]}"; do
        local t="$HOME/.$f"
        if [ ! -d "$(dirname "$t")" ]; then
            warn "Parent directory $(dirname "$t") does not exist."
        elif diff -q "$f" "$t" >/dev/null 2>/dev/null; then
            echo "File $f not changed"
        elif [ -r "$t" ]; then
            cp --interactive --preserve=mode "$f" "$t"
        elif [ "$(basename "$f")" == "$f" ]; then
            if confirm "cp $f ~/.$f"; then
                cp --preserve=mode "$f" "$t"
            fi
        else
            info "cp $f ~/.$f"
            cp --preserve=mode "$f" "$t"
        fi
    done

    # for e in ${DCONF_ENTRIES[@]}; do
    #     cat dconf.d/$e
    #     if confirm "dconf load /$e/ < dconf.d/$e"; then
    #         dconf load /$e/ < dconf.d/$e
    #     fi
    # done
}

function update {
    info "UPDATE"
    check_git_status
    for d in "${CPDIRS[@]}"; do
        local t="$HOME/.$d"
        info "mkdir -p $d/"
        mkdir -p "$d/"
        info "cp -r ~/.$d/* $d/"
        cp -r --preserve=mode "$t"/* "$d/"
    done

    for f in "${FILES[@]}"; do
        local t="$HOME/.$f"
        if [ -r "$t" ]; then
            info "cp ~/.$f $f"
            cp --preserve=mode "$t" "$f"
        fi
    done

    for e in "${DCONF_ENTRIES[@]}"; do
        local -r dir=$(dirname dconf.d/"$e")
        info "mkdir -p $dir"
        mkdir -p "$dir"
        info "dconf dump /$e/ > dconf.d/$e"
        dconf dump "/$e/" > "dconf.d/$e"
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
# vim:ts=4:sts=4:sw=4
