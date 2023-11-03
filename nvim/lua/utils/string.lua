local M = {}

function M.last_index_of(str, substr)
	local i = #str - #substr
	while i > 0 do
		if str:sub(i, i + #substr - 1) == substr then
			return i
		end
		i = i - 1
	end
	return -1
end

function M.truncate_left(str, length)
	if #str <= length then
		return str
	end
	return '…' .. str:sub(#str - length + 2, #str)
end

return M
