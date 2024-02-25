local M = {}

local wibox = require("wibox")
local awful = require("awful")
local layout = require("config.bar.modules.layouts")
local tags = require("config.bar.modules.tags")
local Launcher = require("config.bar.modules.launcher")
local Powermenu = require("config.bar.modules.launcher.powermenu")
local launcher = require("config.bar.modules.launchers")
local mem = require("config.bar.modules.mem").mems()
local vol = require("config.bar.modules.pulse").vol()
local cpu = require("config.bar.modules.cpu").cpu()
local beautiful = require("beautiful")
local markup = require("config.bar.modules.helpers.markup")
M.launcher = wibox.widget({
	widget = wibox.container.background,
	buttons = {
		awful.button({}, 1, function()
			Launcher:toggle()
		end),
	},
	{
		widget = wibox.widget.imagebox,
		scaling_quality = "nearest",
		image = beautiful.theme_assets.awesome_icon(20, beautiful.blue, beautiful.black),
	},
})

M.power = wibox.widget({
	widget = wibox.container.background,
	buttons = {
		awful.button({}, 1, function()
			Powermenu:open()
		end),
	},
	{
		widget = wibox.widget.imagebox,
		scaling_quality = "nearest",
		image = beautiful.titlebar_close_button_normal,
	},
})

M.clock = wibox.widget.textclock(markup(beautiful.cyan, "󰃰 %b %d - %I:%M%p"))
M.systray = wibox.widget.systray()
function M.layouts()
	return layout
end
function M.tags(s)
	return tags.tags(s)
end
function M.get_launchers_widget()
	return launcher.get_launchers_widget()
end
function M.sep()
	local separator = wibox.widget({
		widget = wibox.widget.separator,
		orientation = "vertical",
		forced_width = 10,
		color = beautiful.white,
		visible = true,
	})
	return separator
end
-- From Lain
function M.mem()
	return mem
end
function M.vol()
	return vol
end
function M.cpu()
	return cpu
end

return M
