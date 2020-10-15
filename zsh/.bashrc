# If not running interactively, don't do anything
[[ $- != *i* ]] && return

[ -x /usr/local/bin/zsh ] && exec /usr/local/bin/zsh
[ -x /usr/bin/zsh ] && exec /usr/bin/zsh
