# Environment variables
export EDITOR=vim
export PATH=$HOME/.local/bin:$PATH

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
    blockf atpull:"zi creinstall -q ."\
        "zsh-users/zsh-completions" \
    atload:"!_zsh_autosuggest_start" \
        "zsh-users/zsh-autosuggestions" \
        "zpm-zsh/ls" \
        "le0me55i/zsh-extract" \

# zi wait lucid for z-shell/zui z-shell/zi-console

zi snippet OMZ::lib/history.zsh

# https://github.com/ThiefMaster/zsh-config/blob/master/zshrc.d/completion.zsh
# Use ls-colors for path completions
if [[ -z "$LS_COLORS" ]]; then
    (( $+commands[dircolors] )) && eval "$(dircolors -b)"
fi
zstyle ":completion:*" list-colors ${(s.:.)LS_COLORS}

# autoload -Uz compinit

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
@include "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"

@include /usr/share/doc/pkgfile/command-not-found.zsh # to update: pkgfile -u

# # History config
# HISTSIZE=10000
# SAVEHIST=10000
# HISTFILE=~/.zsh_history

# Aliases & functions
alias regmount="sudo mount -t ntfs3 -o gid=users,fmask=113,dmask=002"
@replace rm "trash" "rm -i"
@replace du "dust"
@replace df "duf"
function open {
    xdg-open $@ 2>/dev/null && sleep 1
}
function l. {
    ls $@ -d .*
}
function latex-template {
    if [[ -z $1 ]]; then
        echo "usage: latex-template <dirname>"
        return 1
    fi
    cp -r ~/Templates/LaTeX $1
}
function ipinfo {
    echo "Wireless :: IP => $( ip -4 -o a show wlo1 | awk '{ print $4 }' )"
    echo "External :: IP => $( curl --silent https://ifconfig.me )"
}
function cpp-precompile {
    echo "Note: needs permission of header dirs"
    local cppflags=("-std=c++17" "-Dlocal" "-Ofast" "-Wfatal-errors" "-fsanitize=undefined,address")
    for header in "bits/stdc++.h" "bits/extc++.h"; do
        local p=$(echo "#include <$header>" | g++ -x c++ -H - 2>&1 | grep "$header" | tail -1)
        echo "precompile $p"
        g++ $p $cppflags
    done
}

set -o vi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
@include ~/.p10k.zsh
