if [ -d "$HOME/.local/bin" ]; then
    export PATH="$HOME/.local/bin:$PATH"
    fi

if [ -f "/bin/Xorg" ]; then
    [[ $(tty) == '/dev/tty1' ]] && startx i3
fi
if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty2 ]] && [[ -z $XDG_SESSION_TYPE ]]; then
  XDG_SESSION_TYPE=wayland exec dbus-run-session gnome-session
fi

