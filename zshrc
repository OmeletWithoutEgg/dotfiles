# Environment variables
export EDITOR=vim
export PATH=$HOME/.local/bin:$PATH

# Helper function
function @include {
    for file in $@; do
        if [[ -r $file ]]; then
            source $file
        fi
    done
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
if [[ ! -f $HOME/.zi/bin/zi.zsh ]]; then
  print -P "%F{33}▓▒░ %F{160}Installing (%F{33}z-shell/zi%F{160})…%f"
  command mkdir -p "$HOME/.zi" && command chmod g-rwX "$HOME/.zi"
  command git clone -q --depth=1 --branch "main" https://github.com/z-shell/zi "$HOME/.zi/bin" && \
    print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
    print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi
source "$HOME/.zi/bin/zi.zsh"
autoload -Uz _zi
(( ${+_comps} )) && _comps[zi]=_zi
# ZI cheatsheet:
### zi update / zi self-update / zi delete --clean
### zi ice OPTIONS / zi load / zi light / zi OPTIONS for

zi ice as:theme depth:1
zi load "romkatv/powerlevel10k"


zi wait lucid for \
    "zdharma-continuum/fast-syntax-highlighting" \
    atload:"_zsh_autosuggest_start" \
    "zsh-users/zsh-autosuggestions" \
    blockf atpull:"zi creinstall -q ." atinit:"zicompinit; zicdreplay" \
    "zsh-users/zsh-completions" \
    "zpm-zsh/ls" \
    "le0me55i/zsh-extract" \
# zi wait lucid for z-shell/zui z-shell/zi-console

zi snippet OMZ::lib/history.zsh
# zi snippet OMZ::lib/completion.zsh
# zi snippet OMZ::lib/theme-and-appearance.zsh

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

set -o vi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
@include ~/.p10k.zsh
