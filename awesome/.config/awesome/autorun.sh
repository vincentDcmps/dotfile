#!/usr/bin/env bash

function run {
   if ! pgrep $1;
          then
                  $@&
   fi
}

run /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1
run ~/script/autoxrandr
run setxkbmap -layout "fr,us"
run keepassxc
run aarchup
run redshift-gtk
run pulseaudio --start
