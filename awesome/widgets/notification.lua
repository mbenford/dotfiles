local wibox = require("wibox")
local icons = require("icons")

return function()
	local icon = wibox.widget({
		widget = icons.material.icon,
		name = "notifications",
		fg = "#ffffff",
		fill = true,
		size = 20,
	})

	local naughty = require("naughty")
	local function update()
		icon.name = #naughty.active > 0 and "notifications_unread" or "notifications"
	end

	naughty.connect_signal("added", update)
	naughty.connect_signal("destroyed", update)

	update()
	return icon
end
