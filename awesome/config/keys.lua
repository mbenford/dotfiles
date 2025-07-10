local api = { awesome = awesome, client = client, screen = screen, mouse = mouse }
local awful = require("awful")
local fn = require("util.fn")
local ez = require("util.ez")
local client = require("util.client")
local tag = require("util.tag")
local keychord = require("util.keychord")
local mouse = require("util.mouse")
local pulseaudio = require("util.pulseaudio")

awful.keyboard.append_global_keybindings(ez.keys({
	-- Tags
	["M-1"] = tag.view("P1"),
	["M-2"] = tag.view("P2"),
	["M-3"] = tag.view("P3"),
	["M-8"] = tag.view("S1"),
	["M-9"] = tag.view("S2"),
	["M-0"] = tag.view("S3"),

	["M-S-1"] = client.move_to_tag("P1"),
	["M-S-2"] = client.move_to_tag("P2"),
	["M-S-3"] = client.move_to_tag("P3"),
	["M-S-8"] = client.move_to_tag("S1"),
	["M-S-9"] = client.move_to_tag("S2"),
	["M-S-0"] = client.move_to_tag("S3"),

	-- Navigation
	["M-h"] = fn.bind(awful.client.focus.bydirection, "left"),
	["M-j"] = fn.bind(awful.client.focus.bydirection, "down"),
	["M-k"] = fn.bind(awful.client.focus.bydirection, "up"),
	["M-l"] = fn.bind(awful.client.focus.bydirection, "right"),
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
		awful.client.urgent:swap(awful.client.getmaster())
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
	["M-m"] = client.bind(function(c)
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
	["M-f"] = tag.bind(function(tag, c)
		if c.floating or #tag:clients() < 2 then
			return
		end

		if tag.previous_layout then
			tag.layout = tag.previous_layout
			tag.previous_layout = nil
		else
			tag.previous_layout = tag.layout
			tag.layout = awful.layout.suit.max
		end
	end),
	["M-S-f"] = tag.bind(function(tag)
		tag.enable_padding = not tag.enable_padding
	end),
	["M-minus"] = fn.bind(awful.tag.incnmaster, -1),
	["M-S-equal"] = fn.bind(awful.tag.incnmaster, 1),
	["M-equal"] = tag.bind(function(tag)
		tag.master_count = 1
	end),

	-- Clients
	["M-q"] = client.bind(function(c)
		c:kill()
	end),
	["M-S-q"] = tag.bind(function(tag)
		for _, c in ipairs(tag:clients()) do
			c:kill()
		end
	end),
	["M-C-f"] = client.bind(function(c)
		c.floating = not c.floating
	end),
	["M-C-t"] = client.bind(awful.titlebar.toggle),
	["M-C-h"] = client.bind(client.move_left),
	["M-C-j"] = client.bind(client.move_down),
	["M-C-k"] = client.bind(client.move_up),
	["M-C-l"] = client.bind(client.move_right),
	["M-C-c"] = client.bind(client.center),
	["M-S-i"] = client.bind(function(c)
		awful.client.movetoscreen()
		c:swap(awful.client.getmaster())
	end),

	-- Apps
	["M-Return"] = fn.bind(awful.spawn, "kitty"),
	["Print"] = fn.bind(awful.spawn, "flameshot gui"),

	-- Rofi
	["M-space"] = fn.bind(awful.spawn, "rofi-default"),
	["M-S-space"] = keychord({
		["p"] = fn.bind(awful.spawn, "rofi-projects"),
		["d"] = fn.bind(awful.spawn, "rofi-dotfiles"),
		["e"] = fn.bind(awful.spawn, "rofimoji"),
		["w"] = fn.bind(awful.spawn, "rofi-windows"),
	}),

	-- Popups
	["M-BackSpace"] = require("popups.system").show,
	["M-n"] = require("popups.notifications").show,
	["M-d"] = require("popups.calendar").show,
	["M-b"] = require("popups.brave").show,
	["M-a"] = keychord({
		["o"] = require("popups.audio").show_outputs,
		["i"] = require("popups.audio").show_inputs,
	}),

	-- Autorandr
	["M-v"] = keychord({
		["c"] = fn.bind(awful.spawn, "autorandr --cycle"),
		["d"] = fn.bind(awful.spawn, "autorandr --change --load default"),
		["f"] = fn.bind(awful.spawn, "autorandr --load common --ignore-lid"),
	}),

	-- Media
	["XF86AudioPlay"] = fn.bind(awful.spawn, "playerctl play-pause --all-players"),
	["XF86AudioPrev"] = fn.bind(awful.spawn, "playerctl previous --all-players"),
	["XF86AudioNext"] = fn.bind(awful.spawn, "playerctl next --all-players"),

	-- Audio
	["XF86AudioRaiseVolume"] = fn.bind_obj(pulseaudio, "set_volume", { type = "sink", value = "+2%" }),
	["XF86AudioLowerVolume"] = fn.bind_obj(pulseaudio, "set_volume", { type = "sink", value = "-2%" }),
	["XF86AudioMute"] = fn.bind_obj(pulseaudio, "set_mute", { type = "sink", value = "toggle" }),
	["C-XF86AudioRaiseVolume"] = fn.bind_obj(pulseaudio, "set_volume", { type = "source", value = "+2%" }),
	["C-XF86AudioLowerVolume"] = fn.bind_obj(pulseaudio, "set_volume", { type = "source", value = "-2%" }),
	["C-XF86AudioMute"] = fn.bind_obj(pulseaudio, "set_mute", { type = "source", value = "toggle" }),
}))
