local function file_exists(filename)
	local f = io.open(filename, 'r')
	if f ~= nil then io.close(f) return true else return false end
end

return function(startup)
	return function(spec)
		if type(spec) ~= 'table' then
			error('autoconfig decorator supports table specs only')
		end

		for _, v in pairs(spec[1]) do
			if v.config == nil then
				local i = string.find(v[1], '/')
				local config_module = string.format('plugins/%s', string.sub(v[1], i + 1))
				config_module = string.lower(config_module)
				config_module = string.gsub(config_module, '[%._]', '-')

				local config_file = string.format('%s/lua/%s.lua', vim.fn.stdpath('config'), config_module)
				if file_exists(config_file) then
					v.config = string.format('pcall(require, "%s")', config_module)
				end
			end
		end

		startup(spec)
	end
end
