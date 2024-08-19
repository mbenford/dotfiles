local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local gears = require("gears")
local list = require("widgets.list")
local fn = require("util.fn")
local ez = require("util.ez")
local popup_util = require("util.popup")
local dialog = require("popups.dialog")
local icons = require("util.icons")

local commands = {
	{ text = "Suspend", icon = "system-suspend", exec = "systemctl suspend" },
	{ text = "Lock", icon = "system-lock-screen", exec = "lock", no_confirmation = true },
	{ text = "Logout", icon = "system-log-out", exec = "loginctl terminate-user $USER" },
	{ text = "Reboot", icon = "system-reboot", exec = "systemctl reboot" },
	{ text = "Shutdown", icon = "system-shutdown", exec = "systemctl poweroff" },
}

return {
	show = function()
		local actions = list({
			layout = "horizontal",
			cycle = true,
			margins = 10,
			items = commands,
			item_bg = beautiful.notification_bg,
			item_bg_selected = beautiful.notification_bg_selected,
			item_creator = function(index, value)
				return wibox.widget({
					widget = wibox.container.margin,
					margins = 10,
					forced_width = 100,
					{
						layout = wibox.layout.fixed.vertical,
						fill_space = true,
						{
							widget = wibox.widget.imagebox,
							resize = true,
							halign = "center",
							forced_width = 64,
							forced_height = 64,
							image = icons.lookup_filename(value.icon, 24),
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
			screen = awful.screen.focused(),
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
						margins = 10,
						{
							widget = wibox.widget.textbox,
							text = "Uptime",
							halign = "center",
							valign = "center",
						},
					},
					actions,
				},
			},
		})
		popup_util.enhance(popup, {
			timeout = 5,
			keybindings = ez.keys({
				["h"] = fn.bind_obj(actions, "prev_item"),
				["l"] = fn.bind_obj(actions, "next_item"),
				["Return"] = function()
					popup.visible = false

					local command = commands[actions:selected()]
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
	end,
}
