local M = {}

function M.split(str, sep)
	if str == nil or str == "" then
		return ""
	end

	local items = {}
	for item in str:gmatch("([^" .. sep .. "]+)") do
		table.insert(items, item)
	end
	return items
end

return M
