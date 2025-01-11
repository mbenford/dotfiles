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
						components.Space,
						components.Mode,
						components.Fill,
						components.FileType,
					},
				},
				{
					components.Space,
					components.Mode,
					components.WorkDir,
					components.FileFlags,
					components.FileName,
					components.Location,
					components.Diagnostics,
					components.Fill,
					components.RecordingStatus,
					components.DapStatus,
					components.LspStatus,
					components.FileIndent,
					components.FileEncoding,
					components.FileFormat,
					components.FileType,
					components.GitBranch,
					components.Space,
				},
			},
		}
	end,
}
