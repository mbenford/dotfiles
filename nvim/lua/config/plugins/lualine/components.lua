local truncate_right = require("utils.string").truncate_right

local function get_cwd()
	return vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
end

local M = {}

M.cwd = {
	function()
		return truncate_right(get_cwd(), 20)
	end,
}

M.filename = {
	function()
		local file = vim.fn.expand("%:t:~")
		if file == "" then
			file = "[No Name]"
		else
			local parent = vim.fn.expand("%:p:h:t")
			if parent ~= get_cwd() then
				file = parent .. "/" .. file
			end
		end

		if not vim.bo.modifiable or vim.bo.readonly then
			file = file .. " "
		end

		return file
	end,
	color = function()
		return vim.bo.modified and "LualineFilenameModified" or nil
	end,
}

M.filetype = {
	function()
		return vim.bo.filetype
	end,
	fmt = string.upper,
}

M.lsp = {
	function()
		return "LSP:" .. #vim.lsp.get_clients({ bufnr = 0 })
	end,
	cond = function()
		return #vim.lsp.get_clients({ bufnr = 0 }) > 0
	end,
}

M.diagnostics = {
	"diagnostics",
	sources = { "nvim_diagnostic" },
	sections = { "error", "warn" },
	symbols = { error = "󰅙 ", warn = " " },
}

M.copilot = {
	function()
		return ""
	end,
	cond = function()
		return #vim.lsp.get_clients({ bufnr = 0, name = "copilot" }) > 0
	end,
	color = "LualineCopilotActive",
}

M.indentation = function()
	local size = vim.bo.shiftwidth
	return vim.bo.expandtab and ("SPACES:" .. size) or ("TAB:" .. size)
end

M.file_format = {
	function()
		return vim.bo.fileformat
	end,
	cond = function()
		return vim.bo.fileformat ~= "unix"
	end,
	color = "LualineExoticFileFormat",
	fmt = string.upper,
}

M.file_encoding = {
	function()
		return vim.bo.fileencoding:get() ~= "utf-8" and vim.bo.fileencoding or ""
	end,
	fmt = string.upper,
}

M.location = {
	function()
		return "%2l:%-2v"
	end,
}

M.recording_status = {
	function()
		return "REC @" .. vim.fn.reg_recording()
	end,
	icon = "",
	cond = function()
		return vim.fn.reg_recording() ~= ""
	end,
	color = "LualineMacroRecording",
}

M.git_branch = {
	"branch",
	icon = "",
}

return M
