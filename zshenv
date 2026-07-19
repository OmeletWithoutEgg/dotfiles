export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

typeset -U PATH
export EDITOR=vim
export PATH="$HOME"/.local/bin:"$XDG_CONFIG_HOME"/emacs/bin:$PATH
export TIME_STYLE='+%Y-%m-%d %H:%M:%S'

if command -v bat >/dev/null 2>&1; then
    BATCAT=bat
else
    BATCAT=batcat
fi
export MANPAGER="sh -c 'col -bx | $BATCAT -l man -p'" # https://github.com/sharkdp/bat#man
export MANROFFOPT="-c"

# Configuration of fd & fzf
if command -v fd >/dev/null 2>&1; then
    FDFIND=fd
else
    FDFIND=fdfind
fi
export FD_OPTIONS="--color=always"
export FZF_DEFAULT_OPTS_FILE="$XDG_CONFIG_HOME"/fzf/config
export FZF_DEFAULT_COMMAND="$FDFIND --type f --type l --color=always"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="$FDFIND --type d --color=always"
export FZF_CTRL_R_OPTS="--bind='ctrl-y:execute-silent(echo -n {2..} | wl-copy)+abort'"

export ZSHZ_DATA="$XDG_DATA_HOME/z"

export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME"/ripgrep/rc

export CARGO_HOME="$XDG_DATA_HOME"/cargo
export GOPATH="$XDG_DATA_HOME"/go
export GHCUP_USE_XDG_DIRS=true
export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker
export LESSHISTFILE="$XDG_CACHE_HOME"/less/history
export NODE_REPL_HISTORY="$XDG_DATA_HOME"/node_repl_history
export TEXMFVAR="$XDG_CACHE_HOME"/texlive/texmf-var
export TEXMFHOME="$XDG_DATA_HOME"/texmf
export PYTHON_HISTORY="$XDG_STATE_HOME"/python_history
export PYENV_ROOT="$XDG_DATA_HOME"/pyenv
export AWS_SHARED_CREDENTIALS_FILE="$XDG_CONFIG_HOME"/aws/credentials
export AWS_CONFIG_FILE="$XDG_CONFIG_HOME"/aws/config
export ANDROID_HOME="$XDG_DATA_HOME"/android
export JUPYTER_CONFIG_DIR="$XDG_CONFIG_HOME"/jupyter
export PARALLEL_HOME="$XDG_CONFIG_HOME"/parallel
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java
export BUNDLE_USER_CONFIG="$XDG_CONFIG_HOME"/bundle
export BUNDLE_USER_CACHE="$XDG_CACHE_HOME"/bundle
export BUNDLE_USER_PLUGIN="$XDG_DATA_HOME"/bundle
export MYSQL_HISTFILE="$XDG_STATE_HOME"/mariadb_history
export DOT_SAGE="$XDG_CONFIG_HOME"/sage
export PSQL_HISTORY="$XDG_DATA_HOME/psql_history"
export STACK_XDG=1
export RUFF_CACHE_DIR="$XDG_CACHE_HOME/ruff"
export MAXIMA_USERDIR="$XDG_CONFIG_HOME"/maxima
export VAGRANT_HOME="$XDG_DATA_DIR/vagrant"
# export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc
export NPM_CONFIG_INIT_MODULE="$XDG_CONFIG_HOME"/npm/config/npm-init.js
export NPM_CONFIG_CACHE="$XDG_CACHE_HOME"/npm
# export NPM_CONFIG_TMP="$XDG_RUNTIME_DIR"/npm

export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc

export RBENV_ROOT="$XDG_DATA_HOME"/rbenv
export IRBRC="$XDG_CONFIG_HOME"/irb/irbrc

export XCURSOR_PATH=${XCURSOR_PATH}:"$XDG_DATA_HOME"/icons:/usr/share/icons

export SDL_VIDEODRIVER=wayland # https://github.com/ppy/osu/issues/33918

# ibus environment variable
# export GTK_IM_MODULE="ibus"
# export QT_IM_MODULE="ibus"
# export XMODIFIERS="@im=ibus"

# export GTK_IM_MODULE=fcitx
# export QT_IM_MODULE=fcitx
# export XMODIFIERS=@im=fcitx

export ELECTRON_OZONE_PLATFORM_HINT=wayland
export COMPOSE_BAKE=true
export QT_QPA_PLATFORM="wayland;xcb"
# export ELECTRON_OZONE_PLATFORM_HINT="auto"
export GDK_SCALE=2

export TPS_TASK_TEMPLATES_PATH="$XDG_DATA_HOME"/tps/task-templates

# https://discuss.kde.org/t/how-to-force-enable-hdr-on-plasma-6-3-4/32458
export KWIN_FORCE_ASSUME_HDR_SUPPORT=1

export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
