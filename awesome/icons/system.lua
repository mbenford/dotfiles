local lgi = require("lgi")
local wibox = require("wibox")
local gears = require("gears")

local Gtk = lgi.require("Gtk", "3.0")
local theme = Gtk.IconTheme.new()
theme:set_search_path({ "/usr/share/icons" })
theme:set_custom_theme(require("beautiful").icon_theme)

local function lookup(name, size)
	if name == "" or name == nil or size == nil then
		return nil
	end

	local icon = theme:lookup_icon(name:lower(), size, 0)
	if icon == nil then
		return nil
	end

	return icon:get_filename()
end

local Icon = {}

local function new()
	local image = wibox.widget({
		widget = wibox.widget.imagebox,
		valign = "center",
		halign = "center",
	})
	gears.table.crush(image, Icon)
	return image
end

function Icon:set_name(name)
	self._private.name = name
	self:update()
end

function Icon:get_name()
	return self._private.name
end

function Icon:set_size(size)
	self._private.size = size
	self.forced_width = size
	self.forced_height = size
	self:update()
end

function Icon:get_size()
	return self._private.size
end

function Icon:update()
	if self._private.name == nil or self._private.size == nil then
		return
	end
	self.image = lookup(self._private.name, self._private.size)
end

return {
	icon = setmetatable({}, { __call = new }),
}
