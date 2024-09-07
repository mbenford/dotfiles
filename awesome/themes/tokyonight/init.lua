local gears = require("gears")
local M = {}

function M.setup(opts)
	local flavor = require("themes.tokyonight." .. opts.flavor)

	return {
		fg_normal = flavor.fg,
		bg_normal = flavor.bg_dark,
		fg_focus = flavor.blue7,
		bg_focus = flavor.dark3,
		fg_urgent = flavor.red,
		bg_urgent = flavor.red1,
		fg_minimize = flavor.dark3,
		bg_minimize = flavor.bg_highlight,
		bg_systray = flavor.bg_dark,

		border_normal = flavor.dark5,
		border_focus = flavor.cyan,
		border_marked = flavor.yellow,

		taglist_fg = flavor.fg,
		taglist_fg_focus = flavor.fg,
		taglist_bg_focus = flavor.fg,
		taglist_fg_not_empty = flavor.fg,
		taglist_shape_border_color = flavor.fg,

		tasklist_fg_normal = flavor.fg,
		tasklist_bg_normal = flavor.bg_dark,
		tasklist_fg_focus = flavor.fg,
		tasklist_bg_focus = flavor.bg_dark,
		tasklist_plain_task_name = true,
		tasklist_spacing = 3,
		tasklist_icon_size = 22,

		notification_border_color = flavor.dark5,
		notification_border_color_selected = flavor.dark5,
		notification_bg = flavor.bg_dark,
		notification_bg_selected = flavor.blue7,
		notification_bg_critical = flavor.red1,
		notification_list_page_indicator_normal = flavor.dark5,
		notification_list_page_indicator_selected = flavor.fg,

		notification_icon_fg = flavor.fg,
		notification_icon_unread_fg = flavor.blue2,

		popup_border_width = 2,
		popup_border_color = flavor.blue,

		popup_volume_progress_fg = flavor.blue0,
		popup_volume_progress_bg = flavor.blue7,

		dialog_button_bg = flavor.bg_dark,
		dialog_button_bg_selected = flavor.blue7,

		calendar_weekday_fg = flavor.blue,
		calendar_weekend_fg = flavor.red,
		calendar_header_fg = flavor.blue,
		calendar_focus_fg = flavor.yellow,
		calendar_month_fg = flavor.blue,
		calendar_normal_fg = flavor.fg,
		calendar_day_border_color = flavor.fg_gutter,

		titlebar_fg_normal = flavor.fg,
		titlebar_bg_normal = flavor.bg_dark,
		titlebar_fg_focus = flavor.fg,
		titlebar_bg_focus = flavor.blue7,

		separator_color = flavor.bg_dark,

		widget_label_fg = flavor.cyan,

		distro_fg = flavor.blue,
		wifi_ssid_fg = flavor.fg,

		threshold_normal_fg = flavor.fg,
		threshold_medium_fg = flavor.yellow,
		threshold_high_fg = flavor.red,
		threshold_critical_fg = flavor.red1,

		clock_fg = flavor.fg,
		wibar_bg = gears.color.change_opacity(flavor.bg_dark, 0.95),
	}
end

return M
