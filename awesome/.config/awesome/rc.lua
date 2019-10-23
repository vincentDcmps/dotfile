-- Standard awesome library
local gears = require("gears")
local awful = require("awful")

-- User modules
------------------------------------------------------------
local redflat = require("redflat")

redflat.startup:activate()

require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local lain = require("lain")
local markup = lain.util.markup
local beautiful = require("beautiful")

-- Notification library
local naughty = require("naughty")

--load hotkey_popup
local hotkeys_popup = require("awful.hotkeys_popup").widget
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:

require("hotkeys_popup.termite")
-- Error handling
-----------------------------------------------------------------------------------------------------------------------
require("ercheck-config") -- load file with error handling

env=require("env-config")
env:init()

-- This is used later as the default terminal and editor to run.
awful.util.terminal = env.terminal

local mainmenu=require("menu")
mainmenu:init({ env = env })

local layouts = require("layout-config") -- load file with tile layouts setup
layouts:init()



--mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
 --                                    menu = mainmenu })

 local tasklist = {}

-- load list of app name aliases from files and set it as part of tasklist theme
tasklist.style = { appnames = require("alias-config")}

tasklist.buttons = awful.util.table.join(
	awful.button({}, 1, redflat.widget.tasklist.action.select),
	awful.button({}, 2, redflat.widget.tasklist.action.close),
	awful.button({}, 3, redflat.widget.tasklist.action.menu),
	awful.button({}, 4, redflat.widget.tasklist.action.switch_next),
	awful.button({}, 5, redflat.widget.tasklist.action.switch_prev)
)

-- Taglist widget
--------------------------------------------------------------------------------
local taglist = {}
taglist.style = { widget = redflat.gauge.tag.orange.new, show_tip = true }
taglist.buttons = awful.util.table.join(
	awful.button({         }, 1, function(t) t:view_only() end),
	awful.button({ env.mod }, 1, function(t) if client.focus then client.focus:move_to_tag(t) end end),
	awful.button({         }, 2, awful.tag.viewtoggle),
	awful.button({         }, 3, function(t) redflat.widget.layoutbox:toggle_menu(t) end),
	awful.button({ env.mod }, 3, function(t) if client.focus then client.focus:toggle_tag(t) end end),
	awful.button({         }, 4, function(t) awful.tag.viewnext(t.screen) end),
	awful.button({         }, 5, function(t) awful.tag.viewprev(t.screen) end)
)

-- Textclock widget
--------------------------------------------------------------------------------
local textclock = {}
textclock.widget = redflat.widget.textclock({ timeformat = "%H:%M", dateformat = "%b  %d  %a" })


-- Layoutbox configure
--------------------------------------------------------------------------------
local layoutbox = {}

layoutbox.buttons = awful.util.table.join(
	awful.button({ }, 1, function () mainmenu.mainmenu:toggle() end),
	awful.button({ }, 3, function () redflat.widget.layoutbox:toggle_menu(mouse.screen.selected_tag) end),
	awful.button({ }, 4, function () awful.layout.inc( 1) end),
	awful.button({ }, 5, function () awful.layout.inc(-1) end)
)

-- Tray widget
--------------------------------------------------------------------------------
local tray = {}
tray.widget = redflat.widget.minitray()

tray.buttons = awful.util.table.join(
	awful.button({}, 1, function() redflat.widget.minitray:toggle() end)
)

local volume = {}
volume.widget = redflat.widget.pulse(nil, { widget = redflat.gauge.audio.blue.new })


-- activate player widget
redflat.float.player:init({ name = env.player })

volume.buttons = awful.util.table.join(
	awful.button({}, 4, function() volume.widget:change_volume()                end),
	awful.button({}, 5, function() volume.widget:change_volume({ down = true }) end),
	awful.button({}, 2, function() volume.widget:mute()                         end),
	awful.button({}, 3, function() redflat.float.player:show()                  end),
	awful.button({}, 1, function() redflat.float.player:action("PlayPause")     end),
	awful.button({}, 8, function() redflat.float.player:action("Previous")      end),
	awful.button({}, 9, function() redflat.float.player:action("Next")          end)
)

-- Keyboard layout indicator
--------------------------------------------------------------------------------
local kbindicator = {}
redflat.widget.keyboard:init({ "French", "English" })
kbindicator.widget = redflat.widget.keyboard()

kbindicator.buttons = awful.util.table.join(
	awful.button({}, 1, function () redflat.widget.keyboard:toggle_menu() end),
	awful.button({}, 4, function () redflat.widget.keyboard:toggle()      end),
	awful.button({}, 5, function () redflat.widget.keyboard:toggle(true)  end)
)


local spr_right = redflat.gauge.separator.vertical()

local sysmon = { widget = {}, buttons = {}, icon = {} }

-- icons
sysmon.icon.battery = redflat.util.table.check(beautiful, "wicon.battery")
sysmon.icon.network = redflat.util.table.check(beautiful, "wicon.wireless")
sysmon.icon.cpuram = redflat.util.table.check(beautiful, "wicon.monitor")


-- CPU usage
sysmon.widget.cpu = redflat.widget.sysmon(
	{ func = redflat.system.pformatted.cpu(80) },
	{ timeout = 2, monitor = { label = "CPU" } }
)

sysmon.buttons.cpu = awful.util.table.join(
	awful.button({ }, 1, function() redflat.float.top:show("cpu") end)
)

-- RAM usage
sysmon.widget.ram = redflat.widget.sysmon(
	{ func = redflat.system.pformatted.mem(80) },
	{ timeout = 10, monitor = { label = "RAM" } }
)

