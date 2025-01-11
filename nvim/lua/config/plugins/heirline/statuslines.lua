
local M = {}

M.Basic =

M.QuickFix = {
	condition = function()
		return conditions.buffer_matches({ buftype = { "quickfix" } })
	end,
	components.Mode,
	components.FileName,
}

M.Default =
return M
