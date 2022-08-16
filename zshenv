export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

export EDITOR=vim
export PATH="$XDG_CONFIG_HOME"/emacs/bin:$PATH

# Configuration of fd & fzf
export FZF_PREVIEW_COMMAND=' [[ ! -r {} ]] && echo {} || \
    ([[ $(file --mime {}) =~ binary ]] \
        && (catimg -w 150 {} 2>/dev/null || echo {} is a binary file) \
        || bat --style=numbers -f {}) '

export FD_OPTIONS="--follow --hidden --exclude .git --exclude node_modules --strip-cwd-prefix --color=always"
export COPY_COMMAND="xclip -sel c"

export FZF_DEFAULT_OPTS="--ansi --reverse --multi --preview='$FZF_PREVIEW_COMMAND' --preview-window='right:hidden:60%:wrap' \
    --bind='f2:toggle-preview,ctrl-y:execute(echo {+} | $COPY_COMMAND && echo {+})+abort' \
    --bind='ctrl-d:half-page-down,ctrl-u:half-page-up' \
    --bind='ctrl-n:preview-page-down,ctrl-p:preview-page-up'"
# export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
#     --color=fg:#CCCCCC,bg:#18191E,hl:#FFFF00
#     --color=fg+:#FFEE79,bg+:#21252D,hl+:#ED722E
#     --color=info:#D68EB2,prompt:#50C16E,pointer:#FFFF00
#     --color=marker:#FC2929,spinner:#FF4D00,header:#1D918B'
export FZF_DEFAULT_COMMAND="fd --type f --type l $FD_OPTIONS"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type d $FD_OPTIONS"

export CARGO_HOME="$XDG_DATA_HOME"/cargo
export GOPATH="$XDG_DATA_HOME"/go
export GHCUP_USE_XDG_DIRS=true
export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker
export LESSHISTFILE="$XDG_CACHE_HOME"/less/history
export NODE_REPL_HISTORY="$XDG_DATA_HOME"/node_repl_history
export TEXMFVAR="$XDG_CACHE_HOME"/texlive/texmf-var
export PYTHONSTARTUP="$XDG_CONFIG_HOME"/python/pythonrc
export PYENV_ROOT="$XDG_DATA_HOME"/pyenv

export XCURSOR_PATH=${XCURSOR_PATH}:"$XDG_DATA_HOME"/icons

# ibus environment variable
export GTK_IM_MODULE="ibus"
export QT_IM_MODULE="ibus"
export XMODIFIERS="@im=ibus"

# export QT_QPA_PLATFORM="wayland"
