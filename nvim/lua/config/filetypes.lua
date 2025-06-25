vim.filetype.add({
	extension = {
		pcss = "pcss",
		rasi = "rasi",
	},
	pattern = {
		[".*devcontainer.*.json"] = "json5",
	},
})
