local M = {}

function M.set(group, values)
	vim.api.nvim_set_hl(0, group, values)
end

function M.get(group)
	local hl = vim.api.nvim_get_hl_by_name(group, true)
	for key, value in pairs(hl) do
		hl[key] = string.format('#%06x', value)
	end
	return hl
end

return M
