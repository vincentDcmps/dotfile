if [ -d "$HOME/.local/bin" ]; then
    export PATH="$HOME/.local/bin:$PATH"
    fi

if [ -f "/bin/Xorg" ]; then
    [[ $(tty) == '/dev/tty2' ]] && startx ~/.xinitrc awesome 
    [[ $(tty) == '/dev/tty3' ]] && startx ~/.xinitrc i3
fi
if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]] ; then
  XDG_SESSION_TYPE=wayland exec Hyprland
fi

