local async = require("util.async")
local Promise = require("util.promise")
local string_util = require("util.string")

local M = {
	signal_levels = { excellent = 80, good = 55, ok = 30, low = 5 },
}

function M.signal_to_grade(signal)
	if signal > M.signal_levels.excellent then
		return 5
	elseif signal > M.signal_levels.good then
		return 4
	elseif signal > M.signal_levels.ok then
		return 3
	elseif signal > M.signal_levels.low then
		return 2
	else
		return 1
	end
end

function M.scan(opts)
	opts = opts or {}
	opts.rescan = opts.rescan or "auto"

	local promise = Promise.new()
	async.spawn("nmcli -g SSID,SIGNAL,SECURITY dev wifi list --rescan " .. opts.rescan):next(function(result)
		local access_points = {}
		for _, ap in ipairs(string_util.split(result.stdout, "\n")) do
			local items = string_util.split(ap, ":")
			if items[1] ~= "" then
				table.insert(access_points, {
					ssid = items[1],
					signal = tonumber(items[2]),
					security = items[3],
				})
			end
		end
		promise:resolve(access_points)
	end)
	return promise
end

return M
