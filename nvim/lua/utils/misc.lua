local M = {}

function M.apply_zz(fn)
	return function()
		fn()
		vim.cmd.normal("zz")
	end
end

function M.debounce(fn, timeout)
	local timer = vim.uv.new_timer()
	return function(...)
		local args = { ... }
		timer:stop()
		timer:start(
			timeout,
			0,
			vim.schedule_wrap(function()
				fn(unpack(args))
			end)
		)
	end
end

function M.work_dir()
	return string.upper(vim.fn.fnamemodify(vim.fn.getcwd(), ":t")) .. (vim.env.DEVPOD and " [DevPod]" or "")
end

return M
