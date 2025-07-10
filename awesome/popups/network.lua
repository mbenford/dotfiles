local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local widgets = require("widgets")
local network = require("util.network")
local fn = require("util.fn")
local ez = require("util.ez")
local Popup = require("util.popup")
local icons = require("icons")

local grade_color = {
	[5] = beautiful.wifi_signal_grade_5_color,
	[4] = beautiful.wifi_signal_grade_4_color,
	[3] = beautiful.wifi_signal_grade_3_color,
	[2] = beautiful.wifi_signal_grade_2_color,
	[1] = beautiful.wifi_signal_grade_1_color,
}
local network_list = widgets.list({
	layout = {
		layout = wibox.layout.flex.vertical,
		max_widget_size = 50,
		spacing = 10,
	},
	page_size = 10,
	item_creator = function(_, item)
		local signal_grade = wibox.widget({
			layout = wibox.layout.fixed.horizontal,
			spacing = 3,
		})

		local grade = require("util.network").signal_to_grade(item.signal)
		for i = 1, 5, 1 do
			signal_grade:add(wibox.widget({
				widget = wibox.widget.textbox,
				font = "JetBrains Mono 10",
				text = i <= grade and "●" or "○",
				halign = "right",
			}))
		end

		return wibox.widget({
			widget = wibox.container.margin,
			margins = 10,
			{
				layout = wibox.layout.fixed.horizontal,
				spacing = 5,
				fill_space = true,
				{
					widget = icons.system.icon,
					name = item.security == "" and "network-wireless" or "network-wireless-encrypted",
					size = 24,
				},
				{
					widget = wibox.widget.textbox,
					text = item.ssid,
				},
				{
					widget = wibox.container.background,
					fg = grade_color[grade],
					{
						widget = wibox.container.place,
						halign = "right",
						signal_grade,
					},
				},
			},
		})
	end,
})

local scanning_message = wibox.widget({
	widget = wibox.container.constraint,
	strategy = "exact",
	height = 50,
	{
		widget = wibox.widget.textbox,
		text = "Scanning networks...",
		halign = "center",
	},
})

local content = wibox.widget({
	widget = wibox.container.constraint,
	strategy = "exact",
	width = 400,
	scanning_message,
})

local popup = Popup({
	placement = function(c)
		awful.placement.top_right(c, { honor_workarea = true })
	end,
	ontop = true,
	border_color = beautiful.popup_border_color,
	border_width = beautiful.popup_border_width,
	widget = {
		widget = wibox.container.constraint,
		strategy = "exact",
		height = 300,
		{
			widget = wibox.container.margin,
			margins = 10,
			content,
		},
	},
})

popup:xprops({
	position = "right",
})
popup:decorations({
	title = { text = "Wireless Networks" },
})
popup:keygrabber({
	timeout = 60,
	keybindings = ez.keys({
		["j"] = fn.bind_obj(network_list, "next_item"),
		["k"] = fn.bind_obj(network_list, "prev_item"),
		["u"] = function()
			content.widget = scanning_message
			network.scan({ rescan = "yes" }):next(function(networks)
				network_list:set_items(networks)
				content.widget = network_list
			end)
		end,
		["Return"] = function()
			network.connect()
		end,
	}),
})

return {
	show_wifi = function()
		content.widget = scanning_message
		popup:show({ screen = screen.primary })
		network.scan({ rescan = "yes" }):next(function(networks)
			network_list:set_items(networks)
			content.widget = network_list
		end)
	end,
}
