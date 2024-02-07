local awful = require("awful")
local wibox = require("wibox")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

awful.screen.connect_for_each_screen(function(s)
	local module = require("config.bar.modules")
	s.mywibox = awful.wibar({
		position = "bottom",
		border_color = "#00000000",
		border_width = dpi(8),
		screen = s,
	})

	-- Add widgets to the wibox
	s.mywibox:setup({
		layout = wibox.layout.align.horizontal,
		{
			layout = wibox.layout.fixed.horizontal,
			require("config.menu").mylauncher,
			module.tags(s),
			module.get_launchers_widget(),
		},
		module.active_apps(s),
		{
			layout = wibox.layout.fixed.horizontal,
			module.systray,
			module.cpu(),
			module.mem(),
			module.vol(),
			module.clock,
			module.layouts(),
		},
	})
end)
