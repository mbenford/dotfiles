local awful = require("awful")
local Promise = require("util.promise")

local M = {}

function M.spawn(cmd)
	local result = Promise.new()
	awful.spawn.easy_async_with_shell(cmd, function(stdout, stderr)
		result:resolve({ stdout = stdout, stderr = stderr })
	end)
	return result
end

return M
