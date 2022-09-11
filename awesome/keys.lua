local awful = require("awful")
local lazy = require("util.func").lazy
local ezkeys = require("util.ez").ezkeys

local capi = { awesome = awesome, client = client, mouse = mouse }

local terminal = os.getenv("TERMINAL") or "xterm"
local editor = os.getenv("EDITOR") or "vim"
local browser = os.getenv("BROWSER") or "firefox"

-- Global keybindings
awful.keyboard.append_global_keybindings(ezkeys({
	-- Awesome
	["M-C-r"] = capi.awesome.restart,
	["M-S-q"] = capi.awesome.quit,

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
		capi.mouse.coords({
			x = screen.geometry.x + screen.geometry.width / 2,
			y = screen.geometry.y + screen.geometry.height / 2,
		})
	end,
	["M-u"] = awful.client.urgent.jumpto,

	-- Window arrangement
	["M-S-h"] = lazy(awful.client.swap.bydirection, "left"),
	["M-S-j"] = lazy(awful.client.swap.bydirection, "down"),
	["M-S-k"] = lazy(awful.client.swap.bydirection, "up"),
	["M-S-l"] = lazy(awful.client.swap.bydirection, "right"),

	-- Layouts
	["M-["] = lazy(awful.layout.inc, -1),
	["M-]"] = lazy(awful.layout.inc, 1),
	["M-m"] = function()
		awful.layout.set(
			awful.layout.get() == awful.layout.suit.max and awful.layout.suit.tile or awful.layout.suit.max
		)
		if capi.client.focus then
			capi.client.focus:activate()
		end
	end,

	-- Apps
	["M-Return"] = lazy(awful.spawn, terminal),
	["M-b"] = lazy(awful.spawn, browser),
	["M-S-b"] = lazy(awful.spawn, browser .. " --incognito"),
	["M-e"] = lazy(awful.spawn, terminal .. " " .. editor),
	["Print"] = lazy(awful.spawn, "flameshot gui"),

	-- Rofi
	["M-space"] = lazy(awful.spawn, "rofi -show drun"),
	["M-S-space"] = lazy(awful.spawn, "rofi -show projects -modes projects,dotfiles -eh 2"),

	-- Media
	["XF86AudioRaiseVolume"] = lazy(awful.spawn, "pactl set-sink-volume @DEFAULT_SINK@ +10%"),
	["XF86AudioLowerVolume"] = lazy(awful.spawn, "pactl set-sink-volume @DEFAULT_SINK@ -10%"),
	["XF86AudioMute"] = lazy(awful.spawn, "pactl set-sink-mute @DEFAULT_SINK@ toggle"),
	["XF86AudioPlay"] = lazy(awful.spawn, "playerctl play-pause"),
	["XF86AudioPrev"] = lazy(awful.spawn, "playerctl previous"),
	["XF86AudioNext"] = lazy(awful.spawn, "playerctl next"),
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
		["M-S-" .. i] = function()
			local client = capi.client.focus
			if client then
				local tag = awful.tag.find_by_name(client.screen, tostring(i))
				if tag then
					client:move_to_tag(tag)
					tag:view_only()
				end
			end
		end,
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
scratchpad.register("spotify", {
	command = "gtk-launch spotify",
	rule = { instance = "open.spotify.com" },
	width = 1200,
	height = 900,
})
scratchpad.register("ticktick", {
	command = "gtk-launch ticktick",
	rule = { instance = "ticktick.com__webapp" },
	width = 1200,
	height = 900,
})

awful.keyboard.append_global_keybindings(ezkeys({
	["M-S-Return"] = lazy(scratchpad.toggle, "terminal"),
	["M-c"] = lazy(scratchpad.toggle, "calc"),
	["M-s"] = lazy(scratchpad.toggle, "spotify"),
	["M-t"] = lazy(scratchpad.toggle, "ticktick"),
}))

-- Client keybindings
awful.keyboard.append_client_keybindings(ezkeys({
	["M-q"] = function(client)
		client:kill()
	end,
	["M-f"] = function(client)
		client.floating = not client.floating
	end,
	["M-C-Return"] = function(client)
		client:swap(awful.client.getmaster())
	end,
	["M-S-i"] = function(client)
		client:move_to_screen()
	end,
	["M-S-m"] = function(client)
		client.maximized = not client.maximized
	end,
	["M-n"] = function(client)
		client.minimized = true
	end,
	["M-S-n"] = function()
		local client = awful.client.restore()
		if client then
			client:activate({ context = "unminimize", raise = true })
		end
	end,
}))
