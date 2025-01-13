return {
	"rebelot/heirline.nvim",
	opts = function()
		local conditions = require("heirline.conditions")
		local components = require("config.plugins.heirline.components")

		return {
			statusline = {
				hl = "StatusLine",
				fallthrough = false,
				{
					condition = function()
						return conditions.buffer_matches({
							buftype = { "prompt", "nofile", "terminal", "quickfix" },
						})
					end,
					{
						components.Mode,
						components.WorkDir,
						components.Fill,
						components.FileType,
					},
				},
				{
					components.Mode,
					components.WorkDir,
					components.FileInfo,
					components.Location,
					components.GitSigns,
					components.Diagnostics,
					components.Fill,
					components.RecordingStatus,
					components.DapStatus,
					components.LspStatus,
					components.FileIndent,
					components.FileEncoding,
					components.FileFormat,
					components.FileType,
					components.GitInfo,
				},
			},
		}
	end,
}
