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
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK
numlockx &
compton -b &
#config pad
xinput set-prop 13 289 1 &
xinput set-prop 13 297 1 &
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

