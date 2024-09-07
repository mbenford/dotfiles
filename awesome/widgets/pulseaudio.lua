local wibox = require("wibox")
local beautiful = require("beautiful")
local icons = require("icons")
local pulseaudio = require("util.pulseaudio")
local util = require("widgets.util")

return {
	sink = function()
		local content = wibox.widget.textbox()
		content.font = beautiful.widget_font

		pulseaudio:connect_signal("sink::volume", function(_, volume)
			content.markup = string.format("%02d%%", volume)
		end)
		pulseaudio:connect_signal("sink::mute", function()
			content.markup = "MUTE"
		end)

		local widget = wibox.widget({
			{
				content,
				widget = wibox.container.margin,
			},
			widget = wibox.container.background,
		})

		return util.label("VOL", widget)
	end,

	sink_icon = function()
		local icon = wibox.widget({
			widget = icons.material.icon,
			fg = "#ffffff",
			fill = true,
			size = 22,
		})

		local states = {
			on = "volume_up",
			off = "no_sound",
		}

		pulseaudio:connect_signal("sink::volume", function(_, volume)
			icon.name = volume > 0 and states.on or states.off
		end)

		pulseaudio:get_sink_mute():next(function(mute)
			icon.name = mute and states.off or states.on
		end)

		return icon
	end,

	source = function()
		local content = wibox.widget.textbox()
		content.font = beautiful.widget_font

		pulseaudio.connect_signal("source::volume", function(volume)
			content.markup = string.format("%02d%%", volume)
		end)
		pulseaudio.connect_signal("source::mute", function()
			content.markup = "MUTE"
		end)
		pulseaudio:refresh_source_volume()

		local widget = wibox.widget({
			{
				content,
				widget = wibox.container.margin,
			},
			widget = wibox.container.background,
		})

		return util.label("MIC", widget)
	end,
}
