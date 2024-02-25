local M = {}
local timer = require("gears.timer")
local spawn = require("awful.spawn")
local beautiful = require("beautiful")
local timer_table = {}

function M.newtimer(name, timeout, fun, nostart, stoppable)
	if not name or #name == 0 then
		return
	end
	name = (stoppable and name) or timeout
	if not timer_table[name] then
		timer_table[name] = timer({ timeout = timeout })
		timer_table[name]:start()
	end
	timer_table[name]:connect_signal("timeout", fun)
	if not nostart then
		timer_table[name]:emit_signal("timeout")
	end
	return stoppable and timer_table[name]
end

function M.async(cmd, callback)
	return spawn.easy_async(cmd, function(stdout, _, _, exit_code)
		callback(stdout, exit_code)
	end)
end

function M.lines_match(regexp, path)
	local lines = {}
	for line in io.lines(path) do
		if string.match(line, regexp) then
			lines[#lines + 1] = line
		end
	end
	return lines
end

function M:inc_fontsize(inc, font)
	if not font then
		font = beautiful.font_name
	end
	return font .. " " .. tostring(beautiful.font + inc)
end

function M.colorize_text(text, color)
	return "<span foreground='" .. color .. "'>" .. text .. "</span>"
end

return M
