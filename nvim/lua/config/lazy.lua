local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--single-branch",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	})
end
vim.opt.runtimepath:prepend(lazypath)

require("lazy").setup("config.plugins", {
	ui = {
		border = "rounded",
		backdrop = 100,
	},
	performance = {
		rtp = {
			disabled_plugins = {
				-- '2html_plugin',
				-- 'gzip',
				-- 'tarPlugin',
				-- 'tutor_mode_plugin',
				-- 'zipPlugin',
				-- 'remote_plugins',
			},
		},
	},
})

vim.keymap.set("n", "<Leader>L", "<Cmd>Lazy<CR>", { desc = "Open Lazy" })
