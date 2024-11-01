local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local widgets = require("widgets")
local fn = require("util.fn")
local ez = require("util.ez")
local popup_util = require("util.popup")
local pulseaudio = require("util.pulseaudio")
local icons = require("icons")

local devices

local device_list = widgets.list({
	layout = {
		layout = wibox.layout.flex.vertical,
		max_widget_size = 92,
		spacing = 10,
	},
	page_size = 10,
	item_creator = function(_, item)
		local icon = item.icon
		if icon:find("card") then
			icon = "audio-card"
		elseif icon:find("headset") then
			icon = "audio-headset-symbolic"
		elseif icon:find("headphones") then
			icon = "audio-headphones"
		elseif icon:find("speakers") then
			icon = "audio-speakers"
		elseif icon:find("camera") then
			icon = "camera-web"
		else
			icon = "audio-speakers"
		end

		return wibox.widget({
			widget = wibox.container.margin,
			margins = 10,
			{
				layout = wibox.layout.fixed.vertical,
				{
					widget = wibox.container.margin,
					margins = { top = 5, bottom = 5 },
					{
						layout = wibox.layout.fixed.horizontal,
						fill_space = true,
						{
							widget = wibox.container.margin,
							margins = { right = 5 },
							{
								widget = icons.system.icon,
								name = icon,
								size = 22,
							},
						},
						{
							widget = wibox.widget.textbox,
							text = item.description,
						},
						{
							widget = wibox.container.place,
							halign = "right",
							{
								id = "default",
								visible = item.is_default,
								widget = icons.system.icon,
								name = "checkmark",
								size = 22,
							},
						},
					},
				},
				{
					layout = wibox.layout.stack,
					forced_height = 20,
					{
						id = "progress",
						widget = wibox.widget.progressbar,
						value = item.mute and 0 or item.volume,
						max_value = 100,
						color = beautiful.popup_volume_progress_fg,
						background_color = beautiful.popup_volume_progress_bg,
					},
					{
						id = "text",
						widget = wibox.widget.textbox,
						text = item.mute and "MUTE" or item.volume .. "%",
						valign = "center",
						halign = "center",
					},
				},
			},
		})
	end,
})
local popup = awful.popup({
	type = "dock",
	visible = false,
	placement = function(c)
		awful.placement.top_right(c, { honor_workarea = true })
	end,
	ontop = true,
	border_color = beautiful.popup_border_color,
	border_width = beautiful.popup_border_width,
	widget = {
		widget = wibox.container.margin,
		margins = 10,
		{
			widget = wibox.container.constraint,
			strategy = "exact",
			width = 400,
			device_list,
		},
	},
})

local function update_device_volume(volume)
	local item = device_list:selected_item()
	local text = item.widget:get_children_by_id("text")[1]
	local progress = item.widget:get_children_by_id("progress")[1]
	text.text = volume > 0 and volume .. "%" or "MUTE"
	progress.value = volume
end

popup_util.enhance(popup, {
	xprops = {
		position = "right",
	},
	decorations = {
		title = {},
	},
	timeout = 10,
	keybindings = ez.keys({
		["j"] = fn.bind_obj(device_list, "next_item"),
		["k"] = fn.bind_obj(device_list, "prev_item"),
		["h"] = function()
			local device = devices[device_list:selected_index()]
			pulseaudio:set_volume(device.type, device.name, "-2%"):next(update_device_volume)
		end,
		["l"] = function()
			local device = devices[device_list:selected_index()]
			pulseaudio:set_volume(device.type, device.name, "+2%"):next(update_device_volume)
		end,
		["m"] = function()
			local device = devices[device_list:selected_index()]
			pulseaudio:set_mute(device.type, device.name, "toggle"):next(update_device_volume)
		end,
		["Return"] = function()
			local index = device_list:selected_index()
			local device = devices[index]
			if device.is_default then
				return
			end

			pulseaudio:set_default(device.type, device.name):next(function()
				for i in ipairs(devices) do
					devices[i].is_default = devices[i].name == device.name
				end
				device_list:set_items(devices)
				device_list:select(index)
			end)
		end,
	}),
})

local function show(type, title)
	pulseaudio:list(type):next(function(items)
		devices = items
		device_list:set_items(devices)
		popup.widget:get_children_by_id("title")[1].text = title
		popup.screen = awful.screen.primary
		popup.visible = true
	end)
end

return {
	show_outputs = fn.bind(show, "sink", "Output Devices"),
	show_inputs = fn.bind(show, "source", "Input Devices"),
}
