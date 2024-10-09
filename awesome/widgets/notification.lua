local wibox = require("wibox")
local icons = require("icons")

return function()
	local icon = wibox.widget({
		widget = icons.system.icon,
		name = "notifications",
		size = 16,
	})

	local naughty = require("naughty")
	local function update()
		icon.name = #naughty.active > 0 and "preferences-desktop-notification-bell" or "notification-inactive"
	end

	naughty.connect_signal("added", update)
	naughty.connect_signal("destroyed", update)

	update()
	return icon
end
