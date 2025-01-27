return {
	"rebelot/heirline.nvim",
	event = { "BufRead", "BufNewFile" },
	opts = function()
		local conditions = require("heirline.conditions")
		local components = require("config.plugins.heirline.components")
		local Flex = components.Flex

		return {
			statusline = {
				hl = "StatusLine",
				fallthrough = false,
				{
					condition = function()
						return conditions.buffer_matches({
							buftype = { "prompt", "nofile", "terminal", "quickfix", "help" },
						})
					end,
					{
						components.Mode,
						components.WorkDir,
						components.Fill,
						components.FileType,
						components.Location,
					},
				},
				{
					components.Mode,
					components.WorkDir,
					components.FileInfo,
					Flex(8, components.GitSigns),
					components.Diagnostics,
					components.Fill,
					components.RecordingStatus,
					components.DapStatus,
					Flex(3, components.FileEncoding),
					Flex(4, components.FileFormat),
					Flex(5, components.FileType),
					Flex(6, components.FileIndent),
					components.Location,
					Flex(7, components.LspStatus),
					Flex(7, components.Copilot),
					Flex(8, components.GitInfo),
				},
			},
		}
	end,
}
