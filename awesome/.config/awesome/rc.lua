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
--import xrandr library
local xrandr = require("xrandr")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
--load revelation plugin

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

-- revelation init
local revelation=require("revelation")
revelation.init()
--
-- This is used later as the default terminal and editor to run.


awful.util.terminal = terminal

editor = os.getenv("EDITOR") or "vim"
editor_cmd = env.terminal .. " -e " .. editor

-- Default env.mod.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.

-- Table of layouts to cover with awful.layout.inc, order matters.


-- {{{ Menu
local mainmenu=require("menu")
mainmenu:init({ env = env })

local layouts = require("layout-config") -- load file with tile layouts setup
layouts:init()



--mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
 --                                    menu = mymainmenu })
-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- {{{ Wibar
-- Create a textclock widget
mytextclock = wibox.widget.textclock()

local spr_right = redflat.gauge.separator.vertical()
local cpuicon = wibox.widget.imagebox(beautiful.cpu_icon,true)
local cpu = lain.widget.cpu({
    settings = function()
        widget:set_markup(markup.fontfg(beautiful.font,beautiful.fg_normal, cpu_now.usage .. "% "))
    end
})
local mymemicon =wibox.widget.imagebox(beautiful.ram_icon)
local mymem = lain.widget.mem({
      settings = function()
        widget:set_markup(markup.fontfg(beautiful.font,beautiful.fg_normal, mem_now.perc .. "% "))
       end
})

-- Net
local netdownicon = wibox.widget.imagebox(beautiful.net_down)
local netdowninfo = wibox.widget.textbox()
local netupicon = wibox.widget.imagebox(beautiful.net_up)
local netupinfo = lain.widget.net({
    settings = function()
        
        widget:set_markup(markup.fontfg(beautiful.font, "#e54c62", net_now.sent .. " "))
        netdowninfo:set_markup(markup.fontfg(beautiful.font, "#87af5f", net_now.received .. " "))
    end
})


local mpdicon = wibox.widget.imagebox(beautiful.mpd_icon)
local mpd = lain.widget.mpd({
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

local baticon = wibox.widget.imagebox(beautiful
.widget_batt)
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

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
                    awful.button({ }, 1, function(t) t:view_only() end),
                    awful.button({ env.mod }, 1, function(t)
                                              if client.focus then
                                                  client.focus:move_to_tag(t)
                                              end
                                          end),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ env.mod }, 3, function(t)
                                              if client.focus then
                                                  client.focus:toggle_tag(t)
                                              end
                                          end),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
                )


local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
     -- Wallpaper
    set_wallpaper(s)

    -- Each screen has its own tag taawful.util.terminable.
    awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[3])


    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.noempty, taglist_buttons)

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            s.mytaglist,
            s.mypromptbox,
            spr_right,
            mpdicon,
            mpd.widget
        },
        nil -- Middle widget
        ,{ -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            spr_right,
            netdownicon,
            netdowninfo,
            netupicon,
            netupinfo.widget,
            cpuicon,
            cpu ,
            mymemicon,
            mymem,
            baticon,
            bat,
            spr_right,
            mykeyboardlayout,
            spr_right,
            wibox.widget.systray(),
            spr_right,
            mytextclock,
            s.mylayoutbox,
        },
    }
end)
-- }}}

