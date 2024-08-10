local lgi = require("lgi")
local Gtk = lgi.require("Gtk", "3.0")

local theme = Gtk.IconTheme.new()
theme:set_search_path({ "/usr/share/icons" })
Gtk.IconTheme.set_custom_theme(theme, "Papirus")

local M = {
	cache = {},
}

function M.lookup_filename(name, size)
	if name == "" or name == nil then
		return nil
	end

	local key = name:lower() .. "_" .. size
	if M.cache[key] then
		return M.cache[key]
	end

	local icon = theme:lookup_icon(name:lower(), size, 0)
	if icon == nil then
		return nil
	end

	M.cache[key] = icon:get_filename()
	return M.cache[key]
end

return M
