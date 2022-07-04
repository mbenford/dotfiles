local awful = require("awful")
local lazy = require("util").lazy
local constants = require("constants")

local modkey = constants.modkey
local terminal = os.getenv("TERMINAL")
local editor = os.getenv("EDITOR")
local browser = os.getenv("BROWSER")

-- Global keybindings
awful.keyboard.append_global_keybindings({
	awful.key(
		{ modkey },
		"s",
		require("awful.hotkeys_popup").show_help,
		{ description = "show help", group = "awesome" }
	),

	-- Navigation
	awful.key(
		{ modkey },
		"h",
		lazy(awful.client.focus.bydirection, "left"),
		{ description = "focus left", group = "client" }
	),
	awful.key({ modkey }, "j", function()
		if awful.layout.get() == awful.layout.suit.max then
			awful.client.focus.byidx(1)
		else
			awful.client.focus.bydirection("down")
		end
	end, { description = "focus down", group = "client" }),
	awful.key({ modkey }, "k", function()
		if awful.layout.get() == awful.layout.suit.max then
			awful.client.focus.byidx(-1)
		else
			awful.client.focus.bydirection("up")
		end
	end, { description = "focus up", group = "client" }),
	awful.key(
		{ modkey },
		"l",
		lazy(awful.client.focus.bydirection, "right"),
		{ description = "focus right", group = "client" }
	),

	-- Layout manipulation
	awful.key(
		{ modkey, "Shift" },
		"h",
		lazy(awful.client.swap.bydirection, "left"),
		{ description = "swap with client left", group = "client" }
	),
	awful.key(
		{ modkey, "Shift" },
		"j",
		lazy(awful.client.swap.bydirection, "down"),
		{ description = "swap with client down", group = "client" }
	),
	awful.key(
		{ modkey, "Shift" },
		"k",
		lazy(awful.client.swap.bydirection, "up"),
		{ description = "swap with client up", group = "client" }
	),
	awful.key(
		{ modkey, "Shift" },
		"l",
		lazy(awful.client.swap.bydirection, "right"),
		{ description = "swap with client right", group = "client" }
	),
	awful.key(
		{ modkey },
		"i",
		lazy(awful.screen.focus_relative, 1),
		{ description = "focus next screen", group = "screen" }
	),
	awful.key({ modkey }, "u", awful.client.urgent.jumpto, { description = "jump to urgent client", group = "client" }),

	-- Layouts
	awful.key({ modkey }, "]", lazy(awful.layout.inc, 1), { description = "select next", group = "layout" }),
	awful.key({ modkey }, "[", lazy(awful.layout.inc, -1), { description = "select previous", group = "layout" }),
	awful.key({ modkey }, "m", function()
		awful.layout.set(
			awful.layout.get() == awful.layout.suit.max and awful.layout.suit.tile or awful.layout.suit.max
		)
		if client.focus then
			client.focus:activate()
		end
	end, { description = "toggle max layout", group = "layout" }),

	-- Standard apps
	awful.key(
		{ modkey },
		"Return",
		lazy(awful.spawn, terminal),
		{ description = "open a terminal", group = "launcher" }
	),
	awful.key(
		{ modkey },
		"b",
		lazy(awful.spawn, browser),
		{ description = "open a browser window", group = "launcher" }
	),
	awful.key(
		{ modkey, "Shift" },
		"b",
		lazy(awful.spawn, browser .. " --incognito"),
		{ description = "open an anonymous browser window", group = "launcher" }
	),
	awful.key({ modkey }, "e", lazy(awful.spawn, editor), { description = "open default editor", group = "launcher" }),

	-- Rofi
	awful.key(
		{ modkey },
		"space",
		lazy(awful.spawn, "rofi -show drun"),
		{ description = "rofi (drun)", group = "launcher" }
	),

	-- Awesome
	awful.key({ modkey, "Control" }, "r", awesome.restart, { description = "reload awesome", group = "awesome" }),
	awful.key({ modkey, "Shift" }, "q", awesome.quit, { description = "quit awesome", group = "awesome" }),

	-- Volume
	awful.key(
		{},
		"XF86AudioRaiseVolume",
		lazy(awful.spawn, "pactl set-sink-volume @DEFAULT_SINK@ +10%"),
		{ description = "raise volume", group = "volume" }
	),
	awful.key(
		{},
		"XF86AudioLowerVolume",
		lazy(awful.spawn, "pactl set-sink-volume @DEFAULT_SINK@ -10%"),
		{ description = "lower volume", group = "volume" }
	),
	awful.key(
		{},
		"XF86AudioMute",
		lazy(awful.spawn, "pactl set-sink-mute @DEFAULT_SINK@ toggle"),
		{ description = "mute volume", group = "volume" }
	),

	-- Media
	awful.key(
		{},
		"XF86AudioPlay",
		lazy(awful.spawn, "playerctl play-pause"),
		{ description = "play/pause media", group = "media" }
	),
	awful.key(
		{},
		"XF86AudioPrev",
		lazy(awful.spawn, "playerctl previous"),
		{ description = "previous media", group = "media" }
	),
	awful.key(
		{},
		"XF86AudioNext",
		lazy(awful.spawn, "playerctl next"),
		{ description = "next media", group = "media" }
	),

	-- Misc
	awful.key({}, "Print", lazy(awful.spawn, "flameshot gui"), { description = "open flameshot", group = "launcher" }),

	-- awful.key({ modkey }, "l", function()
	-- 	awful.tag.incmwfact(0.05)
	-- end, { description = "increase master width factor", group = "layout" }),
	-- awful.key({ modkey }, "h", function()
	-- 	awful.tag.incmwfact(-0.05)
	-- end, { description = "decrease master width factor", group = "layout" }),
	-- awful.key({ modkey, "Shift" }, "h", function()
	-- 	awful.tag.incnmaster(1, nil, true)
	-- end, { description = "increase the number of master clients", group = "layout" }),
	-- awful.key({ modkey, "Shift" }, "l", function()
	-- 	awful.tag.incnmaster(-1, nil, true)
	-- end, { description = "decrease the number of master clients", group = "layout" }),
	awful.key({ modkey, "Control" }, "h", function()
		awful.tag.incncol(1, nil, true)
	end, { description = "increase the number of columns", group = "layout" }),

	awful.key({ modkey, "Control" }, "l", function()
		awful.tag.incncol(-1, nil, true)
	end, { description = "decrease the number of columns", group = "layout" }),
})

