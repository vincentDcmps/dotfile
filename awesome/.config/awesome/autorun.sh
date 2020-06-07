#!/usr/bin/env bash

function run {
   if ! pgrep $1;
          then
                  $@&
   fi
}
run numlockx
run picom -b
#config pad
run xinput set-prop 13 325 1 
run xinput set-prop 13 309 1 
run /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1
run ~/script/autoxrandr
run setxkbmap -layout "fr,us"
run keepassxc
run aarchup
run redshift-gtk
run start-pulseaudio-x11
run albert
