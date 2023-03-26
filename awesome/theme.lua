local theme = require('themes.catppuccin').setup({
	flavor = 'macchiato',
})

local beautiful = require("beautiful")
if not beautiful.init(theme) then
	beautiful.init(require("gears.filesystem").get_themes_dir() .. "default/theme.lua")
end
