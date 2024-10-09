local wibox = require("wibox")
local beautiful = require("beautiful")
local icons = require("icons")
local pulseaudio = require("util.pulseaudio")
local util = require("widgets.util")

return {
	sink = function()
		local content = wibox.widget.textbox()
		content.font = beautiful.widget_font

		pulseaudio:connect_signal("sink::volume", function(_, name, volume)
			content.markup = string.format("%02d%%", volume)
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
			widget = icons.system.icon,
			size = 16,
		})

		local states = {
			on = "audio-ready",
			off = "audio-off",
		}

		pulseaudio:connect_signal("sink::volume", function(_, name, volume)
			if name == "@DEFAULT_SINK@" then
				icon.name = volume > 0 and states.on or states.off
			end
		end)

		pulseaudio:get_sink_mute("@DEFAULT_SINK@"):next(function(mute)
			icon.name = mute and states.off or states.on
		end)

		return icon
	end,

	source = function()
		local content = wibox.widget.textbox()
		content.font = beautiful.widget_font

		pulseaudio:connect_signal("source::volume", function(_, name, volume)
			content.markup = string.format("%02d%%", volume)
		end)

		local widget = wibox.widget({
			{
				content,
				widget = wibox.container.margin,
			},
			widget = wibox.container.background,
		})

		return util.label("MIC", widget)
	end,

	source_icon = function()
		local icon = wibox.widget({
			widget = icons.system.icon,
			size = 16,
		})

		local states = {
			on = "mic-ready",
			off = "mic-off",
		}

		pulseaudio:connect_signal("source::volume", function(_, name, volume)
			if name == "@DEFAULT_SOURCE@" then
				icon.name = volume > 0 and states.on or states.off
			end
		end)

		pulseaudio:get_source_mute("@DEFAULT_SOURCE@"):next(function(mute)
			icon.name = mute and states.off or states.on
		end)

		return icon
	end,
}
