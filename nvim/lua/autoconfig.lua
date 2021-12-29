return function(startup)
	return function(spec)
		if type(spec) ~= 'table' or type(spec[1]) ~= 'table' then
			error('autoconfig decorator supports table specs only')
		end

		for k, v in pairs(spec[1]) do
			if v.config == nil then
				local i = string.find(v[1], '/')
				local config_file = string.format('plugins/%s', string.sub(v[1], i + 1))
				config_file = string.lower(config_file)
				config_file = string.gsub(config_file, '[%._]', '-')
				v.config = string.format('pcall(require, "%s")', config_file)
			end
		end

		startup(spec)
	end
end