sysmon.buttons.ram = awful.util.table.join(
	awful.button({ }, 1, function() redflat.float.top:show("mem") end)
)
-- battery
local batstate=redflat.system.battery("BAT0")
if batstate[3] ~= "N/A" then
    sysmon.widget.battery = redflat.widget.sysmon(
	    { func = redflat.system.pformatted.bat(25), arg = "BAT0" },
	    { timeout = 60, widget = redflat.gauge.icon.single, monitor = { is_vertical = true, icon = sysmon.icon.battery } }
    )
end
-- network speed

-- use self-drawn rectange image as indicator icon
local img = redflat.util.base.image(7, 40, { x = 1, y = 0, width = 5, height = 40 })
local interfaces = "br0"
local netstate=redflat.system.net_speed("br0",{})
if netstate[3] == 0 then 
    interfaces = "wlp2s0"
end
sysmon.widget.network = redflat.widget.net(
	{ interface = interfaces, speed = { up = 6 * 1024^2, down = 6 * 1024^2 }, autoscale = false },
	-- custom style
	{ timeout = 2, widget = redflat.gauge.icon.double, monitor = { step = 0.1, icon1 = img, icon2 = img, igap = 3 } }
)


local mpdicon = wibox.widget.imagebox(beautiful.mpd_icon)
local mpd = lain.widget.mpd({
    notify = "off",
    settings = function()
        mpd_notification_preset = {
            text = string.format("%s [%s] - %s\n%s", mpd_now.artist,
                   mpd_now.album, mpd_now.date, mpd_now.title)
        }

        if mpd_now.state == "play" then
            artist = mpd_now.artist .. " > "
            title  = mpd_now.title .. " "
            mpdicon:set_image(beautiful.mpd_icon)
        elseif mpd_now.state == "pause" then
            artist = "mpd "
            title  = "paused "
        else
            artist = ""
            title  = ""
            mpdicon:set_image() -- not working in 4.0
            mpdicon._private.image = nil
           mpdicon:emit_signal("widget::redraw_needed")
           mpdicon:emit_signal("widget::layout_changed")
        end
        widget:set_markup(markup.fontfg(beautiful.font, "#e54c62", artist) .. markup.fontfg(beautiful.font, "#b2b2b2", title))
    end
})

local baticon = wibox.widget.imagebox(beautiful.widget_batt)
local bat = lain.widget.bat({
    settings = function()
        local perc = bat_now.perc ~= "N/A" and bat_now.perc .. "%" or bat_now.perc

        if bat_now.status  then
            perc = perc .. " " .. bat_now.status
        else
           return
        end

        widget:set_markup(markup.fontfg(beautiful.font, beautiful.fg_normal, perc .. " "))
    end
})



awful.screen.connect_for_each_screen(function(s)
     -- Wallpaper
     env.wallpaper(s)

    -- Each screen has its own tag taawful.util.terminable.
    awful.tag({ "1", "2", "3", "4","5" }, s, awful.layout.layouts[3])

    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
  		-- layoutbox widget
    layoutbox[s] = redflat.widget.layoutbox({ screen = s })

          -- taglist widget
    taglist[s] = redflat.widget.taglist({ screen = s, buttons = taglist.buttons, hint = env.tagtip }, taglist.style)
  
          -- tasklist widget
    tasklist[s] = redflat.widget.tasklist({ screen = s, buttons = tasklist.buttons }, tasklist.style)
  
    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s, height = beautiful.panel_height or 36 })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            env.wrapper(layoutbox[s], "layoutbox", layoutbox.buttons),
            spr_right,
            env.wrapper(taglist[s], "taglist"),
            spr_right,
            env.wrapper(kbindicator.widget, "keyboard", kbindicator.buttons),
            spr_right,
            mpdicon,
            mpd.widget
        },
        { -- middle widget
        layout = wibox.layout.align.horizontal,
        expand = "outside",

        nil,
        env.wrapper(tasklist[s], "tasklist"),
        },
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            spr_right,
            env.wrapper(sysmon.widget.network, "network"),

            spr_right,
            env.wrapper(sysmon.widget.cpu, "cpu", sysmon.buttons.cpu),
            spr_right,
            env.wrapper(sysmon.widget.ram, "ram", sysmon.buttons.ram),
            spr_right,
            env.wrapper(sysmon.widget.battery, "battery"),
            spr_right,
            env.wrapper(volume.widget, "volume", volume.buttons),
            spr_right,
            env.wrapper(textclock.widget, "textclock"),
            spr_right,
            env.wrapper(tray.widget, "tray", tray.buttons),
        },
    }
end)


-- Active screen edges
-----------------------------------------------------------------------------------------------------------------------
local edges = require("edges-config") -- load file with edges configuration
edges:init()

-- Set keys

-- }}}
local hotkeys = require("keys-config") -- load file with hotkeys configuration
hotkeys:init({ env = env, menu = mainmenu.mainmenu,appkeys={}, volume = volume.widget  })
-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
local rules = require("rules-config") -- load file with rules configuration
rules:init({ hotkeys = hotkeys})

-- Titlebar setup
-----------------------------------------------------------------------------------------------------------------------
local titlebar = require("titlebar-config") -- load file with titlebar configuration
titlebar:init()

-- {{{ Signals
-- Signal function to execute when a new client appears.
-- Base signal set for awesome wm
-----------------------------------------------------------------------------------------------------------------------
local signals = require("signals-config") -- load file with signals configuration
signals:init({ env = env })

--
--include autorun file
awful.spawn.with_shell("~/.config/awesome/autorun.sh")

--debug variable:
--naughty.notify({preset=naughty.config.presets.normal, title="debug", text=beautiful.cpu_icon})
