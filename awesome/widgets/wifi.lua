local wibox = require("wibox")
local vicious = require("vicious")
local icons = require("icons")

return function(interface)
	local icon = wibox.widget({
		widget = icons.material.icon,
		name = "wifi_not_connected",
		fill = true,
		size = 20,
		fg = "#ffffff",
	})

	vicious.register(icon, vicious.widgets.wifiiw, function(_, args)
		local signal = args["{sign}"]
		if signal == 0 then
			return
		end

		if signal >= -50 then
			icon.name = "signal_wifi_4_bar"
		elseif signal >= -67 then
			icon.name = "network_wifi_3_bar"
		elseif signal >= -70 then
			icon.name = "network_wifi_2_bar"
		elseif signal >= -80 then
			icon.name = "network_wifi_1_bar"
		else
			icon.name = "signal_wifi_0_bar"
		end
	end, 11, interface)

	return icon
end
