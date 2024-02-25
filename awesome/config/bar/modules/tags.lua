local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
require("awful.autofocus")
local beautiful = require("beautiful")
local modkey = "Mod4"

local M = {}

M.taglist_buttons = gears.table.join(
	awful.button({}, 1, function(t)
		t:view_only()
	end),
	awful.button({ modkey }, 1, function(t)
		if client.focus then
			client.focus:move_to_tag(t)
		end
	end),
	awful.button({}, 3, awful.tag.viewtoggle),
	awful.button({ modkey }, 3, function(t)
		if client.focus then
			client.focus:toggle_tag(t)
		end
	end),
	awful.button({}, 4, function(t)
		awful.tag.viewnext(t.screen)
	end),
	awful.button({}, 5, function(t)
		awful.tag.viewprev(t.screen)
	end)
)

local taglist_underline_callback = function(self, _, index, _) end

M.opt = {
	{
		{
			layout = wibox.layout.fixed.vertical,
			{
				{
					id = "text_role",
					widget = wibox.widget.textbox,
				},
				widget = wibox.container.place,
			},
			{
				{
					left = 10,
					right = 10,
					top = 3,
					widget = wibox.container.margin,
				},
				id = "underline",
				shape = gears.shape.rectangle,
				widget = wibox.container.background,
			},
		},
		left = 1,
		right = 1,
		widget = wibox.container.margin,
	},
	id = "background_role",
	widget = wibox.container.background,
	shape = gears.shape.rectangle,
	create_callback = function(self, _, index, _)
		local s = awful.screen.focused()
		for _, x in pairs(s.selected_tags) do
			if x.index == index then
				self:get_children_by_id("underline")[1].bg = beautiful.blue
				return
			end
		end
		self:get_children_by_id("underline")[1].bg = nil -- unfocused color
		self:connect_signal("mouse::enter", function()
			if self.bg ~= beautiful.grey1 then
				self.backup = self.bg
				self.has_backup = true
			end
			self.bg = beautiful.grey1
		end)
		self:connect_signal("mouse::leave", function()
			if self.has_backup then
				self.bg = self.backup
			end
		end)
	end,
	update_callback = function(self, _, index, _)
		local s = awful.screen.focused()
		for _, x in pairs(s.selected_tags) do
			if x.index == index then
				self:get_children_by_id("underline")[1].bg = beautiful.blue
				return
			end
		end
		self:get_children_by_id("underline")[1].bg = nil -- unfocused color
	end,
}

function M.tags(s)
	local mytaglist = awful.widget.taglist({
		screen = s,
		filter = awful.widget.taglist.filter.all,
		buttons = M.taglist_buttons,
		widget_template = M.opt,
	})
	return mytaglist
end

return M
