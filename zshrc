# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

if [[ ! -d ~/.zplug ]]; then
  git clone https://github.com/zplug/zplug ~/.zplug
fi
source ~/.zplug/init.zsh

# History config
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

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

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export EDITOR=vim
# export PATH=$HOME/.local/bin:$PATH
alias rm='trash'
# alias open='xdg-open'
alias regmount='sudo mount -o gid=users,fmask=113,dmask=002'
# mount -o gid=users,fmask=113,dmask=002 /dev/sda1 /mnt/toshiba
function open() {
    xdg-open $@ 2>/dev/null && sleep 1
}
function l.() {
    ls $@ -d .*
}

set -o vi
source /usr/share/doc/pkgfile/command-not-found.zsh # to update: pkgfile -u
