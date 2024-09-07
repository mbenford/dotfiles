local wibox = require("wibox")
local gears = require("gears")
local dir = gears.filesystem.get_xdg_data_home() .. "material-symbols/node_modules/@material-symbols/svg-400"

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

	local variation = self.variation or "outlined"
	local fill = self.fill and "-fill" or ""
	self.image = string.format("%s/%s/%s%s.svg", dir, variation, name, fill)
end

function Icon:get_name()
	return self._private.name
end

function Icon:set_variation(variation)
	self._private.variation = variation
end

function Icon:get_variation()
	return self._private.variation
end

function Icon:set_fill(fill)
	self._private.fill = fill
end

function Icon:get_fill()
	return self._private.fill
end

function Icon:set_size(size)
	self._private.size = size
	self.forced_width = size
	self.forced_height = size
end

function Icon:get_size()
	return self._private.size
end

function Icon:set_fg(color)
	self._private.fg = color
	self.stylesheet = string.format("svg { fill: %s; }", color)
end

function Icon:get_fg()
	return self._private.fg
end

return {
	icon = setmetatable({}, { __call = new }),
}
