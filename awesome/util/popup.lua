local awful = require("awful")
local gears = require("gears")

local function with_timeout(popup, timeout)
	popup.timer = gears.timer({
		timeout = timeout,
		callback = function()
			popup.visible = false
		end,
	})

	popup:connect_signal("property::visible", function()
		if popup.visible then
			popup.timer:again()
		else
			popup.timer:stop()
		end
	end)

	if popup.visible then
		popup.timer:start()
	end

	return popup
end

local function with_keygrabber(popup, timeout, keybindings)
	popup.grabber = awful.keygrabber({
		stop_key = "Escape",
		timeout = timeout,
		keybindings = keybindings,
	})
	popup.grabber:connect_signal("stopped", function()
		popup.visible = false
	end)

	popup:connect_signal("property::visible", function()
		if popup.visible then
			popup.grabber:start()
		else
			popup.grabber:stop()
		end
	end)

	if popup.visible then
		popup.grabber:start()
	end

	return popup
end

return {
	enhance = function(popup, opts)
		if opts.keybindings then
			return with_keygrabber(popup, opts.timeout, opts.keybindings)
		end

		if opts.timeout then
			return with_timeout(popup, opts.timeout)
		end

		return popup
	end,
}
