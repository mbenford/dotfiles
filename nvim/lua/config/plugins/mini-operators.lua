return {
	"echasnovski/mini.operators",
	version = "*",
	event = { "BufRead", "BufNewFile" },
	opts = {
		evaluate = {
			func = function(input)
				local cmd = vim.fn.input("Filter command")
				if cmd == "" then
					return nil
				end

				cmd = vim.split(cmd, " ")
				local ok, result = pcall(vim.system, cmd, { text = true, stdin = input.lines })
				if not ok then
					vim.notify(result, "error")
					return nil
				end

				local completed = result:wait()
				if completed.code ~= 0 then
					vim.notify(completed.stderr, "error")
					return input.lines
				end

				return vim.split(completed.stdout, "\n")
			end,
		},
	},
}
