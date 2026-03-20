#!/usr/bin/env lua
-- [[ colors ]]
local RED = "\x1b[31m"
local GREEN = "\x1b[32m"
local YELLOW = "\x1b[33m"
local BLUE = "\x1b[34m"
local PURPLE = "\x1b[35m"
local CYAN = "\x1b[36m"
local WHITE = "\x1b[97m"
local NOCOL = "\x1b[0m"

-- [[ opencmd ]]
local function opencmd(cmd)
	local command = io.popen(cmd, "r")
	local command_output = command:read("*a")
	command:close()
	command_output = command_output:match("%C+")
	return command_output
end

-- [[ Shell ]]
local function shell()
	return opencmd("basename $SHELL")
end

-- [[ Pkgs ]]
local function pkgs()
	return opencmd([[
      getPackages() {
        count_params() { echo "${#}"; }
        for PM in apt \
                  dnf \
                  emerge \
                  nix-env \
                  pacman \
                  rpm \
                  xbps-query
        do
          [ -x "$(command -v "$PM")" ] && PKG_MANAGER="${PKG_MANAGER} ${PM}"
        done
        for MANAGER in ${PKG_MANAGER#\ }; do
          case "$MANAGER" in
            apt       ) GET_PKGS="$(apt list --installed 2>/dev/null | wc -l)"
            ;;
            dnf       ) GET_PKGS="$(dnf list installed | wc -l)"
            ;;
            nix-env   ) GET_PKGS="$(nix-store -q --requisites /run/current-system/sw | wc -l)"
                        MANAGER='nix'
            ;;
            pacman    ) GET_PKGS=$(pacman -Q | wc -l)
            ;;
            rpm       ) GET_PKGS="$(rpm -qa --last | wc -l)"
            ;;
            xbps-query) GET_PKGS="$(xbps-query -l | wc -l)"
            ;;
          esac
          TOTAL_PKGS="${GET_PKGS}"
          case "$TOTAL_PKGS" in
            0|1) TOTAL_PKGS='?'
                 MANAGER='Unknown'
            ;;
          esac
          PKGS_INFO="${PKGS_INFO}${TOTAL_PKGS} (${MANAGER}), "
        done
        printf "${c5}${*}${rs}%s" "${PKGS_INFO%,\ }"
      }
      echo "$(getPackages)"
    ]])
end

-- [[ os family ]]
local function os_family()
	local osfamily = package.config:sub(1, 1)
	if osfamily == "/" then
		return "unix"
	elseif osfamily == "\\" then
		return "windows"
	end
end

-- [[ Window Manager ]]
local function wm()
	return opencmd([[xprop -id "$(xprop -root _NET_SUPPORTING_WM_CHECK | cut -d' ' -f5)" _NET_WM_NAME | cut -d'"' -f2]])
end

-- [[ Memory ]]
local function mem()
	return opencmd([[free -h | awk '/^Mem:/ {print $3 "/" $2}' | sed 's/i//g']])
end

-- [[ CPU ]]
local function cpu()
	if os_family() == "unix" then
		return opencmd("lscpu | grep 'Model name' | sed 's/Model name://g' | xargs")
	else
		return "Unknown CPU Info"
	end
end

-- [[ Editor ]]
local function ed()
	return opencmd([[echo $EDITOR]])
end

-- [[ Distro ]]
local function distro()
	local distro_command = io.open("/etc/os-release", "r")
	local distro_temp = distro_command:read("*a")
	distro_command:close()
	local DISTRO = distro_temp:match("NAME.%W?%w+", 1):gsub('"', ""):gsub("NAME=", "")
	return DISTRO
end

