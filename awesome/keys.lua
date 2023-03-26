local awful = require("awful")
local lazy = require("util.func").lazy
local client_func = require("util.func").client_func
local tag_func = require("util.func").tag_func
local ezkeys = require("util.ez").ezkeys
local floating = require("util.floating")

local api = { awesome = awesome, client = client, screen = screen, mouse = mouse }

local terminal = os.getenv("TERMINAL") or "xterm"
local editor = os.getenv("EDITOR") or "vim"
local browser = os.getenv("BROWSER") or "firefox"

awful.keyboard.append_global_keybindings(ezkeys({
	-- Awesome
	["M-C-r"] = api.awesome.restart,
	["M-C-q"] = api.awesome.quit,

	-- Navigation
	["M-h"] = lazy(awful.client.focus.bydirection, "left"),
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
	["M-l"] = lazy(awful.client.focus.bydirection, "right"),
	["M-i"] = function()
		awful.screen.focus_relative(1)
		local screen = awful.screen.focused()
		api.mouse.coords({
			x = screen.geometry.x + screen.geometry.width / 2,
			y = screen.geometry.y + screen.geometry.height / 2,
		})
	end,
	["M-u"] = function()
		awful.client.urgent.jumpto()
		awful.client.setmaster(api.client.focus)
	end,
	['M-Tab'] = function()
		awful.client.focus.history.previous()
		if api.client.focus then
			api.client.focus:raise()
		end
	end,
	['M-`'] = awful.tag.history.restore,

	-- Window arrangement
	["M-S-h"] = lazy(awful.client.swap.bydirection, "left"),
	["M-S-j"] = lazy(awful.client.swap.bydirection, "down"),
	["M-S-k"] = lazy(awful.client.swap.bydirection, "up"),
	["M-S-l"] = lazy(awful.client.swap.bydirection, "right"),
	["M-m"] = client_func(function(client)
		local main = awful.client.getmaster()
		local tag = client.first_tag

		if client ~= main then
			tag.previous_main = main
			client:swap(main)
		else
			client:swap(tag.previous_main)
			tag.previous_main = client
		end

		awful.client.getmaster():activate()
	end),

	-- Layouts
	["M-["] = lazy(awful.layout.inc, -1),
	["M-]"] = lazy(awful.layout.inc, 1),
	["M-f"] = tag_func(function(tag)
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
	["M-minus"] = lazy(awful.tag.incnmaster, -1),
	["M-S-equal"] = lazy(awful.tag.incnmaster, 1),
	["M-equal"] = tag_func(function(tag)
		tag.master_count = 1
	end),

	-- Clients
	["M-q"] = client_func(function(client)
		client:kill()
	end),
	["M-S-q"] = tag_func(function(tag)
		for _, client in ipairs(tag:clients()) do
			client:kill()
		end
	end),
	["M-S-f"] = client_func(function(client)
		client.floating = not client.floating
	end),
	["M-S-i"] = client_func(function(client)
		client:move_to_screen()
	end),
	["M-n"] = client_func(function(client)
		client.minimized = true
	end),
	["M-C-h"] = client_func(floating.move_left),
	["M-C-j"] = client_func(floating.move_down),
	["M-C-k"] = client_func(floating.move_up),
	["M-C-l"] = client_func(floating.move_right),
	["M-C-c"] = client_func(floating.center),

	-- Apps
	["M-Return"] = lazy(awful.spawn, terminal),
	["M-b"] = lazy(awful.spawn, browser),
	["M-S-b"] = lazy(awful.spawn, browser .. " --incognito"),
	["M-e"] = lazy(awful.spawn, terminal .. " " .. editor),
	["Print"] = lazy(awful.spawn, "flameshot gui"),

	-- Rofi
	["M-space"] = lazy(awful.spawn, "rofi -show drun"),
	["M-S-space"] = lazy(awful.spawn, "rofi -show projects -modes projects,dotfiles -eh 2"),
	["M-BackSpace"] = lazy(awful.spawn, "rofi -show system -modes system"),

	-- Dunst
	["M-o"] = lazy(awful.spawn, "dunstctl close"),
	["M-S-o"] = lazy(awful.spawn, "dunstctl history-pop"),
	["M-C-o"] = lazy(awful.spawn, "dunstctl set-paused toggle"),

	-- Media
	["XF86AudioRaiseVolume"] = lazy(awful.spawn, "pactl set-sink-volume @DEFAULT_SINK@ +10%"),
	["XF86AudioLowerVolume"] = lazy(awful.spawn, "pactl set-sink-volume @DEFAULT_SINK@ -10%"),
	["XF86AudioMute"] = lazy(awful.spawn, "pactl set-sink-mute @DEFAULT_SINK@ toggle"),
	["XF86AudioPlay"] = lazy(awful.spawn, "playerctl play-pause"),
	["XF86AudioPrev"] = lazy(awful.spawn, "playerctl previous"),
	["XF86AudioNext"] = lazy(awful.spawn, "playerctl next"),

	["M-S-n"] = function()
		local client = awful.client.restore()
		if client then
			client:activate({ context = "unminimize", raise = true })
		end
	end,
}))

-- Tags
for i = 1, 4 do
	awful.keyboard.append_global_keybindings(ezkeys({
		["M-" .. i] = function()
			local tag = awful.tag.find_by_name(awful.screen.focused(), tostring(i))
			if tag then
				tag:view_only()
			end
		end,
		["M-S-" .. i] = client_func(function(client)
			local tag = awful.tag.find_by_name(client.screen, tostring(i))
			if tag then
				client:move_to_tag(tag)
				tag:view_only()
			end
		end),
	}))
end

-- Scratchpads
local scratchpad = require("util.scratchpad")
scratchpad.register("terminal", {
	command = terminal .. " --name kitty-scratch",
	rule = { instance = "kitty-scratch" },
	width = 0.5,
	height = 0.8,
})
scratchpad.register("calc", {
	command = "qalculate-gtk --name qalculate-scratch",
	rule = { instance = "qalculate-scratch" },
	width = 600,
	height = 100,
})
scratchpad.register("ticktick", {
	command = "gtk-launch ticktick",
	rule = { instance = "ticktick.com__webapp" },
	width = 1200,
	height = 900,
})
scratchpad.register("whatsapp", {
	command = "gtk-launch whatsapp",
	rule = { instance = "web.whatsapp.com" },
	width = 0.5,
	height = 0.9,
})

awful.keyboard.append_global_keybindings(ezkeys({
	["M-S-Return"] = lazy(scratchpad.toggle, "terminal"),
	["M-c"] = lazy(scratchpad.toggle, "calc"),
	["M-t"] = lazy(scratchpad.toggle, "ticktick"),
	["M-w"] = lazy(scratchpad.toggle, "whatsapp"),
}))
