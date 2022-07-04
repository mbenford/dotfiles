local M = {}

function M.set(group, values)
	local cmd = 'hi ' .. group
	for k, v in pairs(values) do
		cmd = cmd .. string.format(' %s=%s', k, v)
	end
	vim.api.nvim_command(cmd)
end

function M.link(from_group, to_group)
	vim.api.nvim_command(string.format('hi! link %s %s', from_group, to_group))
end

return M