-- Tags
for i in pairs(constants.tags) do
	awful.keyboard.append_global_keybindings({
		awful.key({ modkey }, tostring(i), function()
			local screen = awful.screen.focused()
			local tag = screen.tags[i]
			if tag then
				tag:view_only()
			end
		end, { description = "view tag " .. i, group = "tag" }),

		awful.key({ modkey, "Shift" }, tostring(i), function()
			if client.focus then
				local tag = client.focus.screen.tags[i]
				if tag then
					client.focus:move_to_tag(tag)
					tag:view_only()
				end
			end
		end, { description = "move focused client to tag #" .. i, group = "tag" }),

		awful.key({ modkey, "Control" }, tostring(i), function()
			if client.focus then
				local tag = client.focus.screen.tags[i]
				if tag then
					client.focus:move_to_tag(tag)
					tag:view_only()
				end
			end
		end, { description = "move focused client to tag #" .. i, group = "tag" }),
	})
end

-- Client keybindings
awful.keyboard.append_client_keybindings({
	awful.key({ modkey }, "q", function(c)
		c:kill()
	end, { description = "close", group = "client" }),

	awful.key({ modkey }, "f", function(c)
		c.floating = not c.floating
	end, { description = "toggle floating", group = "client" }),

	awful.key({ modkey, "Control" }, "Return", function(c)
		c:swap(awful.client.getmaster())
	end, { description = "move to master", group = "client" }),

	awful.key({ modkey, "Shift" }, "i", function(c)
		c:move_to_screen()
	end, { description = "move to screen", group = "client" }),

	awful.key({ modkey, "Shift" }, "m", function(c)
		c.maximized = not c.maximized
	end, { description = "toggle maximized", group = "client" }),

	awful.key({ modkey }, "n", function(c)
		c.minimized = true
	end, { description = "minimize", group = "client" }),

	awful.key({ modkey, "Shift" }, "n", function()
		local c = awful.client.restore()
		if c then
			c:emit_signal("request::activate", "key.unminimize", { raise = true })
		end
	end, { description = "restore minimized", group = "client" }),
})
