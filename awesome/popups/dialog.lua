local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local widgets = require("widgets")
local popup_util = require("util.popup")
local icons = require("icons")
local ez = require("util.ez")
local fn = require("util.fn")

local function show(args)
	args = args or {}
	args.buttons = args.buttons or {
		{ text = "OK" },
		{ text = "Cancel" },
	}
	args.button_selected = args.button_selected or 1
	args.width = args.width or 300
	args.height = args.height or 150
	args.placement = args.placement or awful.placement.centered
	args.margins = args.margins or 10

	local buttons = widgets.list({
		layout = {
			layout = wibox.layout.flex.horizontal,
			spacing = 10,
		},
		item_bg = beautiful.notification_bg_selected,
		item_border_color = beautiful.notification_bg_selected,
		items = args.buttons,
		item_creator = function(index, value)
			return wibox.widget({
				widget = wibox.container.margin,
				margins = 5,
				{
					widget = wibox.widget.textbox,
					text = value.text,
					halign = "center",
				},
			})
		end,
	})
	buttons:select(args.button_selected)

	local popup = awful.popup({
		screen = awful.screen.focused(),
		placement = args.placement,
		ontop = true,
		minimum_width = args.width,
		minimum_height = args.height,
		maximum_width = args.width,
		maximum_height = args.height,
		border_color = beautiful.popup_border_color,
		border_width = beautiful.popup_border_width,
		widget = {
			widget = wibox.container.margin,
			margins = args.margins,
			{
				layout = wibox.layout.align.vertical,
				spacing = 10,
				{
					widget = wibox.widget.textbox,
					text = args.title,
					font = args.font_title,
					halign = "center",
				},
				{
					widget = wibox.container.margin,
					margins = { top = args.title and 10 or 0, bottom = 10 },
					{
						layout = wibox.layout.align.horizontal,
						{
							widget = icons.system.icon,
							name = args.icon,
							size = 48,
						},
						{
							widget = wibox.container.constraint,
							strategy = "min",
							height = 50,
							{
								widget = wibox.container.margin,
								margins = args.icon and { left = 10 },
								{
									widget = wibox.widget.textbox,
									text = args.text,
									font = args.font_text,
									halign = args.icon and "left" or "center",
								},
							},
						},
					},
				},
				{
					widget = wibox.container.constraint,
					height = 50,
					buttons,
				},
			},
		},
	})

	popup_util.enhance(popup, {
		keybindings = ez.keys({
			["h"] = fn.bind_obj(buttons, "prev_item"),
			["l"] = fn.bind_obj(buttons, "next_item"),
			["Return"] = function()
				if args.button_callback then
					args.button_callback({
						index = buttons:selected_index(),
						text = args.buttons[buttons:selected_index()].text,
					})
				end
				popup.visible = false
			end,
		}),
	})
end

return {
	show = show,
}
