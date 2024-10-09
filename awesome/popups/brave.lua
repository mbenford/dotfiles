local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local widgets = require("widgets")
local popup_util = require("util.popup")
local string_util = require("util.string")
local fn = require("util.fn")
local ez = require("util.ez")
local async = require("util.async")
local icons = require("icons")

local profiles
local buttons = widgets.list({
	layout = {
		layout = wibox.layout.flex.horizontal,
		spacing = 10,
	},
	cycle = true,
	margins = 10,
	item_creator = function(index, value)
		return wibox.widget({
			widget = wibox.container.margin,
			margins = 10,
			forced_width = 150,
			{
				layout = wibox.layout.fixed.vertical,
				spacing = 10,
				fill_space = true,
				{
					widget = icons.system.icon,
					name = "brave",
					size = 48,
				},
				{
					widget = wibox.widget.textbox,
					text = value.name,
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
				margins = { top = 10 },
				{
					widget = wibox.container.place,
					{
						widget = wibox.widget.textbox,
						text = "Select a profile",
					},
				},
			},
			buttons,
		},
	},
})
popup_util.enhance(popup, {
	timeout = 10,
	keybindings = ez.keys({
		["h"] = fn.bind_obj(buttons, "prev_item"),
		["l"] = fn.bind_obj(buttons, "next_item"),
		["Return"] = function()
			popup.visible = false

			local profile = profiles[buttons:selected_index()]
			awful.spawn(string.format("brave --profile-directory='%s'", profile.id))
		end,
		["S-Return"] = function()
			popup.visible = false

			local profile = profiles[buttons:selected_index()]
			awful.spawn(string.format("brave --profile-directory='%s' --incognito", profile.id))
		end,
	}),
})

return {
	show = function()
		local filename = "$XDG_CONFIG_HOME/BraveSoftware/Brave-Browser/Local State"
		local filter = ".profile.info_cache | to_entries | map({id:.key, name:.value.name})"
		local cmd = string.format('jq -r "%s" "%s"', filter, filename)
		async.spawn(cmd):next(function(result)
			profiles = require("util.json").decode(result.stdout)
			buttons:set_items(profiles)
			popup.screen = awful.screen.focused()
			popup.visible = true
		end)
	end,
}
