local M = {}

local wibox = require("wibox")
local layout = require("config.bar.modules.layouts")
local tags = require("config.bar.modules.tags")
local apps = require("config.bar.modules.opened_apps")
local launcher = require("config.bar.modules.launchers")
local mem = require("config.bar.modules.mem").mems()
local vol = require("config.bar.modules.pulse").vol()
local cpu = require("config.bar.modules.cpu").cpu()

M.clock = wibox.widget.textclock()
M.systray = wibox.widget.systray()
function M.layouts()
	return layout
end
function M.tags(s)
	return tags.tags(s)
end
function M.active_apps(s)
	return apps.active_apps(s)
end
function M.get_launchers_widget()
	return launcher.get_launchers_widget()
end
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
