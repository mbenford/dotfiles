local truncate_right = require("utils.string").truncate_right

local function get_cwd()
	return vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
end

local function cwd()
	return truncate_right(get_cwd(), 20)
end

local function filename()
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

	if vim.bo.modified then
		file = "%#LualineFilenameModified#" .. file
	end

	return file
end

local function filetype()
	return vim.bo.filetype
end

local function lsp_status()
	local clients = #vim.lsp.get_clients()
	local status = " " .. clients
	return clients > 0 and ("%#LualineLspActive#" .. status) or status
end

local function indentation()
	local size = vim.bo.shiftwidth
	return vim.bo.expandtab and ("SPACES:" .. size) or ("TAB:" .. size)
end

local function file_format()
	return vim.bo.fileformat ~= "unix" and ("%#LualineExoticFileFormat#" .. vim.bo.fileformat) or ""
end

local function file_encoding()
	return vim.bo.fileencoding:get() ~= "utf-8" and vim.bo.fileencoding or ""
end

local function location()
	return "%2l:%-2v"
end

local function recording_status()
	return vim.g.lualine_macro_recording and ("%#LualineRecording# RECORDING @" .. vim.fn.reg_recording()) or ""
end

return {
	"nvim-lualine/lualine.nvim",
	opts = {
		options = {
			theme = "tokyonight",
			globalstatus = true,
			icons_enabled = true,
			section_separators = { left = "", right = "" },
			component_separators = { left = "", right = "" },
		},
		sections = {
			lualine_a = {
				cwd,
			},
			lualine_b = {},
			lualine_c = {
				filename,
			},
			lualine_x = {
				recording_status,
				{ "branch", icon = "" },
				{
					"diagnostics",
					sources = { "nvim_diagnostic" },
					sections = { "error", "warn" },
					always_visible = true,
				},
				lsp_status,
				{ filetype, fmt = string.upper },
				{ indentation, fmt = string.upper },
				{ file_encoding, fmt = string.upper },
				{ file_format, fmt = string.upper },
				location,
			},
			lualine_y = {},
			lualine_z = {},
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = { filename },
			lualine_x = { filetype },
			lualine_y = {},
			lualine_z = {},
		},
		extensions = {
			"lazy",
			"man",
			"mason",
			"nvim-dap-ui",
			"quickfix",
			"trouble",
		},
	},
	config = function(_, opts)
		local lualine = require("lualine")
		lualine.setup(opts)

		require("legendary").autocmds({
			{
				name = "Lualine",
				clear = true,
				{
					"RecordingEnter",
					function()
						vim.g.lualine_macro_recording = true
						lualine:refresh()
					end,
				},
				{
					"RecordingLeave",
					function()
						vim.g.lualine_macro_recording = false
						lualine:refresh()
					end,
				},
			},
		})
	end,
}
