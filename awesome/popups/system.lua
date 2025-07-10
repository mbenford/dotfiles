local api = { screen = screen }
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local widgets = require("widgets")
local fn = require("util.fn")
local ez = require("util.ez")
local Popup = require("util.popup")
local sysutil = require("util.system")
local Promise = require("util.promise")

local commands = {
	{ text = "Lock", icon = "", exec = "lock-screen", no_confirmation = true },
	{ text = "Suspend", icon = "󰤄", exec = "systemctl suspend" },
	{ text = "Logout", icon = "󰍃", exec = "loginctl terminate-user $USER" },
	{ text = "Update", icon = "󰚰", exec = "kitty --hold topgrade", no_confirmation = true },
	{ text = "Reboot", icon = "󰜉", exec = "systemctl reboot" },
	{ text = "Shutdown", icon = "", exec = "systemctl poweroff" },
}
local selected = nil

local actions = widgets.list({
	layout = {
		layout = wibox.layout.flex.horizontal,
		spacing = 10,
	},
	cycle = true,
	margins = 10,
	items = commands,
	page_size = #commands,
	item_creator = function(index, value)
		return wibox.widget({
			widget = wibox.container.margin,
			margins = 10,
			forced_width = 100,
			{
				widget = wibox.container.background,
				fg = index == selected and beautiful.system_dialog_action_selected_fg
					or (selected ~= nil and beautiful.system_dialog_action_disabled_fg or beautiful.fg),
				{
					layout = wibox.layout.fixed.vertical,
					spacing = 10,
					fill_space = true,
					{
						widget = wibox.widget.textbox,
						font = "Symbols Nerd Font 48",
						text = value.icon,
						halign = "center",
					},
					{
						widget = wibox.widget.textbox,
						text = index == selected and "Confirm?" or value.text,
						halign = "center",
					},
				},
			},
		})
	end,
})

local hostname = wibox.widget({
	widget = wibox.widget.textbox,
	id = "hostname",
	text = "hostname",
})

local uptime = wibox.widget({
	widget = wibox.widget.textbox,
	id = "uptime",
	text = "uptime",
	halign = "right",
})

local popup = Popup({
	placement = awful.placement.centered,
	ontop = true,
	bg = beautiful.bg_normal .. "F0",
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
					hostname,
					uptime,
				},
			},
			actions,
		},
	},
})
popup:keygrabber({
	timeout = 30,
	stop_key = "",
	keybindings = ez.keys({
		["h"] = function()
			if selected then
				return
			end
			actions:prev_item()
		end,
		["l"] = function()
			if selected then
				return
			end
			actions:next_item()
		end,
		["Return"] = function()
			local index = actions:selected_index()
			local command = commands[index]

			if index == selected or command.no_confirmation then
				selected = nil
				popup:hide()
				awful.spawn(command.exec)
				return
			end

			selected = index
			actions:redraw()
			actions:select(selected)
		end,
		["Escape"] = function()
			if selected == nil then
				popup:hide()
				return
			end

			local last_selected = selected
			selected = nil
			actions:redraw()
			actions:select(last_selected)
		end,
	}),
})
popup:backdrop()

return {
	show = function()
		selected = nil
		actions:redraw()

		local tasks = {
			sysutil.uptime(),
			sysutil.hostname(),
		}
		Promise.all(table.unpack(tasks)):next(function(values)
			uptime.text = values[1]
			hostname.text = values[2]

			popup:show({ screen = api.screen.primary })
			actions:select(1)
		end)
	end,
}
