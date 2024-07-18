local M = {}

function M.setup(opts)
	local flavor = require("themes.catppuccin." .. opts.flavor)

	return {
		fg_normal = flavor.text,
		bg_normal = flavor.mantle,
		fg_focus = "#ffffff",
		bg_focus = flavor.base,
		fg_urgent = flavor.red,
		bg_urgent = flavor.flamingo,
		fg_minimize = flavor.surface2,
		bg_minimize = flavor.base,
		bg_systray = flavor.mantle,

		border_normal = flavor.surface2,
		border_focus = flavor.blue,
		border_marked = flavor.yellow,

		taglist_fg = flavor.text,
		taglist_fg_focus = flavor.mauve,
		taglist_bg_focus = flavor.surface0,
		taglist_fg_not_empty = "#5c6370",
		taglist_shape_border_color = flavor.surface2,

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

		clock_fg = flavor.text,
	}
end

return M
