local awful = require("awful")
local M = {}

function M.log(...)
	local output = {}
	for _, v in ipairs({ ... }) do
		table.insert(output, M.dump(v))
	end

	local info = debug.getinfo(2, "Sl")
	awful.spawn.with_shell(
		string.format(
			"echo %s:%s '%s' >> $HOME/.cache/awesome/user.log",
			info.source,
			info.currentline,
			table.concat(output, " ")
		)
	)
end

function M.dump(data)
	if type(data) ~= "table" then
		return tostring(data)
	end

	return require("inspect")(data)
	-- return require("gears.debug").dump_return(data)
end

return M
