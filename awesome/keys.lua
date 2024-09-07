local api = { awesome = awesome, client = client, screen = screen, mouse = mouse }
local awful = require("awful")
local fn = require("util.fn")
local ez = require("util.ez")
local client = require("util.client")
local keychord = require("util.keychord")
local mouse = require("util.mouse")
local pulseaudio = require("util.pulseaudio")

awful.keyboard.append_global_keybindings(ez.keys({
	-- Awesome
	["M-C-r"] = api.awesome.restart,
	["M-C-q"] = api.awesome.quit,

	-- Navigation
	["M-h"] = fn.bind(awful.client.focus.bydirection, "left"),
	["M-l"] = fn.bind(awful.client.focus.bydirection, "right"),
	["M-j"] = function()
		if awful.layout.get() == awful.layout.suit.max then
			awful.client.focus.byidx(1)
		else
			awful.client.focus.bydirection("down")
		end
	end,
	["M-k"] = function()
		if awful.layout.get() == awful.layout.suit.max then
			awful.client.focus.byidx(-1)
		else
			awful.client.focus.bydirection("up")
		end
	end,
	["M-i"] = function()
		if api.client.focus and api.client.focus.screen ~= api.mouse.screen then
			mouse.move_to_screen(api.client.focus.screen)
		end

		awful.screen.focus_relative(1)
		if api.client.focus and api.client.focus.screen ~= awful.screen.focused() then
			api.client.focus = nil
		end

		mouse.move_to_screen(awful.screen.focused())
	end,
	["M-u"] = function()
		awful.client.urgent.jumpto()
		awful.client.setmaster(api.client.focus)
	end,
	["M-Tab"] = function()
		awful.client.focus.history.previous()
		if api.client.focus then
			api.client.focus:raise()
		end
	end,
	["M-`"] = awful.tag.history.restore,

	-- Window arrangement
	["M-S-h"] = fn.bind(awful.client.swap.bydirection, "left"),
	["M-S-j"] = fn.bind(awful.client.swap.bydirection, "down"),
	["M-S-k"] = fn.bind(awful.client.swap.bydirection, "up"),
	["M-S-l"] = fn.bind(awful.client.swap.bydirection, "right"),
	["M-m"] = fn.bind_client(function(c)
		local main = awful.client.getmaster()
		local tag = c.first_tag

		if c ~= main then
			tag.previous_main = main
			c:swap(main)
		elseif tag.previous_main then
			c:swap(tag.previous_main)
			tag.previous_main = c
		end

		awful.client.getmaster():activate()
	end),

	-- Layouts
	["M-["] = fn.bind(awful.layout.inc, -1),
	["M-]"] = fn.bind(awful.layout.inc, 1),
	["M-f"] = fn.bind_tag(function(tag)
		if tag.previous_layout then
			tag.layout = tag.previous_layout
			tag.previous_layout = nil
		else
			tag.previous_layout = tag.layout
			tag.layout = awful.layout.suit.max
		end

		if api.client.focus then
			api.client.focus:activate()
		end
	end),
	["M-S-f"] = fn.bind_tag(function(tag)
		tag.enable_padding = not tag.enable_padding
	end),
	["M-minus"] = fn.bind(awful.tag.incnmaster, -1),
	["M-S-equal"] = fn.bind(awful.tag.incnmaster, 1),
	["M-equal"] = fn.bind_tag(function(tag)
		tag.master_count = 1
	end),

	-- Clients
	["M-q"] = fn.bind_client(function(c)
		c:kill()
	end),
	["M-S-q"] = fn.bind_tag(function(tag)
		for _, c in ipairs(tag:clients()) do
			c:kill()
		end
	end),
	["M-C-f"] = fn.bind_client(function(c)
		c.floating = not c.floating
	end),
	["M-C-t"] = fn.bind_client(awful.titlebar.toggle),
	["M-C-h"] = fn.bind_client(client.move_left),
	["M-C-j"] = fn.bind_client(client.move_down),
	["M-C-k"] = fn.bind_client(client.move_up),
	["M-C-l"] = fn.bind_client(client.move_right),
	["M-C-c"] = fn.bind_client(client.center),
	["M-S-i"] = fn.bind_client(function(c)
		c:move_to_screen()
	end),

	-- Apps
	["M-Return"] = fn.bind(awful.spawn, "kitty"),
	["M-b"] = fn.bind(awful.spawn, "rofi-brave"),
	["Print"] = fn.bind(awful.spawn, "flameshot gui"),

	-- Rofi
	["M-space"] = fn.bind(awful.spawn, "rofi-default"),
	["M-S-space"] = keychord({
		["p"] = fn.bind(awful.spawn, "rofi-projects"),
		["d"] = fn.bind(awful.spawn, "rofi-dotfiles"),
		["e"] = fn.bind(awful.spawn, "rofimoji"),
	}),

	-- Popups
	["M-BackSpace"] = function()
		require("popups.system").show()
	end,
	["M-n"] = function()
		require("popups.notifications").show()
	end,
	["M-d"] = function()
		require("popups.calendar").show()
	end,

	-- Autorandr
	["M-a"] = keychord({
		["c"] = fn.bind(awful.spawn, "autorandr --cycle"),
		["d"] = fn.bind(awful.spawn, "autorandr --change --load default"),
		["f"] = fn.bind(awful.spawn, "autorandr --load common --ignore-lid"),
	}),

	-- Media
	["XF86AudioPlay"] = fn.bind(awful.spawn, "playerctl play-pause --all-players"),
	["XF86AudioPrev"] = fn.bind(awful.spawn, "playerctl previous --all-players"),
	["XF86AudioNext"] = fn.bind(awful.spawn, "playerctl next --all-players"),
	["XF86AudioRaiseVolume"] = fn.bind_obj(pulseaudio, "set_sink_volume", "+2%"),
	["XF86AudioLowerVolume"] = fn.bind_obj(pulseaudio, "set_sink_volume", "-2%"),
	["XF86AudioMute"] = fn.bind_obj(pulseaudio, "set_sink_mute", "toggle"),
}))

-- Tags
for i = 1, 9 do
	awful.keyboard.append_global_keybindings(ez.keys({
		["M-" .. i] = function()
			local tag = awful.tag.find_by_name(awful.screen.focused(), tostring(i))
			if tag then
				tag:view_only()
			end
		end,
		["M-S-" .. i] = fn.bind_client(function(c)
			local tag = awful.tag.find_by_name(awful.screen.focused(), tostring(i))
			if tag == nil then
				tag = awful.tag.add(tostring(i), {
					screen = awful.screen.focused(),
					layout = awful.layout.suit.tile,
					enable_padding = true,
					volatile = true,
				})
			end

			c:move_to_tag(tag)
			tag:view_only()
		end),
	}))
end
