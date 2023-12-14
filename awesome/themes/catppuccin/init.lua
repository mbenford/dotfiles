local M = {}

function M.setup(opts)
	local xresources = require("beautiful.xresources")
	local dpi = xresources.apply_dpi

	local gfs = require("gears.filesystem")
	local default_themes_path = gfs.get_themes_dir()
	local flavor = require("themes.catppuccin." .. opts.flavor)

	return {
		useless_gap = dpi(2),
		font = "Ubuntu 11",

		fg_normal = flavor.text,
		fg_focus = "#ffffff",
		fg_urgent = flavor.red,
		fg_minimize = flavor.surface2,

		bg_normal = flavor.mantle,
		bg_focus = flavor.base,
		bg_urgent = flavor.flamingo,
		bg_minimize = flavor.base,
		bg_systray = flavor.mantle,

		border_width = dpi(2),
		border_normal = flavor.surface2,
		border_focus = flavor.blue,
		border_marked = flavor.yellow,

		taglist_fg = flavor.text,
		taglist_fg_focus = flavor.mauve,
		taglist_bg_focus = flavor.surface0,
		taglist_fg_empty = "#5c6370",
		taglist_shape_border_color = flavor.surface2,
		taglist_shape_border_color_focus = flavor.mauve,

		tasklist_fg_normal = flavor.text,
		tasklist_fg_focus = flavor.text,
		tasklist_bg_normal = flavor.base,
		tasklist_bg_focus = flavor.surface0,
		tasklist_plain_task_name = true,
		tasklist_spacing = 3,
		tasklist_icon_size = 22,

		widget_label_fg = "#5c6370",

		distro_fg = flavor.blue,

		threshold_normal_fg = flavor.blue,
		threshold_medium_fg = flavor.yellow,
		threshold_high_fg = flavor.flamingo,
		threshold_critical_fg = flavor.red,

		sensors_font = "Ubuntu Mono 12",

		clock_font = "Ubuntu Bold 11",
		clock_fg = flavor.text,

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
