local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local popup_util = require("util.popup")
local pulseaudio = require("util.pulseaudio")
local icons = require("util.icons")

local popup = popup_util.enhance(
	awful.popup({
		visible = false,
		screen = awful.screen.focused(),
		placement = function(c)
			awful.placement.top(c, { honor_workarea = true })
		end,
		ontop = true,
		border_color = beautiful.popup_border_color,
		border_width = beautiful.popup_border_width,
		widget = {
			widget = wibox.container.margin,
			margins = 10,
			forced_width = 300,
			forced_height = 50,
			{
				layout = wibox.layout.fixed.horizontal,
				{
					id = "icon",
					widget = wibox.widget.imagebox,
					image = icons.lookup_filename("audio-volume-high", 24),
				},
				{
					layout = wibox.layout.stack,
					{
						id = "progress",
						widget = wibox.widget.progressbar,
						max_value = 100,
						margins = { left = 5 },
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
	}),
	{ timeout = 1 }
)

local function show(volume)
	local text = popup.widget:get_children_by_id("text")[1]
	local progress = popup.widget:get_children_by_id("progress")[1]

	text.text = volume > 0 and volume .. "%" or "MUTE"
	progress.value = volume

	if popup.visible then
		popup.timer:again()
	else
		popup.visible = true
	end
end

pulseaudio:connect_signal("sink::volume", function(_, volume)
	show(volume)
end)

pulseaudio:connect_signal("sink::mute", function()
	show(0)
end)
