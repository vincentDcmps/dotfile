
--###############

--## MONITORS ###

--###############

 require("conf.monitor")

--###############

--## CURSOR ###

--###############

require("conf.cursor")

--## ENVIRONMENT ###

--###############

require("conf.environment")

--###############

--## KEYBOARD ###

--###############

require("conf.keyboard")

--##################

--## MY PROGRAMS ###

--##################

-- See https://wiki.hyprland.org/Configuring/Keywords/

-- Set programs that you use

--
--################

--## AUTOSTART ###

--################


 require("conf.autostart")

-- exec-once = $terminal

-- exec-once = nm-applet &

-- exec-once = waybar & hyprpaper & firefox

--####################

--## LOOK AND FEEL ###

--####################

local window = require("conf.window")

local decoration = require("conf.decoration")

local layout = require("conf.layout")

local misc = require("conf.misc")

local keybinding = require("conf.keybinding")

local windowrule = require("conf.windowrule")

-- https://wiki.hyprland.org/Configuring/Variables/#animations

hl.config({
    animations = {
        enabled = true,
        -- Default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more
    },
})

-- Example per-device config

-- See https://wiki.hyprland.org/Configuring/Keywords/#per-device-input-configs for more

hl.device({
    name = "epic-mouse-v1",
    sensitivity = -0.5,
})

--#############################

--## WINDOWS AND WORKSPACES ###

--#############################


-- Autostart
hl.on("hyprland.start", function()
    hl.exec_cmd("tmux setenv -g HYPRLAND_INSTANCE_SIGNATURE \"" .. os.getenv("HYPRLAND_INSTANCE_SIGNATURE") .. "\"")
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
end)
