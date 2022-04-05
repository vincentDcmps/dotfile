# If not running interactively, don't do anything
[[ $- != *i* ]] && return

[ -x /usr/local/bin/zsh ] && exec /usr/local/bin/zsh
[ -x /usr/bin/zsh ] && exec /usr/bin/zsh

source /home/vincent/.config/broot/launcher/bash/br
if [ -x /usr/bin/nomad]; then
complete -C /usr/bin/nomad nomad
fi
