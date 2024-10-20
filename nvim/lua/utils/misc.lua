local M = {}

function M.apply_zz(fn)
	return function()
		fn()
		vim.cmd.normal("zz")
	end
end

return M
