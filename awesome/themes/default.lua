local gears = require("gears")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local default_themes_path = gears.filesystem.get_themes_dir()
local fn = require("util.fn")

return {
	useless_gap = dpi(2),
	icon_theme = "Papirus",
	font = "Ubuntu 12",

	border_width = dpi(2),
	taglist_style = "circles",
	taglist_circles_selected = "",
	taglist_circles_not_empty = "",
	taglist_circles_empty = "",
	systray_icon_spacing = 10,
	wibar_margins = { top = 5, bottom = 1, left = 5, right = 5 },
	wibar_shape = fn.bind_right(gears.shape.rounded_rect, 8),
	wibar_height = 30,
	titlebar_font = "Ubuntu 12",
	titlebar_size = 25,

	window_count_font = "Symbols Nerd Font 12",
	widget_font = "JetBrains Mono 12",
	widget_label_spacing = 3,
	clock_font = "Ubuntu 12",

	popup_title_font = "Ubuntu 12",

	notification_appname_font = "Ubuntu 11",
	notification_age_font = "Ubuntu 11",
	notification_position = "top",
	notification_border_width = 2,
	notification_spacing = 10,
	notification_margin = 10,
	notification_icon_size = 22,
	notification_minimum_width = 400,
	notification_maximum_width = 400,
	notification_maximum_height = 64,

	list_item_shape = fn.bind_right(gears.shape.rounded_rect, 5),
	popup_volume_progress_shape = fn.bind_right(gears.shape.rounded_rect, 5),
	window_name_shape = fn.bind_right(gears.shape.rounded_rect, 8),

	calendar_font = "Ubuntu 12",
	wallpaper = default_themes_path .. "default/background.png",
	layout_fairh = default_themes_path .. "default/layouts/fairhw.png",
	layout_fairv = default_themes_path .. "default/layouts/fairvw.png",
	layout_floating = default_themes_path .. "default/layouts/floatingw.png",
	layout_magnifier = default_themes_path .. "default/layouts/magnifierw.png",
	layout_max = default_themes_path .. "default/layouts/maxw.png",
	layout_fullscreen = default_themes_path .. "default/layouts/fullscreenw.png",
	layout_tilebottom = default_themes_path .. "default/layouts/tilebottomw.png",
	layout_tileleft = default_themes_path .. "default/layouts/tileleftw.png",
	layout_tile = default_themes_path .. "default/layouts/tilew.png",
	layout_tiletop = default_themes_path .. "default/layouts/tiletopw.png",
	layout_spiral = default_themes_path .. "default/layouts/spiralw.png",
	layout_dwindle = default_themes_path .. "default/layouts/dwindlew.png",
	layout_cornernw = default_themes_path .. "default/layouts/cornernww.png",
	layout_cornerne = default_themes_path .. "default/layouts/cornernew.png",
	layout_cornersw = default_themes_path .. "default/layouts/cornersww.png",
	layout_cornerse = default_themes_path .. "default/layouts/cornersew.png",
}
