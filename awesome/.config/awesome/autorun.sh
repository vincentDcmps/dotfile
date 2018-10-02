#!/usr/bin/env bash

function run {
   if ! pgrep $1;
          then
                  $@&
   fi
}

run compton -b
run /usr/lib/polkit-kde-authentication-agent-1
run xinput set-prop 13 291 1
run xinput set-prop 13 283 1

