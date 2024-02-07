-- Locals
pcall(require, "luarocks.loader")
require("awful.autofocus")
local awful = require("awful")
-- Layouts
awful.layout.layouts = {
	awful.layout.suit.tile,
	awful.layout.suit.floating,
	awful.layout.suit.spiral.dwindle,
	awful.layout.suit.max.fullscreen,
}

client.connect_signal("manage", function(c)
	-- Fist is always master
	if not awesome.startup then
		awful.client.setslave(c)
	end
	-- if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
	-- 	awful.placement.no_offscreen(c)
	-- end
end)
