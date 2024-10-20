local lgi = require("lgi")
local wibox = require("wibox")
local gears = require("gears")
local icons = require("icons")

local client = lgi.NM.Client.new()

return {
	wifi = function(interface)
		local icon = wibox.widget({
			widget = icons.system.icon,
			size = 16,
		})

		local device = client:get_device_by_iface(interface)
		if device == nil then
			return icon
		end

		local function update()
			if device:get_state() == "DEACTIVATING" or device:get_state() == "DISCONNECTED" then
				icon.name = "network-wireless-offline"
				return
			end

			if device:get_state() ~= "ACTIVATED" then
				icon.name = "network-wireless-acquiring"
				return
			end

			local ap = device:get_active_access_point()
			if ap == nil then
				icon.name = "network-wireless-offline"
				return
			end

			local signal = ap:get_strength()
			if signal == 0 then
				icon.name = "network-wireless-offline"
				return
			end

			if signal >= 80 then
				icon.name = "network-wireless-signal-excellent"
			elseif signal >= 70 then
				icon.name = "network-wireless-signal-good"
			elseif signal >= 60 then
				icon.name = "network-wireless-signal-ok"
			elseif signal >= 50 then
				icon.name = "network-wireless-signal-low"
			else
				icon.name = "network-wireless-signal-none"
			end
		end

		function device:on_state_changed()
			update()
		end

		gears.timer({
			timeout = 5,
			autostart = true,
			call_now = true,
			callback = update,
		})
		return icon
	end,

	vpn = function(interface)
		local icon = wibox.widget({
			widget = icons.material.icon,
			name = "vpn_key_alert",
			fill = true,
			size = 20,
			fg = "#ff0000",
		})

		local device = client:get_device_by_iface(interface)
		if device == nil then
			return icon
		end

		local function update()
			local state = device:get_state()
			if state == "UNMANAGED" or state == "UNAVAILABLE" or state == "DISCONNECTED" then
				icon.name = "vpn_key_off"
				icon.fg = "#61636f"
				return
			end

			if state == "ACTIVATED" then
				icon.name = "vpn_key"
				icon.fg = "#dfdfdf"
				return
			end
		end

		function device:on_state_changed()
			update()
		end

		update()
		return icon
	end,
}