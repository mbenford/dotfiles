local M = {}

function M.hl(args)
	local cmd = 'hi ' .. args[1]
	for k, v in pairs(args) do
		if type(k) == 'string' then cmd = cmd .. string.format(' %s=%s', k, v) end
	end
	vim.cmd(cmd)
end

return M
