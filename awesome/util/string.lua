local M = {}

function M.split(str, sep)
	if str == nil or str == "" then
		return {}
	end

	local items = {}
	for item in str:gmatch("([^" .. sep .. "]*)(" .. sep .. "?)") do
		table.insert(items, item)
	end
	return items
end

function M.trim(str)
	return str:match("^%s*(.-)%s*$")
end

function M.startswith(str, value)
	return str:find("^" .. value) ~= nil
end

return M
