local api = { screen = screen }
local awful = require("awful")
local wibox = require("wibox")
local ruled = require("ruled")
local naughty = require("naughty")
local beautiful = require("beautiful")
local list = require("widgets.list")
local icons = require("util.icons")

ruled.notification.connect_signal("request::rules", function()
	ruled.notification.append_rules({
		{
			rule = {},
			properties = {
				screen = api.screen.primary,
				never_timeout = true,
				position = "top_middle",
				ignore = true,
				callback = function(n)
					n.timestamp = os.time()
				end,
			},
		},
		{
			rule = {
				urgency = "critical",
			},
			properties = {
				ignore = false,
				bg = beautiful.notification_bg_critical,
			},
		},
	})
end)

local notifications = {}

naughty.connect_signal("added", function(n)
	table.insert(notifications, 1, n)
end)

naughty.connect_signal("destroyed", function(n)
	for index, value in ipairs(notifications) do
		if value == n then
			table.remove(notifications, index)
			return
		end
	end
end)

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
	if notification.image then
		return notification.image
	end

	if notification.app_icon then
		return icons.lookup_filename(notification.app_icon, beautiful.notification_icon_size)
	end

	return icons.lookup_filename("dialog-information", beautiful.notification_icon_size)
end

local notification_list = list({
	empty_widget = {
		widget = wibox.container.place,
		valign = "center",
		halign = "center",
		forced_width = 400,
		forced_height = 50,
		{
			widget = wibox.widget.textbox,
			text = "No notifications",
		},
	},
	item_bg = beautiful.notification_bg,
	item_bg_selected = beautiful.notification_bg_selected,
	item_border_width = 2,
	item_shape = require("util.fn").partial_right(require("gears.shape").rounded_rect, 5),
	item_creator = function(_, value)
		return wibox.widget({
			widget = wibox.container.constraint,
			strategy = "exact",
			width = 400,
			height = 100,
			{
				widget = wibox.container.margin,
				margins = 10,
				{
					layout = wibox.layout.fixed.vertical,
					{
						layout = wibox.layout.flex.horizontal,
						{
							widget = wibox.widget.textbox,
							text = value.app_name,
							font = beautiful.notification_appname_font,
						},
						{
							widget = wibox.container.place,
							halign = "right",
							{
								widget = wibox.widget.textbox,
								text = format_duration(os.time() - value.timestamp),
								font = beautiful.notification_age_font,
							},
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
								layout = wibox.layout.fixed.horizontal,
								spacing = 5,
								{
									widget = wibox.widget.imagebox,
									image = get_icon(value),
								},
								{
									widget = wibox.container.place,
									valign = "center",
									{
										layout = wibox.layout.flex.vertical,
										{
											widget = wibox.widget.textbox,
											markup = string.format("<b>%s</b>", value.title),
										},
										{
											widget = wibox.widget.textbox,
											text = value.message,
										},
									},
								},
							},
						},
					},
				},
			},
		})
	end,
})

local notification_popup = awful.popup({
	visible = false,
	placement = function(c, args)
		args.honor_workarea = true
		awful.placement.top(c, { honor_workarea = true })
	end,
	ontop = true,
	border_color = beautiful.border_focus,
	border_width = beautiful.border_width,
	widget = {
		widget = wibox.container.margin,
		margins = 10,
		notification_list,
	},
})

notification_list:connect_signal("selection::stopped", function()
	notification_popup.visible = false
end)

notification_list:connect_signal("selection::confirmed", function(self, selected_index)
	local notification = notifications[selected_index]
	if notification then
		notification:destroy(naughty.notification_closed_reason.dismissed_by_user)
		notification_popup.visible = false
	end
end)

notification_list:connect_signal("selection::keypressed", function(self, grabber, mod, key, selected_index)
	if key == "d" then
		local notification = notifications[selected_index]
		if notification then
			notification:destroy(naughty.notification_closed_reason.silent)
			self:set_items(notifications)
			self:select(selected_index)
		end
		return
	end

	if key == "D" then
		self:clear()
		naughty.destroy_all_notifications(nil, naughty.notification_closed_reason.silent)
		notification_popup.visible = false
		grabber:stop()
		return
	end
end)

local function show()
	notification_list:set_items(notifications)
	notification_list:start_selection()
	notification_popup.visible = true
end

return {
	show = show,
}
