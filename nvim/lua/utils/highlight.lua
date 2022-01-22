local M = {}

function M.add(args)
	local cmd = 'hi ' .. args[1]
	for k, v in pairs(args) do
		if type(k) == 'string' then
			cmd = cmd .. string.format(' %s=%s', k, v)
		end
	end
	vim.cmd(cmd)
end

function M.link(args)
	vim.cmd('hi! link ' .. args[1] .. ' ' .. args[2])
end

return M
