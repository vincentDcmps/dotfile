#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi
nvidia-settings --load-config-only &
export SSH_AUTH_SOCK
numlockx &
picom -b &
#config pad
python /home/vincent/script/xinput.py
#   exec dbus-launch i3 
case $1 in
        i3  ) exec dbus-launch i3;;
        *   )  exec $1;;
esac
#exec openbox
# exec gnome-session
# exec startkde
# exec startxfce4
# ...or the Window Manager of your choice

