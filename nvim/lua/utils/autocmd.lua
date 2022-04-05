local M = {}

local function reset_group(group)
	vim.cmd(([[
		aug %s
			au!
    aug END
	]]):format(group))
end

local function group_command(group, event, pattern, command)
	if type(command) == 'function' then
		command = require('utils.function').register(command)
	end

	vim.cmd(([[
		aug %s
			au %s %s %s
		aug END
	]]):format(group, event, pattern, command))
end

function M.augroup(group)
	reset_group(group)
	return function(event, pattern, command)
		group_command(group, event, pattern, command)
	end
end

function M.autocmd(event, pattern, command)
	group_command('user_cmds', event, pattern, command)
end

return M
