local M = {}

function M.launch(opts)
	opts = opts or {}
	opts.type = opts.type or "overlay"
	opts.cwd = opts.cwd or "current"

	local cmd = {
		"kitten",
		"@",
		"launch",
		"--cwd=" .. opts.cwd,
		"--type=" .. opts.type,
	}

	if opts.title then
		table.insert(cmd, "--title=" .. opts.title)
	end

	if opts.hold then
		table.insert(cmd, "--hold")
	end

	vim.list_extend(cmd, vim.split(opts.cmd, " "))
	vim.system(cmd)
end

return M
