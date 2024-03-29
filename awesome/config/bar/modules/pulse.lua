local M = {}
local awful = require("awful")
local shell = require("awful.util").shell
local wibox = require("wibox")
local helpers = require("config.bar.modules.helpers")
local markup = require("config.bar.modules.helpers.markup")
local beautiful = require("beautiful")
local string = string

function M.factory(args)
	args = args or {}
	local alsa = { widget = args.widget or wibox.widget.textbox() }
	local timeout = args.timeout or 5
	local settings = args.settings or function() end

	alsa.cmd = args.cmd or "amixer"
	alsa.channel = args.channel or "Master"
	alsa.togglechannel = args.togglechannel

	local format_cmd = string.format("%s get %s", alsa.cmd, alsa.channel)

	if alsa.togglechannel then
		format_cmd = {
			shell,
			"-c",
			string.format("%s get %s; %s get %s", alsa.cmd, alsa.channel, alsa.cmd, alsa.togglechannel),
		}
	end

	alsa.last = {}

	function alsa.update()
		helpers.async(format_cmd, function(mixer)
			local l, s = string.match(mixer, "([%d]+)%%.*%[([%l]*)")
			l = tonumber(l)
			if alsa.last.level ~= l or alsa.last.status ~= s then
				volume_now = { level = l, status = s }
				widget = alsa.widget
				settings()
				alsa.last = volume_now
			end
		end)
	end

	helpers.newtimer(string.format("alsa-%s-%s", alsa.cmd, alsa.channel), timeout, alsa.update)
	return alsa
end

function M.vol()
	local volume = M.factory({
		-- settings = function()
		-- 	widget:set_markup(markup("#80A1C0", " " .. volume_now.level .. "%"))
		-- end,
		settings = function()
			vlevel = volume_now.level

			if volume_now.status == "off" then
				vlevel = "M"
			else
				vlevel = " " .. vlevel .. "%"
			end

			widget:set_markup(markup(beautiful.yellow, vlevel))
		end,
	})

	volume.widget:buttons(awful.util.table.join(
		awful.button({}, 1, function() -- left click
			awful.spawn("pavucontrol")
		end),
		awful.button({}, 3, function() -- right click
			os.execute(string.format("pactl -- set-sink-mute 0 toggle", volume.togglechannel or volume.channel))
			volume.update()
		end),
		awful.button({}, 4, function() -- scroll up
			os.execute(string.format("amixer -q set %s 1%%+", volume.channel))
			volume.update()
		end),
		awful.button({}, 5, function() -- scroll down
			os.execute(string.format("amixer -q set %s 1%%-", volume.channel))
			volume.update()
		end)
	))

	return volume
end

return M
