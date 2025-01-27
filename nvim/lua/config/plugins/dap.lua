return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"nvim-neotest/nvim-nio",
	},
	lazy = true,
	init = function()
		require("which-key").add({
			{ "<Leader>d", group = "DAP" },
		})
	end,
	config = function()
		require("dap")

		local sign = vim.fn.sign_define
		sign("DapBreakpoint", { text = "●", texthl = "DapBreakpoint" })
		sign("DapBreakpointCondition", { text = "■", texthl = "DapBreakpoint" })
		sign("DapBreakpointRejected", { text = "⊗", texthl = "DapBreakpointRejected" })
		sign("DapLogPoint", { text = "◆", texthl = "DapLogPoint" })
		sign("DapStopped", { text = "", texthl = "DapStopped", linehl = "DapStoppedLine" })

		vim.api.nvim_exec_autocmds("User", { pattern = "DapLoaded" })
	end,
	keys = {
		{
			"<Leader>ds",
			function()
				require("dap").continue()
			end,
			desc = "Run/Resume debug session",
		},
		{
			"<Leader>dd",
			function()
				require("dap").run_last()
			end,
			desc = "Run last debug session",
		},
		{
			"<Leader>dr",
			function()
				require("dap").restart()
			end,
			desc = "Restart debug session",
		},
		{
			"<Leader>dq",
			function()
				require("dap").terminate()
			end,
			desc = "Stop debug session",
		},
		{
			"<Leader>dbb",
			function()
				require("dap").toggle_breakpoint()
			end,
			desc = "Toggle breakpoint",
		},
		{
			"<Leader>dbl",
			function()
				local message = vim.fn.input("Log point message: ")
				require("dap").set_breakpoint(nil, nil, message)
			end,
			desc = "Set log point",
		},
		{
			"<Leader>dbc",
			function()
				local condition = vim.fn.input("Breakpoint condition")
				require("dap").set_breakpoint(condition, nil, nil)
			end,
			desc = "Set a breakpoint with a condition",
		},
		{
			"<Leader>dbh",
			function()
				local condition = vim.fn.input("Breakpoint hit condition")
				require("dap").set_breakpoint(nil, condition, nil)
			end,
			desc = "Set a breakpoint with a hit condition",
		},
		{
			"<Leader>dbD",
			function()
				require("dap").clear_breakpoints()
			end,
			desc = "Deletes all breakpoints",
		},
		{
			"<Leader>dj",
			function()
				require("dap").step_over()
			end,
			desc = "Step over",
		},
		{
			"<Leader>dl",
			function()
				require("dap").step_into()
			end,
			desc = "Step into",
		},
		{
			"<Leader>dh",
			function()
				require("dap").step_out()
			end,
			desc = "Step out",
		},
		{
			"<Leader>dc",
			function()
				require("dap").run_to_cursor()
			end,
			desc = "Run to cursor",
		},
		{
			"<Leader>d<Space>",
			function()
				require("which-key").show({
					keys = "<Leader>d",
					loop = true,
				})
			end,
		},
	},
}
