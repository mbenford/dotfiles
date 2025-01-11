return {
	"rcarriga/nvim-dap-ui",
	dependencies = { "nvim-dap" },
	lazy = true,
	event = "User DapLoaded",
	opts = {
		controls = { enabled = false },
		layouts = {
			{
				position = "bottom",
				size = 10,
				elements = {
					{ id = "repl", size = 0.5 },
				},
			},
			{
				position = "right",
				size = 60,
				elements = {
					{ id = "scopes", size = 0.25 },
					{ id = "watches", size = 0.25 },
					{ id = "stacks", size = 0.25 },
					{ id = "breakpoints", size = 0.25 },
				},
			},
		},
	},
	config = function(_, opts)
		local dapui = require("dapui")
		dapui.setup(opts)

		local after = require("dap").listeners.after
		after.event_initialized["dap-ui"] = dapui.open
		after.event_terminated["dap-ui"] = dapui.close
		after.event_exited["dap-ui"] = dapui.close
		after.disconnect["dap-ui"] = dapui.close

		vim.api.nvim_create_autocmd("BufWinEnter", {
			pattern = { "*dap*", "DAP *" },
			callback = function(args)
				local win = vim.fn.bufwinid(args.buf)
				if not vim.api.nvim_win_is_valid(win) then
					return
				end
				vim.wo[win].winbar = "%f"
			end,
		})
	end,
	keys = {
		{
			"<Leader>du",
			function()
				require("dapui").toggle()
			end,
			desc = "Toggle DAP UI",
		},
	},
}
