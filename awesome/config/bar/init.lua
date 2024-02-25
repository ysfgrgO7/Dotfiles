local awful = require("awful")
local wibox = require("wibox")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local apps = require("config.bar.modules.opened_apps")
local beautiful = require("beautiful")
local gears = require("gears")

awful.screen.connect_for_each_screen(function(s)
	local module = require("config.bar.modules")
	s.mywibox = awful.wibar({
		position = "bottom",
		border_color = beautiful.black,
		border_width = dpi(4),
		screen = s,
		height = 30,
		margins = dpi(8),
		shape = function(cr, w, h)
			gears.shape.rounded_rect(cr, w, h, 10)
		end,
	})

	-- Add widgets to the wibox
	s.mywibox:setup({
		layout = wibox.layout.align.horizontal,
		{
			layout = wibox.layout.fixed.horizontal,
			module.sep(),
			module.launcher,
			module.sep(),
			module.tags(s),
			module.sep(),
			module.get_launchers_widget(),
			module.sep(),
			module.layouts(),
			module.sep(),
			apps(s),
		},
		nil,
		{
			layout = wibox.layout.fixed.horizontal,
			module.systray,
			module.sep(),
			module.cpu(),
			module.sep(),
			module.mem(),
			module.sep(),
			module.vol(),
			module.sep(),
			module.clock,
			module.sep(),
			module.power,
		},
	})
end)