-- [[ Ascii ]]
local function ascii(info)
	if string.lower(info.os):find("ubuntu") then
		local ASCII = {
			YELLOW .. "           _   " .. NOCOL,
			YELLOW .. "       ---(_)  " .. NOCOL,
			YELLOW .. "   _/  ---  \\  " .. NOCOL,
			YELLOW .. "  (_) |   |    " .. NOCOL,
			YELLOW .. "    \\  --- _/  " .. NOCOL,
			YELLOW .. "       ---(_)  " .. NOCOL,
			NOCOL .. "               " .. NOCOL,
			NOCOL .. "               " .. NOCOL,
		}
		return ASCII
	elseif string.lower(info.os):find("arch") then
		local ASCII = {
			CYAN .. "      /\\         " .. NOCOL,
			CYAN .. "     /  \\        " .. NOCOL,
			CYAN .. "    /\\   \\       " .. NOCOL,
			CYAN .. "   /      \\      " .. NOCOL,
			CYAN .. "  /   ,,   \\     " .. NOCOL,
			CYAN .. " /   |  |  -\\    " .. NOCOL,
			CYAN .. "/_-''    ''-_\\   " .. NOCOL,
			CYAN .. "                  " .. NOCOL,
		}
		return ASCII
	elseif string.lower(info.os):find("manjaro") then
		local ASCII = {
			GREEN .. "||||||||| ||||  " .. NOCOL,
			GREEN .. "||||||||| ||||  " .. NOCOL,
			GREEN .. "||||      ||||  " .. NOCOL,
			GREEN .. "|||| |||| ||||  " .. NOCOL,
			GREEN .. "|||| |||| ||||  " .. NOCOL,
			GREEN .. "|||| |||| ||||  " .. NOCOL,
			GREEN .. "|||| |||| ||||  " .. NOCOL,
			GREEN .. "                " .. NOCOL,
		}
		return ASCII
	elseif string.lower(info.os):find("gentoo") then
		local ASCII = {
			PURPLE .. "    .-----.      " .. NOCOL,
			PURPLE .. "  .`    _  `.    " .. NOCOL,
			PURPLE .. "  `.   (_)   `.  " .. NOCOL,
			PURPLE .. "    `.        /  " .. NOCOL,
			PURPLE .. "   .`       .`   " .. NOCOL,
			PURPLE .. "  /       .`     " .. NOCOL,
			PURPLE .. "  \\____.-`       " .. NOCOL,
			PURPLE .. "                  " .. NOCOL,
		}
		return ASCII
	elseif string.lower(info.os):find("fedora") then
		local ASCII = {
			BLUE .. "                 " .. NOCOL,
			BLUE .. "   /¯¯\\         " .. NOCOL,
			BLUE .. " __|__          " .. NOCOL,
			BLUE .. "/  T            " .. NOCOL,
			BLUE .. "\\__/            " .. NOCOL,
			BLUE .. "                 " .. NOCOL,
			BLUE .. "                 " .. NOCOL,
			BLUE .. "                 " .. NOCOL,
		}
		return ASCII
	elseif string.lower(info.os):find("debian") then
		local ASCII = {
			RED .. "     ,---._   " .. NOCOL,
			RED .. "   /`  __  \\  " .. NOCOL,
			RED .. "  |   /    |  " .. NOCOL,
			RED .. "  |   `.__.`  " .. NOCOL,
			RED .. "   \\          " .. NOCOL,
			RED .. "    `-,_      " .. NOCOL,
			RED .. "              " .. NOCOL,
			RED .. "              " .. NOCOL,
		}
		return ASCII
	elseif string.lower(info.os):find("alpine") then
		local ASCII = {
			BLUE .. "        /\\            " .. NOCOL,
			BLUE .. "       /  \\           " .. NOCOL,
			BLUE .. "      / /\\ \\  /\\      " .. NOCOL,
			BLUE .. "     / /  \\ \\/  \\     " .. NOCOL,
			BLUE .. "    / /    \\ \\/\\ \\    " .. NOCOL,
			BLUE .. "   / / /|   \\ \\ \\ \\   " .. NOCOL,
			BLUE .. "  /_/ /_|    \\_\\ \\_\\  " .. NOCOL,
			BLUE .. "                          " .. NOCOL,
		}
		return ASCII
	elseif string.lower(info.os):find("void") then
		local ASCII = {
			GREEN .. "    _______      " .. NOCOL,
			GREEN .. " _ \\______ -     " .. NOCOL,
			GREEN .. "| \\  ___  \\ |    " .. NOCOL,
			GREEN .. "| | /   \\ | |    " .. NOCOL,
			GREEN .. "| | \\___/ | |    " .. NOCOL,
			GREEN .. "| \\______ \\_|    " .. NOCOL,
			GREEN .. " -_______\\         ",
			GREEN .. "                    ",
		}
		return ASCII
	elseif string.lower(info.os):find("android") then
		local ASCII = {
			GREEN .. "              " .. NOCOL,
			GREEN .. "  \\  _  /     " .. NOCOL,
			GREEN .. ' .-"" ""-.    ' .. NOCOL,
			GREEN .. "/  O   O  \\   " .. NOCOL,
			GREEN .. "|_________|   " .. NOCOL,
			GREEN .. "              " .. NOCOL,
			GREEN .. "              " .. NOCOL,
			GREEN .. "              " .. NOCOL,
		}
		return ASCII
	else
		math.randomseed(os.time())
		RAND = math.random()
		local ASCII = {
			WHITE .. "         " .. NOCOL,
			WHITE .. "  .~.    " .. NOCOL,
			WHITE .. "  /V\\    " .. NOCOL,
			WHITE .. " // \\\\   " .. NOCOL,
			WHITE .. "/(   )\\  " .. NOCOL,
			WHITE .. " ^`~'^   " .. NOCOL,
			WHITE .. "         " .. NOCOL,
			WHITE .. "         " .. NOCOL,
		}
		return ASCII
	end
end

