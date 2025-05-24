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
	return #str > length and ("…" .. str:sub(#str - length + 2, #str)) or str
end

function M.truncate_right(str, length)
	return #str > length and (str:sub(1, length) .. "…") or str
end

function M.truncate_middle(str, length)
	if #str <= length then
		return str
	end

	local half = math.floor((length - 1) / 2)
	local left = str:sub(1, half)
	local right = str:sub(-half)

	return left .. "…" .. right
end

return M
