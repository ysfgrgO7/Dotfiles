local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()

local theme = {}
theme.font = "JetbrainsMono Nerd Font 14"

theme.white = "#dee1e6"
theme.black = "#1E1E1E"
theme.grey = "#444444"
theme.grey1 = "#313131"
theme.grey2 = "#3a3a3a"
theme.red = "#D16969"
theme.pink = "#bb7cb6"
theme.green = "#B5CEA8"
theme.green1 = "#4EC994"
theme.blue = "#569CD6"
theme.nord_blue = "#60a6e0"
theme.orange = "#d3967d"
theme.cyan = "#9CDCFE"
theme.yellow = "#e1c487"
theme.purple = "#c68aee"

theme.bg_normal = theme.black
theme.bg_focus = theme.grey1
theme.bg_urgent = theme.red
theme.bg_minimize = theme.grey
theme.bg_systray = theme.black

theme.icon = "Material Design Icons"

theme.fg_normal = theme.white
theme.fg_focus = theme.white
theme.fg_urgent = theme.white
theme.fg_minimize = theme.white

theme.border_normal = theme.black
theme.border_focus = theme.green
theme.border_marked = theme.red

theme.useless_gap = dpi(5)
theme.border_width = dpi(2)

-- Generate taglist squares:
local taglist_square_size = dpi(4)
theme.taglist_squares_sel = 0
theme.taglist_squares_unsel = 0

theme.taglist_fg_occupied = theme.white
theme.taglist_fg_urgent = theme.red
theme.taglist_fg_focus = theme.white
theme.taglist_fg_empty = theme.grey

-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = themes_path .. "default/submenu.png"
theme.menu_height = dpi(15)
theme.menu_width = dpi(100)

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua

-- Define the image to load
theme.titlebar_close_button_focus = theme_assets.taglist_squares_sel(dpi(60), theme.red)
theme.titlebar_close_button_normal = theme_assets.taglist_squares_sel(dpi(60), theme.red)

theme.titlebar_maximized_button_focus_inactive = theme_assets.taglist_squares_unsel(dpi(60), theme.green)
theme.titlebar_maximized_button_focus_active = theme_assets.taglist_squares_sel(dpi(60), theme.green)

theme.titlebar_maximized_button_normal_inactive = theme_assets.taglist_squares_unsel(dpi(60), theme.green)
theme.titlebar_maximized_button_normal_active = theme_assets.taglist_squares_sel(dpi(60), theme.green)

theme.titlebar_minimize_button_focus = theme_assets.taglist_squares_sel(dpi(60), theme.yellow)
theme.titlebar_minimize_button_normal = theme_assets.taglist_squares_sel(dpi(60), theme.yellow)

theme.titlebar_ontop_button_normal_inactive = themes_path .. "default/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive = themes_path .. "default/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = themes_path .. "default/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active = themes_path .. "default/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = themes_path .. "default/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive = themes_path .. "default/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = themes_path .. "default/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active = themes_path .. "default/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = themes_path .. "default/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive = themes_path .. "default/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = themes_path .. "default/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active = themes_path .. "default/titlebar/floating_focus_active.png"

theme.wallpaper = themes_path .. "default/background.png"

-- You can use your own layout icons like this:
theme.layout_fairh = themes_path .. "default/layouts/fairhw.png"
theme.layout_fairv = themes_path .. "default/layouts/fairvw.png"
theme.layout_floating = themes_path .. "default/layouts/floatingw.png"
theme.layout_magnifier = themes_path .. "default/layouts/magnifierw.png"
theme.layout_max = themes_path .. "default/layouts/maxw.png"
theme.layout_fullscreen = themes_path .. "default/layouts/fullscreenw.png"
theme.layout_tilebottom = themes_path .. "default/layouts/tilebottomw.png"
theme.layout_tileleft = themes_path .. "default/layouts/tileleftw.png"
theme.layout_tile = themes_path .. "default/layouts/tilew.png"
theme.layout_tiletop = themes_path .. "default/layouts/tiletopw.png"
theme.layout_spiral = themes_path .. "default/layouts/spiralw.png"
theme.layout_dwindle = themes_path .. "default/layouts/dwindlew.png"
theme.layout_cornernw = themes_path .. "default/layouts/cornernww.png"
theme.layout_cornerne = themes_path .. "default/layouts/cornernew.png"
theme.layout_cornersw = themes_path .. "default/layouts/cornersww.png"
theme.layout_cornerse = themes_path .. "default/layouts/cornersew.png"

theme.awesome_icon = theme_assets.awesome_icon(theme.menu_height, theme.bg_focus, theme.fg_focus)

theme.icon_theme = nil

return theme
