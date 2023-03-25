return {
	'rcarriga/nvim-dap-ui',
	dependencies = {
		'nvim-dap',
	},
	config = function()
		local dapui = require('dapui')
		dapui.setup()

		local after = require('dap').listeners.after
		after.event_initialized['dapui_config'] = dapui.open
		after.event_terminated['dapui_config'] = dapui.close
		after.event_exited['dapui_config'] = dapui.close
		after.disconnect['dapui_config'] = dapui.close
	end,
}
