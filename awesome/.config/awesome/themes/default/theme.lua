---------------------------
-- Default awesome theme --
---------------------------

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local gfs = require("gears.filesystem")
local themes_path =os.getenv("HOME") .. "/.config/awesome/themes/" 
local icon_dir = themes_path .. "default/icons/"

local theme = require("themes/colored/theme")

theme.color.main   = "#A30817"
theme.color.urgent = "#016B84"



theme:update()
theme.gauge.audio.blue.dash.plain = true
theme.gauge.audio.blue.dash.bar.num = 8
theme.gauge.audio.blue.dash.bar.width = 3
theme.gauge.audio.blue.dmargin = { 5, 0, 9, 9 }
theme.gauge.audio.blue.width = 86
theme.gauge.audio.blue.icon = theme.path .. "/widget/audio.svg"
theme.widget.tasklist.task = theme.gauge.task.ruby
theme.font          = "Roboto Bold  10"

theme.cellnum = { x = 80, y = 43 } -- grid layout property

theme.wallpaper = "~/Images/wallpaper.jpg"

theme.widget.wrapper = {
	layoutbox   = { 12, 10, 6, 6 },
	textclock   = { 10, 10, 0, 0 },
	volume      = { 4, 9, 3, 3 },
	network     = { 10, 10, 5, 5 },
	cpuram      = { 10, 10, 5, 5 },
	keyboard    = { 10, 10, 4, 4 },
	mail        = { 10, 10, 4, 4 },
	battery     = { 8, 10, 7, 7 },
	tray        = { 8, 8, 7, 7 },
	tasklist    = { 4, 0, 0, 0 }, -- centering tasklist widget
}


return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
