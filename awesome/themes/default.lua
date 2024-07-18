local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local gfs = require("gears.filesystem")
local default_themes_path = gfs.get_themes_dir()
local partial_right = require("util.func").partial_right

return {
	useless_gap = dpi(2),
	icon_theme = "Papirus",
	font = "Ubuntu 12",

	border_width = dpi(2),
	taglist_style = "circles",
	systray_icon_spacing = 10,
	wibar_margins = { top = 5, bottom = 1, left = 5, right = 5 },
	wibar_shape = partial_right(require("gears.shape").rounded_rect, 8),
	wibar_height = 30,
	titlebar_font = "Ubuntu 11",
	titlebar_size = 20,

	window_count_font = "JetBrains Mono 12",
	widget_font = "JetBrains Mono 12",
	widget_label_spacing = 3,
	clock_font = "JetBrains Mono 12",

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
