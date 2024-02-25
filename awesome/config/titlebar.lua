pcall(require, "luarocks.loader")
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
local wibox = require("wibox")
require("awful.hotkeys_popup.keys")

client.connect_signal("request::titlebars", function(c)
	-- buttons for the titlebar
	local buttons = gears.table.join(
		awful.button({}, 1, function()
			c:emit_signal("request::activate", "titlebar", { raise = true })
			awful.mouse.client.move(c)
		end),
		awful.button({}, 3, function()
			c:emit_signal("request::activate", "titlebar", { raise = true })
			awful.mouse.client.resize(c)
		end)
	)

	local top_titlebar = awful.titlebar(c, {
		size = 25,
		font = "JetbrainsMono Nerd Font 12",
	})
	top_titlebar:setup({
		{ -- Left
			awful.titlebar.widget.iconwidget(c),
			buttons = buttons,
			layout = wibox.layout.fixed.horizontal,
		},
		{ -- Middle
			{ -- Title
				align = "center",
				font = "JetbrainsMono Nerd Font 12",
				widget = awful.titlebar.widget.titlewidget(c),
			},
			buttons = buttons,
			font = "JetbrainsMono Nerd Font 12",
			layout = wibox.layout.flex.horizontal,
		},
		{ -- Right
			awful.titlebar.widget.minimizebutton(c),
			awful.titlebar.widget.maximizedbutton(c),
			awful.titlebar.widget.closebutton(c),
			layout = wibox.layout.fixed.horizontal(),
			font = "JetbrainsMono Nerd Font 12",
		},
		layout = wibox.layout.align.horizontal,
	})
end)
