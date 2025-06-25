return {
	"mikesmithgh/kitty-scrollback.nvim",
	cond = not vim.env.DEVPOD,
	lazy = true,
	cmd = { "KittyScrollbackGenerateKittens", "KittyScrollbackCheckHealth" },
	event = { "User KittyScrollbackLaunch" },
	version = "^2.0.0", -- pin major version, include fixes and features that do not have breaking changes
	opts = {},
}
