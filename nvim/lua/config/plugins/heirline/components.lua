local conditions = require("heirline.conditions")

local M = {}

M.Space = { provider = " ", hl = "StatusLine" }
M.Sep = { provider = "  ", hl = "StatusLine" }
M.Fill = { provider = "%=", hl = "StatusLine" }
M.Empty = { provider = "" }

local function Flex(priority, component)
	return {
		flexible = priority,
		component,
		M.Empty,
	}
end

M.Mode = {
	static = {
		mode_names = {
			n = "NORMAL",
			no = "NORMAL",
			nov = "NORMAL",
			noV = "NORMAL",
			["no\22"] = "NORMAL",
			niI = "NORMAL",
			niR = "NORMAL",
			niV = "NORMAL",
			nt = "NORMAL",
			v = "VISUAL",
			vs = "VISUAL",
			V = "VISUAL",
			Vs = "VISUAL",
			["\22"] = "VISUAL",
			["\22s"] = "VISUAL",
			s = "SELECT",
			S = "SELECT",
			["\19"] = "SELECT",
			i = "INSERT",
			ic = "INSERT",
			ix = "INSERT",
			R = "REPLACE",
			Rc = "REPLACE",
			Rx = "REPLACE",
			Rv = "REPLACE",
			Rvc = "REPLACE",
			Rvx = "REPLACE",
			c = "COMMAND",
			cv = "EX",
			r = "PROMPT",
			rm = "MORE",
			["r?"] = "CONFIRM",
			["!"] = "SHELL",
			t = "TERMINAL",
		},
	},
	init = function(self)
		self.mode = self.mode_names[vim.api.nvim_get_mode().mode]
	end,
	hl = function(self)
		return "StatusLineMode" .. self.mode
	end,
	update = "ModeChanged",
	{
		provider = function(self)
			return self.mode
		end,
	},
	M.Sep,
}

M.WorkDir = {
	hl = "StatusLineWorkDir",
	{
		provider = function()
			return string.upper(vim.fn.fnamemodify(vim.fn.getcwd(), ":t"))
		end,
	},
	M.Sep,
}

M.FileName = {
	init = function(self)
		self.filename = vim.fn.expand("%:f:~")
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
				return vim.fn.pathshorten(self.filename, 1)
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
			provider = "[No Name]",
		},
	},
	M.Sep,
}

M.FileFlags = {
	condition = function()
		return vim.bo.readonly or not vim.bo.modifiable
	end,
	{
		provider = function()
			if vim.bo.readonly or not vim.bo.modifiable then
				return ""
			end
		end,
	},
	M.Space,
}

M.FileIcon = {
	init = function(self)
		self.icon, self.hl = require("mini.icons").get("file", vim.fn.expand("%:f"))
	end,
	condition = function()
		return package.loaded["mini.icons"] ~= nil
	end,
	hl = function(self)
		return self.hl
	end,
	{
		provider = function(self)
			return self.icon
		end,
	},
	M.Space,
}

M.FileInfo = {
	M.FileFlags,
	M.FileName,
}

M.FileIndent = Flex(6, {
	{
		provider = function()
			local size = vim.bo.shiftwidth
			return vim.bo.expandtab and ("SPACES:" .. size) or ("TAB:" .. size)
		end,
	},
	M.Sep,
})

M.FileType = Flex(5, {
	condition = function()
		return vim.bo.filetype ~= ""
	end,
	{
		provider = function()
			return string.upper(vim.bo.filetype)
		end,
	},
	M.Sep,
})

M.FileEncoding = Flex(4, {
	condition = function()
		return vim.bo.fileencoding ~= ""
	end,
	{
		provider = function()
			return string.upper(vim.bo.fileencoding)
		end,
	},
	M.Sep,
})

M.FileFormat = Flex(3, {
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
})

M.RecordingStatus = {
	condition = function()
		return vim.fn.reg_recording() ~= ""
	end,
	hl = "StatusLineMacroRecording",
	{
		provider = function()
			return " " .. vim.fn.reg_recording()
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
			return "LSP:" .. #vim.lsp.get_clients({ bufnr = 0 })
		end,
	},
	M.Sep,
}

M.DapStatus = {
	condition = function()
		return package.loaded["dap"] ~= nil
	end,
	{
		provider = function()
			return vim.g.dap_status
		end,
	},
	M.Sep,
}

M.Location = {
	{ provider = "%2l:%-2v" },
	M.Sep,
}

M.GitBranch = {
	provider = function()
		return " " .. (conditions.is_git_repo() and vim.b.gitsigns_status_dict["head"] or "NO BRANCH")
	end,
	hl = "StatusLineGitBranch",
}

local function diagnostic_icon(severity)
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
	init = function(self)
		self.count = vim.diagnostic.count(0)
	end,
	update = {
		"DiagnosticChanged",
		callback = function()
			vim.cmd("redrawstatus")
		end,
	},
	diagnostic_icon(vim.diagnostic.severity.ERROR),
	diagnostic_icon(vim.diagnostic.severity.WARN),
}

return M
