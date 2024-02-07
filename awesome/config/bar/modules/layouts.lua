local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")

local function layouts(s)
	local mylayoutbox = awful.widget.layoutbox(s)
	mylayoutbox:buttons(gears.table.join(
		awful.button({}, 1, function()
			awful.layout.inc(1)
		end),
		awful.button({}, 3, function()
			awful.layout.inc(-1)
		end),
		awful.button({}, 4, function()
			awful.layout.inc(1)
		end),
		awful.button({}, 5, function()
			awful.layout.inc(-1)
		end)
	))
	return mylayoutbox
end

return layouts()
