local M = {}

function M.setup(opts)
	local xresources = require("beautiful.xresources")
	local dpi = xresources.apply_dpi

	local gfs = require("gears.filesystem")
	local default_themes_path = gfs.get_themes_dir()
	local flavor = require('themes.catppuccin.' .. opts.flavor)

	return {
		useless_gap = dpi(2),
		font = "Ubuntu Mono 12",

		bg_normal = flavor.mantle,
		bg_focus = flavor.base,
		bg_urgent = flavor.flamingo,
		bg_minimize = "#444444",
		bg_systray = flavor.mantle,

		fg_normal = flavor.text,
		fg_focus = "#ffffff",
		fg_urgent = "#ffffff",
		fg_minimize = "#ffffff",

		border_width = dpi(2),
		border_normal = flavor.surface2,
		border_focus = flavor.blue,
		border_marked = "#91231c",

		taglist_fg_empty = "#5c6370",
		taglist_bg_focus = flavor.mauve,

		tasklist_fg_normal = "#8C8C8C",
		tasklist_fg_focus = flavor.text,
		tasklist_bg_normal = "#24273A",
		tasklist_bg_focus = "#24273A",
		tasklist_plain_task_name = true,

		notification_icon_size = 48,
		notification_max_width = 400,

		widget_label_fg = "#5c6370",

		threshold_normal_fg = "#61afef",
		threshold_medium_fg = "#d68910",
		threshold_high_fg = "#ba4a00",
		threshold_critical_fg = "#cb4335",

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

		icon_theme = "Papirus",
	}
end

return M
