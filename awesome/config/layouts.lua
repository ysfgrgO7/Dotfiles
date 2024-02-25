-- Locals
pcall(require, "luarocks.loader")
require("awful.autofocus")
local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")
-- Layouts
awful.layout.layouts = {
	awful.layout.suit.tile,
	awful.layout.suit.floating,
	awful.layout.suit.spiral.dwindle,
}

-- New is not master
client.connect_signal("manage", function(c)
	if not awesome.startup then
		awful.client.setslave(c)
	end
end)

-- No borders if only one tiled client
screen.connect_signal("arrange", function(s)
	for _, c in pairs(s.clients) do
		if #s.tiled_clients == 1 and c.floating == false and c.first_tag.layout.name ~= "floating" then
			c.border_width = 0
		elseif #s.tiled_clients > 1 or c.first_tag.layout.name == "floating" then
			c.border_width = beautiful.border_width
		end
	end
end)

-- Corners
local function add_rounded_corners(c)
	if not c.maximized then
		c.shape = gears.shape.rounded_rect
	else
		c.shape = gears.shape.rectangle
	end
end
client.connect_signal("manage", add_rounded_corners)
client.connect_signal("property::maximized", add_rounded_corners)

-- Hide when not floating
client.connect_signal("property::floating", function(c)
	local tb = awful.titlebar
	if c.floating then
		tb.show(c)
	else
		tb.hide(c)
	end
end)

-- Titlebars only on floating windows
client.connect_signal("property::floating", function(c)
	local b = false
	if c.first_tag ~= nil then
		b = c.first_tag.layout.name == "floating"
	end
	if c.floating or b then
		awful.titlebar.show(c)
	else
		awful.titlebar.hide(c)
	end
end)

function dynamic_title(c)
	if c.floating or c.first_tag.layout.name == "floating" then
		awful.titlebar.show(c)
	else
		awful.titlebar.hide(c)
	end
end

client.connect_signal("manage", dynamic_title)
client.connect_signal("tagged", dynamic_title)

tag.connect_signal("property::layout", function(t)
	local clients = t:clients()
	for k, c in pairs(clients) do
		if c.floating or c.first_tag.layout.name == "floating" then
			awful.titlebar.show(c)
		else
			awful.titlebar.hide(c)
		end
	end
end)
