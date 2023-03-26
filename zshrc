# Helper function
function @include {
    [[ -r $1 ]] && source $1
}

function @replace {
    local lhs=$1; shift
    while (( $# > 0 )); do
        local rhs=$1; shift
        if command -v ${rhs%% *} >/dev/null 2>/dev/null; then
            alias $lhs=$rhs
            return 0
        fi
    done
}

# ZI plugin manager
@include "$HOME/.zi/bin/zi.zsh"
autoload -Uz _zi
(( ${+_comps} )) && _comps[zi]=_zi
# ZI cheatsheet:
### zi update / zi self-update / zi delete --clean
### zi ice OPTIONS / zi load / zi light / zi OPTIONS for

zi ice as:theme depth:1
zi load "romkatv/powerlevel10k"

zi wait lucid for \
    atinit:"ZI[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
        "z-shell/fast-syntax-highlighting" \
    blockf atpull:"zi creinstall zsh-users/zsh-completions"\
        "zsh-users/zsh-completions" \
    atload:"!_zsh_autosuggest_start" \
        "zsh-users/zsh-autosuggestions" \
        "zpm-zsh/ls" \
        "le0me55i/zsh-extract" \
        "agkozak/zsh-z"

# zi wait lucid for z-shell/zui z-shell/zi-console

zi snippet OMZ::lib/history.zsh
zi snippet OMZP::command-not-found # to update: pkgfile -u

# https://github.com/ThiefMaster/zsh-config/blob/master/zshrc.d/completion.zsh
# Use ls-colors for path completions
if [[ -z "$LS_COLORS" ]]; then
    (( $+commands[dircolors] )) && eval "$(dircolors -b)"
fi
zstyle ":completion:*" list-colors ${(s.:.)LS_COLORS}
unset LS_COLORS

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
@include "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"

@include /usr/share/fzf/key-bindings.zsh
### usage: Ctrl+T / Alt+C / Ctrl+R

# # History config
# HISTSIZE=10000
# SAVEHIST=10000
# HISTFILE=~/.zsh_history

# Aliases & functions
alias regmount="sudo mount -t ntfs3 -o gid=users,fmask=113,dmask=002"
alias gst="git status"
alias gdf="git diff"
alias v=nvim

@replace rm "trash" "rm -i"
@replace du "dust"
@replace df "duf"

function open {
    xdg-open $@ 2>/dev/null && sleep 1
}

function l. {
    setopt no_nomatch
    ls -dl .* $@
}

function latex-template {
    if [[ $# -ne 1 || -z $1 ]]; then
        echo "usage: latex-template <dirname>"
        return 1
    elif [[ -d $1 ]] then
        echo "$1 exists"
        return 1
    fi
    cp -r ~/Templates/LaTeX $1 && echo $1 generated
}

function ipinfo {
    echo "Wireless :: IP => $( ip -4 -o a show wlo1 | awk '{ print $4 }' )"
    echo "External :: IP => $( curl --silent https://ifconfig.me )"
}

function cpp-precompile {
    echo "Note: will need permission of header dirs"
    local cppflags=(-g -std=c++17 -Dlocal -Ofast -Wall -Wextra -Wshadow -Wconversion -Wfatal-errors -fsanitize=undefined,address)
    for header in "bits/stdc++.h" "bits/extc++.h"; do
        local p=$(echo "#include <$header>" | g++ -x c++ -H - 2>&1 | grep "$header" | tail -1)
        echo "precompile $p"
        sudo g++ $p $cppflags
    done
}

function tls-check {
    curl --no-progress-meter $@ >/dev/null || return
    for u in $@; do
        echo $u; echo | openssl s_client -connect $u:443 2>/dev/null \
            | openssl x509 -noout -dates
    done
}

function nvm-enable {
    export NVM_DIR="$XDG_DATA_HOME"/nvm
    source /usr/share/nvm/init-nvm.sh # yay -S nvm
}

function pacman-history {
    history -i | grep -P "(pacman|yay) (-S|-Rs)" | sed "s/sudo //g" | vim - +
}

set -o vi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
@include ~/.p10k.zsh
