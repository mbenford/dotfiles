local stringx = require("pl.stringx")
local async = require("util.async")

local M = {}

function M.uptime()
	return async.spawn("uptime -p"):next(function(result)
		return stringx.strip(result.stdout)
	end)
end

function M.hostname()
	return async.spawn("hostname"):next(function(result)
		return stringx.strip(result.stdout)
	end)
end

function M.whoami()
	return async.spawn("whoami"):next(function(result)
		return stringx.strip(result.stdout)
	end)
end

return M
