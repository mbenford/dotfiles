local awful = require("awful")
local stringutil = require("util.string")

local mods = {
	["M"] = "Mod4",
	["A"] = "Mod1",
	["S"] = "Shift",
	["C"] = "Control",
}

local function parse(key)
	local parts = stringutil.split(key, "-")
	local result = {
		value = parts[#parts],
		mods = {},
	}

	for i = 1, #parts - 1 do
		table.insert(result.mods, mods[parts[i]])
	end

	return result
end

local M = {}

function M.key(mapping, action)
	local result = parse(mapping)
	return awful.key({
		modifiers = result.mods,
		key = result.value,
		on_press = action,
	})
end

function M.keys(mappings)
	local bindings = {}
	for mapping, action in pairs(mappings) do
		table.insert(bindings, M.key(mapping, action))
	end
	return bindings
end

function M.button(mapping, action)
	local result = parse(mapping)
	return awful.button({
		modifiers = result.mods,
		button = tonumber(result.value),
		on_press = action,
	})
end

function M.buttons(mappings)
	local bindings = {}
	for mapping, action in pairs(mappings) do
		table.insert(bindings, M.button(mapping, action))
	end
	return bindings
end

return M
