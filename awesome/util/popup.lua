local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")

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

local function with_decorations(popup, decorations)
	if decorations.title then
		local title = decorations.title
		popup.widget = wibox.widget({
			layout = wibox.layout.fixed.vertical,
			fill_space = true,
			{
				widget = wibox.container.background,
				fg = beautiful.popup_title_fg,
				bg = beautiful.popup_title_bg,
				{
					widget = wibox.container.margin,
					margins = beautiful.popup_title_margin or 3,
					{
						widget = wibox.widget.textbox,
						id = "title",
						text = title.text,
						font = beautiful.popup_title_font,
						valign = "center",
						halign = title.halign or "center",
					},
				},
			},
			popup.widget,
		})
	end

	return popup
end

return {
	enhance = function(popup, opts)
		if opts.keybindings then
			popup = with_keygrabber(popup, opts.timeout, opts.keybindings)
		elseif opts.timeout then
			popup = with_timeout(popup, opts.timeout)
		end

		if opts.decorations then
			popup = with_decorations(popup, opts.decorations)
		end

		return popup
	end,
}
