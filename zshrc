function @include() {
    for file in $@; do
        if [[ -r $file ]]; then
            source $file
        fi
    done
}

@include ~/.zplug/init.zsh || return

# zplug plugins
zplug "romkatv/powerlevel10k", as:theme, depth:1
zplug "zplug/zplug", hook-build:"zplug --self-manage"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-autosuggestions"
zplug "zdharma-continuum/fast-syntax-highlighting"
zplug "zpm-zsh/ls"
zplug "le0me55i/zsh-extract"

# Install packages that have not been installed yet
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    else
        echo
    fi
fi
zplug load

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
@include "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"

@include /usr/share/doc/pkgfile/command-not-found.zsh # to update: pkgfile -u

# History config
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

# Aliases & functions
export EDITOR=vim
export PATH=$HOME/.local/bin:$PATH

alias rm="trash"
alias regmount="sudo mount -t ntfs3 -o gid=users,fmask=113,dmask=002"
alias du="dust"
alias df="duf"
function open() {
    xdg-open $@ 2>/dev/null && sleep 1
}
function l.() {
    ls $@ -d .*
}
function latex-template() {
    if [[ -z $1 ]]; then
        echo "usage: latex-template <dirname>"
        return 1
    fi
    cp -r ~/Templates/LaTeX $1
}

set -o vi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
@include ~/.p10k.zsh
