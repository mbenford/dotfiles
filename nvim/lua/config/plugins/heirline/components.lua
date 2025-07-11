local M = {}

M.Space = { provider = " ", hl = "StatusLine" }
M.Sep = { provider = "  ", hl = "StatusLine" }
M.Fill = { provider = "%=", hl = "StatusLine" }
M.Empty = { provider = "" }

M.Flex = function(priority, component)
	return {
		flexible = priority,
		component,
		M.Empty,
	}
end

local function mode_name(mode)
	local modes = {
		{ "NORMAL", "^n" },
		{ "INSERT", "^i" },
		{ "COMMAND", "^c" },
		{ "VISUAL", "^[vV]" },
		{ "VISUAL", "^\22" },
		{ "SELECT", "^[sS]" },
		{ "REPLACE", "^R" },
		{ "TERM", "^t" },
		{ "MORE", "rm" },
	}
	for _, m in ipairs(modes) do
		if mode:match(m[2]) then
			return m[1]
		end
	end
	return "UNKNOWN"
end

M.Mode = {
	static = {
		longest_mode = 7,
	},
	init = function(self)
		self.mode = mode_name(vim.api.nvim_get_mode().mode)
	end,
	hl = function(self)
		return "StatusLineMode" .. self.mode
	end,
	{ provider = "  " },
	{
		provider = function(self)
			return self.mode
		end,
	},
	{
		provider = "",
		hl = { reverse = true },
	},
	{
		condition = function(self)
			return #self.mode < self.longest_mode
		end,
		M.Sep,
	},
	{
		condition = function(self)
			return #self.mode >= self.longest_mode
		end,
		M.Space,
	},
}

M.WorkDir = {
	hl = "StatusLineWorkDir",
	{
		provider = function()
			return " " .. require("utils.misc").work_dir()
		end,
	},
	M.Sep,
}

do
	local FileIcon = {
		init = function(self)
			self.icon, self.hl = require("mini.icons").get("file", vim.fn.expand("%:f"))
		end,
		condition = function()
			return package.loaded["mini.icons"] ~= nil
		end,
		hl = function(self)
			return self.hl
		end,
		provider = function(self)
			return self.icon
		end,
		M.Space,
	}

	local FileName = {
		init = function(self)
			self.filename = vim.fn.expand("%:.")
		end,
		hl = function()
			return vim.bo.modified and "StatusLineFilenameModified" or ""
		end,
		{
			condition = function(self)
				return self.filename ~= ""
			end,
			flexible = 1,
			{
				provider = function(self)
					return self.filename
				end,
			},
			{
				provider = function(self)
					local folder = vim.fn.fnamemodify(self.filename, ":h:t")
					local filename = vim.fn.fnamemodify(self.filename, ":t")
					return folder .. "/" .. filename
				end,
			},
			{
				provider = function(self)
					return vim.fn.fnamemodify(self.filename, ":t")
				end,
			},
		},
		{
			condition = function(self)
				return self.filename == ""
			end,
			{
				provider = "Untitled",
			},
		},
		M.Space,
	}

	local FileFlags = {
		condition = function()
			return vim.bo.readonly or not vim.bo.modifiable
		end,
		provider = function()
			if vim.bo.readonly or not vim.bo.modifiable then
				return ""
			end
		end,
		M.Space,
	}

	M.FileInfo = {
		FileIcon,
		FileName,
		FileFlags,
	}
end

M.FileIndent = {
	{
		provider = function()
			local size = vim.bo.shiftwidth
			return vim.bo.expandtab and ("SPACE:" .. size) or ("TAB:" .. size)
		end,
	},
	M.Sep,
}

M.FileType = {
	condition = function()
		return vim.bo.filetype ~= ""
	end,
	{
		provider = function()
			return string.upper(vim.bo.filetype)
		end,
	},
	M.Sep,
}

M.FileEncoding = {
	condition = function()
		return vim.bo.fileencoding ~= ""
	end,
	{
		provider = function()
			return string.upper(vim.bo.fileencoding)
		end,
	},
	M.Sep,
}

M.FileFormat = {
	{
		provider = function()
			local format = vim.bo.fileformat
			if format == "mac" then
				return "CR"
			end

			if format == "dos" then
				return "CRLF"
			end

			return "LF"
		end,
	},
	M.Sep,
}

M.WordCount = {
	condition = function()
		return vim.bo.filetype == "markdown" or vim.bo.filetype == "text"
	end,
	{
		provider = function()
			local wc = vim.fn.wordcount()
			return string.format("WORDS:%d CHARS:%d", wc.words, wc.chars)
		end,
	},
	M.Sep,
}

