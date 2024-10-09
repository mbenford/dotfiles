local awful = require("awful")
local wibox = require("wibox")
local naughty = require("naughty")
local beautiful = require("beautiful")
local widgets = require("widgets")
local popup_util = require("util.popup")
local ez = require("util.ez")
local fn = require("util.fn")
local string_util = require("util.string")
local icons = require("icons")

local function format_duration(value)
	if value < 60 then
		return "now"
	end

	if value < 3600 then
		return string.format("%dm", math.floor(value / 60))
	end

	return string.format("%dh", math.floor(value / 3600))
end

local function get_icon(notification)
	local source = notification.webapp_icon or notification.app_icon or notification.app_name
	if source:find("^file://") ~= nil then
		return wibox.widget({
			widget = wibox.widget.imagebox,
			image = source:gsub("file://", ""),
			resize = true,
			forced_width = beautiful.notification_icon_size,
			forced_height = beautiful.notification_icon_size,
		})
	end

	return wibox.widget({
		widget = icons.system.icon,
		name = source,
		size = beautiful.notification_icon_size,
	})
end

local function get_source(notification)
	return notification.webapp_url or notification.app_name
end

local function get_message(notification)
	local message = notification.webapp_url and notification.message:gsub(notification.webapp_url, "")
		or notification.message
	return string_util.trim(message:gsub("\n", " "))
end

local notification_list = widgets.list({
	layout = {
		layout = wibox.layout.flex.vertical,
		max_widget_size = 90,
		spacing = 10,
	},
	page_size = 10,
	empty_widget = wibox.widget({
		widget = wibox.container.place,
		valign = "center",
		halign = "center",
		{
			layout = wibox.layout.flex.vertical,
			{
				widget = icons.system.icon,
				name = "checkmark",
				size = 64,
			},
			{
				widget = wibox.widget.textbox,
				text = "You are all caught up!",
			},
		},
	}),
	item_creator = function(_, notification)
		local age = format_duration(os.time() - notification.timestamp)
		local title = string.format("<b>%s</b>", notification.title)
		local icon = get_icon(notification)
		local source = get_source(notification)
		local message = get_message(notification)

		return wibox.widget({
			widget = wibox.container.constraint,
			strategy = "exact",
			height = 110,
			{
				widget = wibox.container.margin,
				margins = 10,
				{
					layout = wibox.layout.align.vertical,
					{
						layout = wibox.layout.align.horizontal,
						forced_height = beautiful.notification_icon_size,
						{
							widget = wibox.container.margin,
							margins = { right = 5 },
							icon,
						},
						{
							widget = wibox.widget.textbox,
							text = source,
							valign = "center",
							font = beautiful.notification_appname_font,
						},
						{
							widget = wibox.widget.textbox,
							text = age,
							font = beautiful.notification_age_font,
							halign = "right",
						},
					},
					{
						widget = wibox.container.margin,
						margins = { top = 5 },
						{
							widget = wibox.container.place,
							valign = "center",
							halign = "left",
							{
								layout = wibox.layout.fixed.vertical,
								{
									widget = wibox.widget.textbox,
									markup = title,
								},
								{
									widget = wibox.widget.textbox,
									text = message,
								},
							},
						},
					},
				},
			},
		})
	end,
})

local popup = awful.popup({
	visible = false,
	placement = function(c)
		awful.placement.top_right(c, { honor_workarea = true })
		awful.placement.stretch_down(c)
	end,
	ontop = true,
	border_color = beautiful.popup_border_color,
	border_width = beautiful.popup_border_width,
	widget = {
		widget = wibox.container.margin,
		margins = 10,
		{
			widget = wibox.container.constraint,
			strategy = "exact",
			width = 400,
			notification_list,
		},
	},
})
popup_util.enhance(popup, {
	decorations = {
		title = { text = "Notifications" },
	},
	timeout = 10,
	keybindings = ez.keys({
		["h"] = fn.bind_obj(notification_list, "prev_page"),
		["j"] = fn.bind_obj(notification_list, "next_item"),
		["k"] = fn.bind_obj(notification_list, "prev_item"),
		["l"] = fn.bind_obj(notification_list, "next_page"),
		["d"] = function()
			local selected = notification_list:selected_index()
			local notification = naughty.active[selected]
			if notification then
				notification:destroy(naughty.notification_closed_reason.silent)
				notification_list:set_items(naughty.active)
				notification_list:select(selected)
			end
		end,
		["S-D"] = function()
			naughty.destroy_all_notifications(nil, naughty.notification_closed_reason.silent)
			notification_list:clear()
			popup.visible = false
		end,
		["Return"] = function()
			local notification = naughty.active[notification_list:selected_index()]
			if notification then
				notification:destroy(naughty.notification_closed_reason.dismissed_by_user)
				popup.visible = false
			end
		end,
	}),
})

return {
	show = function()
		popup.visible = true
		popup.screen = awful.screen.primary
		notification_list:set_items(naughty.active)
	end,
}
