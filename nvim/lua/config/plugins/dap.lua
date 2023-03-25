return {
	'mfussenegger/nvim-dap',
	event = 'BufRead',
	config = function()
		require("dap")
		local sign = vim.fn.sign_define
		sign('DapBreakpoint', { text = '●', texthl = 'DapBreakpoint' })
		sign('DapBreakpointCondition', { text = '●', texthl = 'DapBreakpointCondition' })
		sign('DapBreakpointRejected', { text = '●', texthl = 'DapBreakpointRejected' })
		sign('DapLogPoint', { text = '◆', texthl = 'DapLogPoint' })
		sign('DapStopped', { text = '󰜴', texthl = 'DapStopped' })
	end,
}
