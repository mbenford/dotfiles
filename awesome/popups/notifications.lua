local awful = require("awful")
local wibox = require("wibox")
local ruled = require("ruled")
local naughty = require("naughty")
local beautiful = require("beautiful")
local list = require("widgets.list")
local popup_util = require("util.popup")
local ez = require("util.ez")
local fn = require("util.fn")
local icons = require("util.icons")

ruled.notification.connect_signal("request::rules", function()
	ruled.notification.append_rules({
		{
			rule = {},
			properties = {
				never_timeout = true,
				ignore = true,
				callback = function(n)
					n.timestamp = os.time()
				end,
			},
		},
	})
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

local notifications = list({
	margins = 10,
	empty_widget = wibox.widget({
		widget = wibox.container.place,
		valign = "center",
		halign = "center",
		forced_width = 400,
		forced_height = 50,
		{
			widget = wibox.widget.textbox,
			text = "Nothing to see here",
		},
	}),
	item_bg = beautiful.notification_bg,
	item_bg_selected = beautiful.notification_bg_selected,
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
										layout = wibox.layout.align.vertical,
										{
											widget = wibox.widget.textbox,
											forced_height = 20,
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

local function show()
	local popup = awful.popup({
		placement = function(c)
			awful.placement.top(c, { honor_workarea = true })
		end,
		ontop = true,
		border_color = beautiful.popup_border_color,
		border_width = beautiful.popup_border_width,
		widget = notifications,
	})
	popup_util.enhance(popup, {
		timeout = 5,
		keybindings = ez.keys({
			["h"] = fn.bind_obj(notifications, "prev_page"),
			["j"] = fn.bind_obj(notifications, "next_item"),
			["k"] = fn.bind_obj(notifications, "prev_item"),
			["l"] = fn.bind_obj(notifications, "next_page"),
			["d"] = function()
				local selected = notifications:selected()
				local notification = naughty.active[selected]
				if notification then
					notification:destroy(naughty.notification_closed_reason.silent)
					notifications:set_items(naughty.active)
					notifications:select(selected)
				end
			end,
			["S-D"] = function()
				notifications:clear()
				naughty.destroy_all_notifications(nil, naughty.notification_closed_reason.silent)
				popup.visible = false
			end,
			["Return"] = function()
				local notification = naughty.active[notifications:selected()]
				if notification then
					notification:destroy(naughty.notification_closed_reason.dismissed_by_user)
					popup.visible = false
				end
			end,
		}),
	})
	notifications:set_items(naughty.active)
end

return {
	show = show,
}
