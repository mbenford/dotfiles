return function(config)
	local ok, custom_config = pcall(require, "config.dap." .. config.name)
	if not ok then
		return config
	end

	if custom_config.adapter ~= nil then
		config.adapters = vim.tbl_deep_extend("force", config.adapters, custom_config.adapter)
	end

	if custom_config.configurations ~= nil then
		config.configurations = vim.list_extend(config.configurations, custom_config.configurations)
	end

	return config
end
