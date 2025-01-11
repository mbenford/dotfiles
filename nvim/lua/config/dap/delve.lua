return {
	adapter = {
		enrich_config = function(config, on_config)
			config = vim.deepcopy(config)
			config.outputMode = "remote"
			on_config(config)
		end,
	},
	configurations = {
		{
			type = "delve",
			name = "Delve: Debug file",
			request = "launch",
			program = "${file}",
		},
	},
}
