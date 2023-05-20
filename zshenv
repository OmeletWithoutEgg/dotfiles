export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

export EDITOR=vim
export PATH="$HOME"/.local/bin:"$XDG_CONFIG_HOME"/emacs/bin:$PATH

export MANPAGER="sh -c 'col -bx | bat -l man -p'" # https://github.com/sharkdp/bat#man

# Configuration of fd & fzf
# export FD_OPTIONS="--follow --hidden --exclude .git --exclude node_modules --strip-cwd-prefix --color=always"
export FD_OPTIONS="--color=always"
export FZF_DEFAULT_OPTS="--ansi --reverse --multi --preview='fzf-preview.sh {}' \
    --preview-window='right:hidden:60%:wrap' \
    --bind='ctrl-a:toggle-preview,ctrl-y:execute(echo {+} | copy.sh)+abort' \
    --bind='ctrl-f:page-down,ctrl-b:page-up' \
    --bind='ctrl-d:preview-page-down,ctrl-u:preview-page-up'"
# export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
#     --color=fg:#CCCCCC,bg:#18191E,hl:#FFFF00
#     --color=fg+:#FFEE79,bg+:#21252D,hl+:#ED722E
#     --color=info:#D68EB2,prompt:#50C16E,pointer:#FFFF00
#     --color=marker:#FC2929,spinner:#FF4D00,header:#1D918B'
export FZF_DEFAULT_COMMAND="fd --type f --type l $FD_OPTIONS"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type d $FD_OPTIONS"
export FZF_CTRL_R_OPTS="--bind='ctrl-y:execute(echo {+} | copy.sh --history)+abort'"

export _Z_DATA="$XDG_DATA_HOME/z"

export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME"/ripgrep/rc

export CARGO_HOME="$XDG_DATA_HOME"/cargo
export GOPATH="$XDG_DATA_HOME"/go
export GHCUP_USE_XDG_DIRS=true
export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker
export LESSHISTFILE="$XDG_CACHE_HOME"/less/history
export NODE_REPL_HISTORY="$XDG_DATA_HOME"/node_repl_history
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc
export TEXMFVAR="$XDG_CACHE_HOME"/texlive/texmf-var
export TEXMFHOME="$XDG_DATA_HOME"/texmf
export PYTHONSTARTUP="$XDG_CONFIG_HOME"/python/pythonrc
export PYENV_ROOT="$XDG_DATA_HOME"/pyenv
export AWS_SHARED_CREDENTIALS_FILE="$XDG_CONFIG_HOME"/aws/credentials
export AWS_CONFIG_FILE="$XDG_CONFIG_HOME"/aws/config
export ANDROID_HOME="$XDG_DATA_HOME"/android
export JUPYTER_CONFIG_DIR="$XDG_CONFIG_HOME"/jupyter

export XCURSOR_PATH=${XCURSOR_PATH}:"$XDG_DATA_HOME"/icons:/usr/share/icons

# ibus environment variable
export GTK_IM_MODULE="ibus"
export QT_IM_MODULE="ibus"
export XMODIFIERS="@im=ibus"

# export QT_QPA_PLATFORM="wayland"
# export QT_QPA_PLATFORM="wayland;xcb"

export TPS_TASK_TEMPLATES_PATH="$XDG_DATA_HOME"/tps/task-templates

SSH_AGENT_PID=`pgrep -U $USER -o 'ssh-agent'`
if [ -z $SSH_AGENT_PID ]; then
    eval $(ssh-agent -s)
    # ssh-add ~/.ssh/id_rsa
else
    SSH_AGENT_SOCK=`find /tmp -user $USER -path '*ssh*' -type s -iname 'agent.'$(($SSH_AGENT_PID-1)) 2>/dev/null`
    export SSH_AGENT_PID="$SSH_AGENT_PID"
    export SSH_AUTH_SOCK="$SSH_AGENT_SOCK"
fi
# https://myapollo.com.tw/zh-tw/ssh-agent-autostart/
