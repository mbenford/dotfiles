local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	spec = { { import = "config.plugins" } },
	install = { colorscheme = { "default" } },
	ui = { backdrop = 100, border = "rounded" },
	checker = { enabled = false },
	performance = {
		rtp = {
			disabled_plugins = {
				"2html_plugin",
				"tutor_mode_plugin",
				"tutor",
			},
		},
	},
})

vim.keymap.set("n", "<Leader>L", "<Cmd>Lazy<CR>", { desc = "Open Lazy" })
