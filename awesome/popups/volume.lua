local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local Popup = require("util.popup")
local icons = require("icons")

local widget = wibox.widget({
	widget = wibox.container.margin,
	margins = 10,
	forced_width = 300,
	forced_height = 110,
	{
		layout = wibox.layout.fixed.vertical,
		spacing = 10,
		{
			id = "icon",
			widget = icons.system.icon,
			size = 48,
		},
		{
			layout = wibox.layout.stack,
			{
				id = "progress",
				widget = wibox.widget.progressbar,
				max_value = 100,
				color = beautiful.popup_volume_progress_fg,
				background_color = beautiful.popup_volume_progress_bg,
				shape = beautiful.popup_volume_progress_shape,
			},
			{
				id = "text",
				widget = wibox.widget.textbox,
				valign = "center",
				halign = "center",
			},
		},
	},
})

local popup = Popup({
	placement = awful.placement.centered,
	ontop = true,
	border_color = beautiful.popup_border_color,
	border_width = beautiful.popup_border_width,
	widget = widget,
})
popup:timer({ timeout = 0.5 })

return {
	show = function(type, volume)
		local icon = widget:get_children_by_id("icon")[1]
		local text = widget:get_children_by_id("text")[1]
		local progress = widget:get_children_by_id("progress")[1]

		if type == "sink" then
			icon.name = volume > 0 and "audio-ready" or "audio-off"
		elseif type == "source" then
			icon.name = volume > 0 and "mic-ready" or "mic-off"
		end
		text.text = volume > 0 and volume .. "%" or "MUTE"
		progress.value = volume

		popup:show({ screen = screen.primary })
	end,
}
