local dapui = require('dapui')
dapui.setup({
	icons = {
		expanded = '',
		collapsed = '',
		current_frame = '',
	},
	layouts = {
		{
			elements = {
				{ id = 'scopes', size = 0.25 },
				'breakpoints',
				'stacks',
				'watches',
			},
			size = 40,
			position = 'left',
		},
		{
			elements = {
				'repl',
			},
			size = 0.25,
			position = 'bottom',
		},
	},
})

local dap = require('dap')
dap.listeners.after.event_initialized['dapui_config'] = function()
	dapui.open()
end
dap.listeners.before.event_terminated['dapui_config'] = function()
	dapui.close()
end
dap.listeners.before.event_exited['dapui_config'] = function()
	dapui.close()
end
