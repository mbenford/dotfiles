local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local gears = require("gears")
local widgets = require("widgets")
local fn = require("util.fn")
local ez = require("util.ez")
local popup_util = require("util.popup")
local sysutil = require("util.system")
local Promise = require("util.promise")
local dialog = require("popups.dialog")
local icons = require("icons")

local commands = {
	{ text = "Suspend", icon = "system-suspend", exec = "systemctl suspend" },
	{ text = "Lock", icon = "system-lock-screen", exec = "lock", no_confirmation = true },
	{ text = "Logout", icon = "system-log-out", exec = "loginctl terminate-user $USER" },
	{ text = "Reboot", icon = "system-reboot", exec = "systemctl reboot" },
	{ text = "Shutdown", icon = "system-shutdown", exec = "systemctl poweroff" },
}

local action_list = widgets.list({
	layout = {
		layout = wibox.layout.flex.horizontal,
		spacing = 10,
	},
	cycle = true,
	margins = 10,
	items = commands,
	item_creator = function(index, value)
		return wibox.widget({
			widget = wibox.container.margin,
			margins = 10,
			forced_width = 100,
			{
				layout = wibox.layout.fixed.vertical,
				spacing = 10,
				fill_space = true,
				{
					widget = icons.system.icon,
					name = value.icon,
					size = 48,
				},
				{
					widget = wibox.widget.textbox,
					text = value.text,
					halign = "center",
				},
			},
		})
	end,
})

local popup = awful.popup({
	visible = false,
	placement = awful.placement.centered,
	ontop = true,
	border_color = beautiful.popup_border_color,
	border_width = beautiful.popup_border_width,
	widget = {
		widget = wibox.container.background,
		{
			layout = wibox.layout.fixed.vertical,
			{
				widget = wibox.container.margin,
				margins = { top = 10, left = 10, right = 10 },
				{
					layout = wibox.layout.fixed.horizontal,
					fill_space = true,
					{
						id = "hostname",
						widget = wibox.widget.textbox,
					},
					{
						id = "uptime",
						widget = wibox.widget.textbox,
						halign = "right",
					},
				},
			},
			action_list,
		},
	},
})
popup_util.enhance(popup, {
	timeout = 10,
	keybindings = ez.keys({
		["h"] = fn.bind_obj(action_list, "prev_item"),
		["l"] = fn.bind_obj(action_list, "next_item"),
		["Return"] = function()
			popup.visible = false

			local command = commands[action_list:selected_index()]
			if command.no_confirmation then
				gears.timer.delayed_call(function()
					awful.spawn(command.exec)
				end)
				return
			end

			dialog.show({
				text = string.format("Confirm %s?", command.text),
				icon = command.icon,
				buttons = {
					{ text = "Yes" },
					{ text = "No" },
				},
				button_callback = function(button)
					if button.text == "No" then
						return
					end

					gears.timer.delayed_call(function()
						awful.spawn(command.exec)
					end)
				end,
			})
		end,
	}),
})

return {
	show = function()
		local tasks = {
			sysutil.uptime(),
			sysutil.hostname(),
		}
		Promise.all(table.unpack(tasks)):next(function(values)
			local uptime = values[1]
			local hostname = values[2]
			popup.widget:get_children_by_id("hostname")[1].text = hostname
			popup.widget:get_children_by_id("uptime")[1].text = uptime
			popup.screen = awful.screen.primary
			popup.visible = true
			action_list:select(1)
		end)
	end,
}
