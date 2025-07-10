local api = { awesome = awesome, screen = screen, mousegrabber = mousegrabber }
local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local backdrop = require("popups.backdrop")

local Popup = {}
Popup.__index = Popup

local function new(args)
	args = args or {}
	args.visible = false

	return setmetatable({
		_private = {
			timer = nil,
			grabber = nil,
			instance = awful.popup(args),
		},
	}, Popup)
end

function Popup:show(opts)
	opts = opts or {}

	if self._private.timer then
		self._private.timer:again()
	elseif self._private.grabber then
		self._private.grabber:start()
		-- api.mousegrabber.run(function(event)
		-- local any_button_pressed = event.buttons[1] or event.buttons[2] or event.buttons[3]
		-- if any_button_pressed then
		-- 	self:hide()
		-- 	return false
		-- end
		-- return true
		-- end, nil)
	end

	if self._private.backdrop then
		backdrop.show()
	end

	if opts.title and self._private.decorations then
		self._private.decorations:get_children_by_id("title")[1].text = opts.title
	end
	self._private.instance.screen = opts.screen or awful.screen.focused()
	self._private.instance.visible = true
end

function Popup:hide()
	if self._private.timer then
		self._private.timer:stop()
	elseif self._private.grabber then
		self._private.grabber:stop()
		api.mousegrabber.stop()
	end
	self._private.instance.visible = false
end

function Popup:toggle()
	if self._private.instance.visible then
		self:hide()
	else
		self:show()
	end
end

function Popup:timer(opts)
	self._private.timer = gears.timer({
		timeout = opts.timeout,
		callback = function()
			self._private.instance.visible = false
		end,
	})
end

function Popup:keygrabber(opts)
	self._private.grabber = awful.keygrabber({
		stop_key = opts.stop_key or "Escape",
		timeout = opts.timeout,
		keybindings = opts.keybindings,
	})
	self._private.grabber:connect_signal("stopped", function()
		self._private.instance.visible = false
		api.mousegrabber.stop()

		if self._private.backdrop then
			backdrop.hide()
		end
	end)
end

function Popup:decorations(opts)
	opts = opts or {}
	local title = opts.title or {}
	self._private.decorations = wibox.widget({
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
	})
	self._private.instance.widget = wibox.widget({
		layout = wibox.layout.fixed.vertical,
		fill_space = true,
		self._private.decorations,
		self._private.instance.widget,
	})
end

function Popup:xprops(props)
	for k, v in pairs(props) do
		api.awesome.register_xproperty("awesomewm_popup_" .. k, "string")
		self._private.instance:set_xproperty("awesomewm_popup_" .. k, v)
	end
end

function Popup:backdrop()
	self._private.backdrop = true
end

return new
