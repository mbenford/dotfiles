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

			local quality = require("util.network").signal_to_grade(ap:get_strength())
			if quality == 5 then
				icon.name = "network-wireless-signal-excellent"
			elseif quality == 4 then
				icon.name = "network-wireless-signal-good"
			elseif quality == 3 then
				icon.name = "network-wireless-signal-ok"
			elseif quality == 2 then
				icon.name = "network-wireless-signal-low"
			elseif quality == 1 then
				icon.name = "network-wireless-signal-none"
			else
				icon.name = "network-wireless-offline"
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

	vpn = function(conn_type)
		local icon = wibox.widget({
			widget = icons.system.icon,
			name = "nm-vpn-standalone-lock",
			size = 16,
			visible = false,
		})

		local function update(conn, visible)
			if conn:get_connection_type() ~= conn_type then
				return
			end
			icon.visible = visible
		end

		function client:on_connection_added(conn)
			update(conn, true)
		end
		function client:on_connection_removed(conn)
			update(conn, false)
		end

		for _, conn in pairs(client:get_active_connections()) do
			update(conn, true)
		end

		return icon
	end,
}
