local theme = require("gears.table").crush(
	require("themes.default"),
	require("themes.tokyonight").setup({
		flavor = "storm",
	})
)

local beautiful = require("beautiful")
if not beautiful.init(theme) then
	beautiful.init(require("gears.filesystem").get_themes_dir() .. "default/theme.lua")
end
