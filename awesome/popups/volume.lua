local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local popup_util = require("util.popup")
local pulseaudio = require("util.pulseaudio")
local icons = require("icons")

local popup = awful.popup({
	visible = false,
	placement = awful.placement.centered,
	ontop = true,
	border_color = beautiful.popup_border_color,
	border_width = beautiful.popup_border_width,
	widget = {
		widget = wibox.container.margin,
		margins = 10,
		forced_width = 300,
		forced_height = 130,
		{
			layout = wibox.layout.fixed.vertical,
			spacing = 10,
			{
				id = "icon",
				widget = icons.material.icon,
				name = "no_sound",
				size = 70,
				fill = true,
				fg = "#ffffff",
			},
			{
				layout = wibox.layout.stack,
				{
					id = "progress",
					widget = wibox.widget.progressbar,
					max_value = 100,
					color = beautiful.popup_volume_progress_fg,
					background_color = beautiful.popup_volume_progress_bg,
				},
				{
					id = "text",
					widget = wibox.widget.textbox,
					valign = "center",
					halign = "center",
				},
			},
		},
	},
})
popup_util.enhance(popup, { timeout = 1 })

local function show(volume)
	local icon = popup.widget:get_children_by_id("icon")[1]
	local text = popup.widget:get_children_by_id("text")[1]
	local progress = popup.widget:get_children_by_id("progress")[1]

	icon.name = volume > 0 and "volume_up" or "no_sound"
	text.text = volume > 0 and volume .. "%" or "MUTE"
	progress.value = volume

	if popup.visible then
		popup.timer:again()
	else
		popup.screen = awful.screen.focused()
		popup.visible = true
	end
end

pulseaudio:connect_signal("sink::volume", function(_, volume)
	show(volume)
end)
