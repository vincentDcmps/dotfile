#!/usr/bin/env bash

function run {
   if ! pgrep $1;
          then
                  $@&
   fi
}

run /usr/lib/polkit-kde-authentication-agent-1
run ~/script/autoxrandr
run setxkbmap -layout "fr,us"
run keepassxc