-- {{{ Mouse bindings
root.buttons(gears.table.join(
    awful.button({ }, 3, function () mainmenu.mainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = gears.table.join(
    awful.key({ env.mod }, "b", function ()
        mouse.screen.mywibox.visible = not mouse.screen.mywibox.visible
        end,{description="togle wibox",group="awesome"}), 
    awful.key({ env.mod,           }, "s",      hotkeys_popup.show_help,
              {description="show help", group="awesome"}),
    awful.key({ env.mod,           }, "e",      revelation,
              {description="revelation shortcut",group="awesome"}),
    awful.key({ env.mod,           }, "Left",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ env.mod,           }, "Right",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),
    awful.key({ env.mod,           }, "Escape", awful.tag.history.restore,
              {description = "go back", group = "tag"}),
    awful.key({ "Shift" }, "Alt_L", function() mykeyboardlayout.next_layout(); end),
    awful.key({ env.mod,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key({ env.mod,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),
    awful.key({env.mod,"Shift"},"o" , function() xrandr.xrandr() end,
                {description = "xrandr shortcut", group = "awesome"}),
    awful.key({ env.mod,           }, "w", function () mainmenu.mainmenu:show() end,
              {description = "show main menu", group = "awesome"}),

    -- Layout manipulation
    awful.key({ env.mod, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ env.mod, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),
    awful.key({ env.mod, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({ env.mod, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),
    awful.key({ env.mod,           }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),
    awful.key({ env.mod,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),

    -- Standard program
        -- Dropdown application
    awful.key({ env.mod,           }, "Return", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ env.mod, "Control" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ env.mod, "Shift"   }, "q", awesome.quit,
              {description = "quit awesome", group = "awesome"}),

    awful.key({ env.mod,           }, "l",     function () awful.tag.incmwfact( 0.05)          end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ env.mod,           }, "h",     function () awful.tag.incmwfact(-0.05)          end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({ env.mod, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),
    awful.key({ env.mod, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ env.mod, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
              {description = "increase the number of columns", group = "layout"}),
    awful.key({ env.mod, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
              {description = "decrease the number of columns", group = "layout"}),
    awful.key({ env.mod,           }, "space", function () awful.layout.inc( 1)                end,
              {description = "select next", group = "layout"}),
    awful.key({ env.mod, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
              {description = "select previous", group = "layout"}),

    awful.key({ env.mod, "Control" }, "n",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                      client.focus = c
                      c:raise()
                  end
              end,
              {description = "restore minimized", group = "client"}),

    -- Prompt
    awful.key({ env.mod },            "r",     function () awful.screen.focused().mypromptbox:run() end,
              {description = "run prompt", group = "launcher"}),

    awful.key({ env.mod }, "x",
              function ()
                  awful.prompt.run {
                    prompt       = "Run Lua code: ",
                    textbox      = awful.screen.focused().mypromptbox.widget,
                    exe_callback = awful.util.eval,
                    history_path = awful.util.get_cache_dir() .. "/history_eval"
                  }
              end,
              {description = "lua execute prompt", group = "awesome"}),
    -- Menubar
    awful.key({ env.mod }, "p", function() menubar.show() end,
              {description = "show the menubar", group = "launcher"}),
    awful.key({ },"XF86AudioRaiseVolume", function() awful.spawn("pamixer -i 5") end),
    awful.key({ }, "XF86AudioLowerVolume", function () awful.spawn("pamixer -d 5") end),
   --multimedia keys 
    awful.key({ }, "XF86MonBrightnessUp", function () awful.spawn("light -A 10") end),
    awful.key({ }, "XF86MonBrightnessDown", function () awful.spawn("light -U 10") end),
    awful.key({ }, "XF86AudioMute", function () awful.spawn("pamixer -t") end),
    awful.key({ }, "XF86AudioPlay", function () awful.spawn("mpc toggle") end),
    awful.key({ }, "XF86AudioStop", function () awful.spawn("mpc stop") end),
    awful.key({ }, "XF86AudioNext", function () awful.spawn("mpc next") end),
    awful.key({ }, "XF86AudioPrev", function () awful.spawn("mpc prev") end),
    --application hotkeys (logitech keyboard g710+)
    awful.key({  }, "XF86LaunchA", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({  }, "XF86Launch9", function () awful.spawn("keepassxc") end,
              {description = "open keepass", group = "launcher"}),

    awful.key({  }, "XF86Launch8", function () awful.spawn("firefox") end,
              {description = "open a Firefox", group = "launcher"}),

    awful.key({  }, "XF86Launch7", function () awful.spawn("code") end,
              {description = "open VScode", group = "launcher"})
)

clientkeys = gears.table.join(
    awful.key({ env.mod,           }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
    awful.key({ env.mod, "Shift"   }, "c",      function (c) c:kill()                         end,
              {description = "close", group = "client"}),
    awful.key({ env.mod, "Control" }, "space",  awful.client.floating.toggle                     ,
              {description = "toggle floating", group = "client"}),
    awful.key({ env.mod, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),
    awful.key({ env.mod,           }, "o",      function (c) c:move_to_screen()               end,
              {description = "move to screen", group = "client"}),
    awful.key({ env.mod,           }, "t",      function (c) c.ontop = not c.ontop            end,
              {description = "toggle keep on top", group = "client"}),
    awful.key({ env.mod,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
        {description = "minimize", group = "client"}),
    awful.key({ env.mod,           }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "(un)maximize", group = "client"}),
    awful.key({ env.mod, "Control" }, "m",
        function (c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end ,
        {description = "(un)maximize vertically", group = "client"}),
    awful.key({ env.mod, "Shift"   }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end ,
        {description = "(un)maximize horizontally", group = "client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ env.mod }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ env.mod, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ env.mod, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ env.mod, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end

clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ env.mod }, 1, awful.mouse.client.move),
    awful.button({ env.mod }, 3, awful.mouse.client.resize))


-- Active screen edges
-----------------------------------------------------------------------------------------------------------------------
local edges = require("edges-config") -- load file with edges configuration
edges:init()

-- Set keys
root.keys(globalkeys)
-- }}}
local hotkeys = require("keys-config") -- load file with hotkeys configuration
hotkeys:init({ env = env, menu = mainmenu.mainmenu })
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
