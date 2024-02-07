-- Locals
--
local M = {}
pcall(require, "luarocks.loader")
local awful = require("awful")
require("awful.autofocus")
local beautiful = require("beautiful")
local hotkeys_popup = require("awful.hotkeys_popup")
local terminal = "alacritty"
local editor = os.getenv("EDITOR") or "nano"
local editor_cmd = terminal .. " -e " .. editor
local menubar = require("menubar")

M.myawesomemenu = {
	{
		"hotkeys",
		function()
			hotkeys_popup.show_help(nil, awful.screen.focused())
		end,
	},
	{ "manual", terminal .. " -e man awesome" },
	{ "edit config", editor_cmd .. " " .. awesome.conffile },
	{ "restart", awesome.restart },
	{
		"quit",
		function()
			awesome.quit()
		end,
	},
}

M.mymainmenu = awful.menu({
	items = {
		{ "awesome", M.myawesomemenu, beautiful.awesome_icon },
		{
			"Search",
			function()
				menubar.show()
			end,
		},
	},
})

M.mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon, menu = M.mymainmenu })

return M
