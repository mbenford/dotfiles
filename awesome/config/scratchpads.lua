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
})