M.RecordingStatus = {
	condition = function()
		return vim.fn.reg_recording() ~= ""
	end,
	hl = "StatusLineMacroRecording",
	{
		provider = function()
			return " REC @" .. vim.fn.reg_recording()
		end,
	},
	M.Sep,
}

M.LspStatus = {
	condition = function()
		return #vim.lsp.get_clients({ bufnr = 0 }) > 0
	end,
	{
		provider = function()
			return " " .. #vim.lsp.get_clients({ bufnr = 0 })
		end,
	},
	hl = "StatusLineLspActive",
	M.Sep,
}

M.DapStatus = {
	condition = function()
		return package.loaded.dap ~= nil and require("dap").session() ~= nil
	end,
	init = function(self)
		self.session = require("dap").session()
	end,
	hl = "StatusLineDapActive",
	{
		provider = function(self)
			return " " .. string.upper(self.session.config.name)
		end,
	},
	M.Sep,
}

M.SelectionCount = {
	condition = function()
		return mode_name(vim.api.nvim_get_mode().mode) == "VISUAL"
	end,
	{
		provider = function()
			local line_start, line_end = vim.fn.line("v"), vim.fn.line(".")
			local lines = math.abs(line_end - line_start) + 1
			local chars = vim.fn.wordcount().visual_chars
			return string.format("(%dL:%dC)", lines, chars)
		end,
	},
	M.Space,
	update = { "CursorMoved", "ModeChanged" },
}

M.Location = {
	{ provider = "%2l:%-2v" },
	M.Sep,
}

do
	local GitBranch = {
		hl = function(self)
			return "StatusLineGitStatus" .. self.git.status
		end,
		{
			provider = function(self)
				return " " .. require("utils.string").truncate_middle(self.git.head, 20)
			end,
		},
		M.Space,
	}

	local GitCommits = {
		condition = function(self)
			return self.git.ahead > 0 or self.git.behind > 0
		end,
		hl = "StatusLineGitCommits",
		{
			condition = function(self)
				return self.git.ahead > 0
			end,
			provider = function(self)
				return "↑" .. self.git.ahead
			end,
		},
		{
			condition = function(self)
				return self.git.behind > 0
			end,
			provider = function(self)
				return "↓" .. self.git.behind
			end,
		},
		M.Space,
	}

	M.GitInfo = {
		condition = function()
			return vim.g.git ~= nil and vim.g.git.head ~= ""
		end,
		init = function(self)
			self.git = vim.g.git
		end,
		GitBranch,
		GitCommits,
	}
end

do
	local function DiagnosticIcon(severity)
		return {
			condition = function(self)
				return self.count[severity] ~= nil
			end,
			hl = function(self)
				return self.signs.texthl[severity]
			end,
			{
				provider = function(self)
					return self.signs.text[severity] .. " " .. self.count[severity]
				end,
				M.Space,
			},
		}
	end

	M.Diagnostics = {
		static = {
			signs = vim.diagnostic.config().signs,
		},
		condition = function()
			return mode_name(vim.api.nvim_get_mode().mode) ~= "INSERT"
		end,
		init = function(self)
			self.count = vim.diagnostic.count(0)
		end,
		update = {
			"DiagnosticChanged",
			callback = function()
				vim.cmd.redrawstatus()
			end,
		},
		DiagnosticIcon(vim.diagnostic.severity.ERROR),
		DiagnosticIcon(vim.diagnostic.severity.WARN),
		M.Space,
	}
end

do
	local GitDiff = function(sign, type, hl)
		return {
			hl = hl,
			condition = function()
				return vim.b.gitsigns_status_dict[type] ~= nil and vim.b.gitsigns_status_dict[type] > 0
			end,
			{
				provider = function()
					return sign .. vim.b.gitsigns_status_dict[type]
				end,
			},
		}
	end

	M.GitSigns = {
		condition = function()
			return vim.b.gitsigns_status_dict ~= nil
		end,
		GitDiff("+", "added", "GitSignsAdd"),
		GitDiff("~", "changed", "GitSignsChange"),
		GitDiff("-", "removed", "GitSignsDelete"),
		M.Sep,
	}
end

M.Grapple = {
	condition = function()
		return package.loaded.grapple ~= nil
	end,
	provider = function()
		return require("grapple").statusline()
	end,
}

M.Copilot = {
	condition = function()
		return package.loaded.copilot ~= nil
	end,
	hl = "StatusLineCopilotActive",
	{ provider = " " },
	M.Sep,
}

return M
