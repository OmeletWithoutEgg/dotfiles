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

### Zinit's installer
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [[ ! -f $ZINIT_HOME/zinit.zsh ]]; then
  print -P "%F{33}%F{220}Installing zdharma-continuum/zinit ...%f"
  command mkdir -p "$(dirname "$ZINIT_HOME")" && command chmod g-rwX "$(dirname "$ZINIT_HOME")"
  if command git clone https://github.com/zdharma-continuum/zinit "$ZINIT_HOME"; then
    print -P "%F{33}%F{34}Installation successful.%f%b"
  else
    print -P "%F{160}The clone has failed.%f%b"
  fi
fi

typeset -A ZINIT=(ZCOMPDUMP_PATH "${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zcompdump")

source "$ZINIT_HOME/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit's installer chunk

# ZI cheatsheet:
### zi update / zi self-update / zi delete --clean
### zi ice OPTIONS / zi load / zi light / zi OPTIONS for

# zi lucid \
#     bpick'*linux-x86_64-v*' from'gh-r' as'program' \
#     pick'bin/exa' atclone'cp -vf completions/exa.zsh _exa' \
#     light-mode for @ogham/exa

zi ice as:theme depth:1
zi load "romkatv/powerlevel10k"

zi lucid for \
  "zpm-zsh/ls" \
  "agkozak/zsh-z"

zi wait lucid for \
  atinit:"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
    "zdharma-continuum/fast-syntax-highlighting" \
  blockf atpull:"zi creinstall zsh-users/zsh-completions"\
    "zsh-users/zsh-completions" \
  atload:"!_zsh_autosuggest_start" \
    "zsh-users/zsh-autosuggestions"

# zi wait lucid for z-shell/zui z-shell/zi-console

zi snippet OMZ::lib/history.zsh
zi snippet OMZP::command-not-found # to update: pkgfile -u
zi snippet OMZP::extract

# if command -v elan >/dev/null 2>/dev/null; then
#   eval $(elan completions zsh)
# fi

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
bindkey -r -M viins '\ec'

# # History config
HISTSIZE=1000000
SAVEHIST=1000000
# HISTFILE=~/.zsh_history

# Aliases & functions
alias regmount="sudo mount -t ntfs3 -o gid=users,fmask=113,dmask=002"
alias gst="git status"
alias gdf="git diff"
alias pgrep="pgrep -a"
alias v=nvim
alias t=task

@replace rm "trash" "rm -i"
@replace mv "mv -i"
@replace du "dust"
@replace df "duf -hide-fs tmpfs"

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
  cp -r ~/Templates/LaTeX "$1" && echo "$1" generated
}

function ipinfo {
  echo "Wireless :: IP => $( ip -4 -o a show wlo1 | awk '{ print $4 }' )"
  echo "External :: IP => $( curl --silent https://ifconfig.me )"
}

function cpp-precompile {
  echo "Note: will need permission of header dirs"
  local cppflags=(-std=gnu++20 -g -Dlocal -Ofast -Wall -Wextra -Wshadow -Wconversion -Wfatal-errors -fsanitize=undefined,address -DCKISEKI)
  for header in "bits/stdc++.h" "bits/extc++.h"; do
    local p=$(echo "#include <$header>" | g++ -x c++ -H - 2>&1 | grep "$header" | tail -1)
    echo "precompile $p"
    sudo g++ "$p" ${cppflags[@]}
  done
}

function tls-check {
  curl --no-progress-meter $@ >/dev/null || return
  for u in $@; do
    echo "$u"
    echo \
      | openssl s_client -connect "$u:443" 2>/dev/null \
      | openssl x509 -noout -dates 2>/dev/null
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
export KEYTIMEOUT=1

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
@include ~/.p10k.zsh
