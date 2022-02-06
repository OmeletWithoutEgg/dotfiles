#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


export PS1="\[\033[36m\]\u\[\033[m\]@ \[\033[33;1m\]\w\[\033[m\] (\$(git branch 2>/dev/null | grep '^*' | colrm 1 2)) \$ "

set -o vi
alias ls='ls --color=auto'
# PS1='[\u@\h \W]\$ '
export PATH="/home/nasa/.bin/:$PATH"
enable -n pwd
