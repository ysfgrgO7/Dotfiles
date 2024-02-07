-- Locals
pcall(require, "luarocks.loader")
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
local beautiful = require("beautiful")
local menubar = require("menubar")
local keys = require("config.keys")
local terminal = "alacritty"
require("awful.hotkeys_popup.keys")

-- Errors
require("errors")

-- Themes
local chosen_theme = "theme"
local theme_path = string.format("%s/.config/awesome/%s/theme.lua", os.getenv("HOME"), chosen_theme)
beautiful.init(theme_path)

-- Layouts
require("config.layouts")
-- Menubar
menubar.utils.terminal = terminal

-- Wibar
awful.screen.connect_for_each_screen(function(s)
	awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])
end)
require("config.bar")

-- {{{ Autostart windowless processes
local function run_once(cmd_arr)
	for _, cmd in ipairs(cmd_arr) do
		findme = cmd
		firstspace = cmd:find(" ")
		if firstspace then
			findme = cmd:sub(0, firstspace - 1)
		end
		awful.spawn.with_shell(string.format("pgrep -u $USER -x %s > /dev/null || (%s)", findme, cmd))
	end
end

run_once({ "unclutter -root" }) -- entries must be comma-separated
run_once({ "nm-applet" })
run_once({ "nitrogen --restore" })
awful.spawn.with_shell("xclip")
awful.spawn.with_shell("picom")
awful.spawn.with_shell("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")
awful.spawn.with_shell("awesome-appmenu")

-- }}}

-- Bindings
root.buttons(gears.table.join(awful.button({}, 4, awful.tag.viewnext), awful.button({}, 5, awful.tag.viewprev)))
root.keys(keys.globalkeys)

-- Rules
require("config.rules")

-- Titlebar
require("config.titlebar")

-- Focus Flow The Mouse
client.connect_signal("mouse::enter", function(c)
	c:emit_signal("request::activate", "mouse_enter", { raise = false })
end)

-- Border
client.connect_signal("focus", function(c)
	c.border_color = beautiful.border_focus
end)
client.connect_signal("unfocus", function(c)
	c.border_color = beautiful.border_normal
end)
