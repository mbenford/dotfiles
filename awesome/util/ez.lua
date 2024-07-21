local awful = require("awful")
local funcutil = require("util.func")

local mods = {
	["M"] = "Mod4",
	["A"] = "Mod1",
	["S"] = "Shift",
	["C"] = "Control",
}

local function parse(key)
	local parts = funcutil.split(key, "-")
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

function M.ezkey(mapping, action)
	local result = parse(mapping)
	return awful.key({
		modifiers = result.mods,
		key = result.value,
		on_press = action,
	})
end

function M.ezkeys(mappings)
	local bindings = {}
	for mapping, action in pairs(mappings) do
		table.insert(bindings, M.ezkey(mapping, action))
	end
	return bindings
end

function M.ezbutton(mapping, action)
	local result = parse(mapping)
	return awful.button({
		modifiers = result.mods,
		button = tonumber(result.value),
		on_press = action,
	})
end

function M.ezbuttons(mappings)
	local bindings = {}
	for mapping, action in pairs(mappings) do
		table.insert(bindings, M.ezbutton(mapping, action))
	end
	return bindings
end

return M