-- [[ Fetch ]]
local function fetch()
	local os_type = os_family()
	if os_type == "unix" then
		KERN = opencmd("uname")
		KERN_RELEASE = opencmd("uname -r")
		OS_NAME = opencmd("uname -o")
		if KERN:lower() == "linux" then
			if OS_NAME:lower() == "android" then
				local FETCH = {
					os = "Android",
					wm = "AndroidWM",
					kn = KERN .. KERN_RELEASE,
					sh = shell(),
				}
				return FETCH
			elseif OS_NAME:lower() == "gnu/linux" or OS_NAME:lower() == "linux" then
				local FETCH = {
					os = distro(),
					wm = wm(),
					kn = KERN .. " " .. KERN_RELEASE,
					sh = shell(),
				}
				return FETCH
			else
				local FETCH = {
					os = ":(",
					wm = ":(",
					kn = ":(",
					sh = ":(",
				}
				return FETCH
			end
		else
			local FETCH = {
				os = "Maybe or Minix, this is still in WIP",
				wm = "¯\\_(ツ)_/¯",
				kn = "¯\\_(ツ)_/¯",
				sh = "¯\\_(ツ)_/¯",
			}
			return FETCH
		end
	else
		local FETCH = {
			os = "you defeated me... (your os is CURRENTLY unsupported)",
			wm = "not sure",
			kn = "unknown",
			sh = "unknown",
		}
		return FETCH
	end
end

-- [[ Print ]]
if arg[1] == "--icons" or arg[1] == "-i" then
	local info = fetch()
	ART = ascii(info)
	io.write(ART[1] .. GREEN .. "\u{f05a}  | " .. NOCOL .. distro() .. "\n")
	io.write(ART[2] .. GREEN .. "\u{f2d0}  | " .. NOCOL .. wm() .. "\n")
	io.write(ART[3] .. GREEN .. "\u{f487}  | " .. NOCOL .. pkgs() .. "\n")
	io.write(ART[4] .. GREEN .. "\u{e795}  | " .. NOCOL .. shell() .. "\n")
	io.write(ART[5] .. GREEN .. "\u{f044}  | " .. NOCOL .. ed() .. "\n")
	io.write(ART[6] .. GREEN .. "\u{f2db}  | " .. NOCOL .. cpu() .. "\n")
	io.write(ART[7] .. GREEN .. "\u{f200}  | " .. NOCOL .. mem() .. "\n")
	io.write(
		ART[8]
			.. RED
			.. "██"
			.. GREEN
			.. "██"
			.. YELLOW
			.. "██"
			.. BLUE
			.. "██"
			.. PURPLE
			.. "██"
			.. CYAN
			.. "██\n"
	)
	io.write("\n")
elseif arg[1] == "--off" or arg[1] == "-f" then
	local info = fetch()
	ART = ascii(info)
	io.write(GREEN .. "os    | " .. NOCOL .. distro() .. "\n")
	io.write(GREEN .. "wm    | " .. NOCOL .. wm() .. "\n")
	io.write(GREEN .. "pkgs  | " .. NOCOL .. pkgs() .. "\n")
	io.write(GREEN .. "Shell | " .. NOCOL .. shell() .. "\n")
	io.write(GREEN .. "ed    | " .. NOCOL .. ed() .. "\n")
	io.write(GREEN .. "cpu   | " .. NOCOL .. cpu() .. "\n")
	io.write(GREEN .. "mem   | " .. NOCOL .. mem() .. "\n")
	io.write(
		RED
			.. "██"
			.. GREEN
			.. "██"
			.. YELLOW
			.. "██"
			.. BLUE
			.. "██"
			.. PURPLE
			.. "██"
			.. CYAN
			.. "██\n"
	)
	io.write("\n")
elseif arg[1] == "--help" or arg[1] == "-h" then
	io.write([[
      --help, -h        Display this message
      --icons, -i       Use nerd fonts
      --off, -f         disables the ascii art
    ]])
else
	local info = fetch()
	ART = ascii(info)
	io.write(ART[1] .. GREEN .. "os    | " .. NOCOL .. distro() .. "\n")
	io.write(ART[2] .. GREEN .. "wm    | " .. NOCOL .. wm() .. "\n")
	io.write(ART[3] .. GREEN .. "pkgs  | " .. NOCOL .. pkgs() .. "\n")
	io.write(ART[4] .. GREEN .. "shell | " .. NOCOL .. shell() .. "\n")
	io.write(ART[5] .. GREEN .. "ed    | " .. NOCOL .. ed() .. "\n")
	io.write(ART[6] .. GREEN .. "cpu   | " .. NOCOL .. cpu() .. "\n")
	io.write(ART[7] .. GREEN .. "mem   | " .. NOCOL .. mem() .. "\n")
	io.write(
		ART[8]
			.. RED
			.. "██"
			.. GREEN
			.. "██"
			.. YELLOW
			.. "██"
			.. BLUE
			.. "██"
			.. PURPLE
			.. "██"
			.. CYAN
			.. "██\n"
	)
	io.write("\n")
end
