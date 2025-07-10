local scratchpad = require("util.scratchpad")

scratchpad.register({
	["kitty"] = {
		command = "kitty --name kitty-scratch",
		rule = { instance = "kitty-scratch" },
		width = 1600,
		height = 0.9,
		toggle_ezkey = "M-S-Return",
	},
	["calc"] = {
		command = "qalculate-gtk --name qalculate-scratch",
		rule = { instance = "qalculate-scratch" },
		width = 600,
		height = 100,
		toggle_ezkey = "M-c",
	},
	["youtube-music"] = {
		command = "gtk-launch youtube-music",
		width = 1600,
		height = 0.9,
		toggle_ezkey = "M-y",
	},
	["ticktick"] = {
		command = "gtk-launch ticktick",
		width = 1600,
		height = 0.9,
		toggle_ezkey = "M-t",
	},
	["vpn"] = {
		command = "kitty --name kitty-vpn -- vpn",
		rule = { instance = "kitty-vpn" },
		width = 1300,
		height = 0.5,
		toggle_ezkey = "M-C-v",
	},
	["pavucontrol"] = {
		command = "pavucontrol",
		width = 800,
		height = 0.5,
		toggle_ezkey = "M-p",
	},
})
