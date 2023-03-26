local M = {}

function M.setup()
	local xresources = require("beautiful.xresources")
	local dpi = xresources.apply_dpi

	local gfs = require("gears.filesystem")
	local themes_path = gfs.get_themes_dir()

	return {
		useless_gap = dpi(2),
		font = "Ubuntu Mono 12",

		bg_normal = "#21252b",
		bg_focus = "#535d6c",
		bg_urgent = "#ff0000",
		bg_minimize = "#444444",
		bg_systray = "#21252b",

		fg_normal = "#ffffff",
		fg_focus = "#ffffff",
		fg_urgent = "#ffffff",
		fg_minimize = "#ffffff",

		border_width = dpi(2),
		border_normal = "#5c6370",
		border_focus = "#61afef",
		border_marked = "#91231c",


		taglist_fg_empty = "#5c6370",
		-- theme.taglist_fg_focus = "#d55fde",
		taglist_bg_focus = "#d55fde",
		-- theme.taglist_fg_occupied = "#61afef",

		tasklist_fg_normal = "#8C8C8C",
		tasklist_fg_focus = "#fff",
		tasklist_bg_normal = "#31353f",
		tasklist_bg_focus = "#31353f",
		tasklist_plain_task_name = true,

		hotkeys_font = "Ubuntu Mono 12",
		hotkeys_description_font = "Ubuntu Mono 12",

		widget_label_fg = "#5c6370",

		threshold_normal_fg = "#61afef",
		threshold_medium_fg = "#d68910",
		threshold_high_fg = "#ba4a00",
		threshold_critical_fg = "#cb4335",

		wallpaper = themes_path .. "default/background.png",

		layout_fairh = themes_path .. "default/layouts/fairhw.png",
		layout_fairv = themes_path .. "default/layouts/fairvw.png",
		layout_floating = themes_path .. "default/layouts/floatingw.png",
		layout_magnifier = themes_path .. "default/layouts/magnifierw.png",
		layout_max = themes_path .. "default/layouts/maxw.png",
		layout_fullscreen = themes_path .. "default/layouts/fullscreenw.png",
		layout_tilebottom = themes_path .. "default/layouts/tilebottomw.png",
		layout_tileleft = themes_path .. "default/layouts/tileleftw.png",
		layout_tile = themes_path .. "default/layouts/tilew.png",
		layout_tiletop = themes_path .. "default/layouts/tiletopw.png",
		layout_spiral = themes_path .. "default/layouts/spiralw.png",
		layout_dwindle = themes_path .. "default/layouts/dwindlew.png",
		layout_cornernw = themes_path .. "default/layouts/cornernww.png",
		layout_cornerne = themes_path .. "default/layouts/cornernew.png",
		layout_cornersw = themes_path .. "default/layouts/cornersww.png",
		layout_cornerse = themes_path .. "default/layouts/cornersew.png",

		icon_theme = "Papirus",
	}
end

return M
