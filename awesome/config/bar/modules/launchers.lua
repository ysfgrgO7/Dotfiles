pcall(require, "luarocks.loader")
local awful = require("awful")
require("awful.autofocus")
local wibox = require("wibox")
local naughty = require("naughty")

local M = {}

local function make_launcher(opts)
	local launcher = wibox.widget({
		markup = opts.markup,
		align = "center",
		font = "JetbrainsMono Nerd Font 17",
		widget = wibox.widget.textbox,
	})

	launcher:add_button(awful.button({}, 1, function()
		if opts.onclick then
			opts.onclick()
		end
	end))

	return launcher
end

local function donotif(prog)
	naughty.notify({
		app_name = "Launchers",
		title = "Launching!",
		text = "Launching " .. prog .. ", please wait...",
	})
end

local firefox = make_launcher({
	markup = " ",
	align = "center",
	onclick = function()
		donotif("browser")
		awful.spawn("brave") -- comes from `user_likes.lua`
	end,
})

local terminal = make_launcher({
	markup = " ",
	align = "center",
	onclick = function()
		donotif("terminal")
		awful.spawn("alacritty") -- comes from `user_likes.lua`
	end,
})

local explorer = make_launcher({
	markup = " ",
	onclick = function()
		donotif("explorer")
		awful.spawn("pcmanfm-qt") -- comes from `user_likes.lua`'
	end,
})

-- add here the list of all the wanted launchers.
M.dict = {
	firefox,
	terminal,
	explorer,
}

M.get_launchers_widget = function()
	local widget_template = {
		layout = wibox.layout.fixed.horizontal,
	}

	for _, launcher in ipairs(M.dict) do
		table.insert(widget_template, launcher)
	end

	return wibox.widget(widget_template)
end

return M
