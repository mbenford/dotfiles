local lazy = require("utils.lazy")
local autocmd = vim.api.nvim_create_autocmd
local group = vim.api.nvim_create_augroup("Custom", { clear = true })

-- Saves all modified buffers when Neovim loses focus
autocmd("FocusLost", {
	group = group,
	command = "silent! wa",
})

-- Resizes splits when the Neovim window is resized
autocmd("VimResized", {
	group = group,
	command = "wincmd =",
})

-- Creates a highlight effect when text is yanked (copied)
autocmd("TextYankPost", {
	group = group,
	callback = lazy(vim.hl.on_yank, { higroup = "TextYank", timeout = 200 }),
})

-- Adds a buffer-local keybinding 'q' to close some windows based on their file type
autocmd("FileType", {
	group = group,
	pattern = { "help", "qf", "vim", "checkhealth" },
	callback = function(event)
		require("which-key").add({ "x", "<C-w>q", buffer = event.buf, desc = "Close window" })
	end,
})

-- Opens help files in a floating window
autocmd("BufWinEnter", {
	group = group,
	pattern = "*",
	callback = function(event)
		local filetype = vim.bo[event.buf].filetype
		local file_path = event.match

		if file_path:match("/doc/") == nil then
			return
		end

		if filetype ~= "help" and filetype ~= "man" and filetype ~= "markdown" then
			return
		end

		local curr_win = vim.api.nvim_get_current_win()
		vim.api.nvim_win_close(curr_win, false)

		local win = require("snacks").win.new({
			buf = event.buf,
			border = "rounded",
			width = 120,
			backdrop = false,
			title = " HELP ",
			title_pos = "center",
			footer = string.format(" %s ", vim.fn.fnamemodify(file_path, ":~")),
			footer_pos = "center",
			wo = {
				wrap = true,
			},
		})
		win:add_padding()
		win:update()
		autocmd("WinEnter", {
			group = win.augroup,
			callback = function()
				win:close()
			end,
		})
	end,
})

-- Updates the Snacks dashboard when the working directory changes
autocmd("DirChanged", {
	group = group,
	callback = function()
		if Snacks then
			Snacks.dashboard.update()
		end
	end,
})

vim.g.extract_frontmatter = function()
	local buf = vim.api.nvim_get_current_buf()
	local ts = vim.treesitter

	local md_parser = ts.get_parser(buf, "markdown")
	if md_parser == nil then
		return
	end

	local frontmatter_node = nil
	local md_tree = md_parser:parse()[1]
	local md_query = ts.query.parse("markdown", [[ ((minus_metadata) @frontmatter) ]])
	for md_id, md_node in md_query:iter_captures(md_tree:root(), buf, 0, -1) do
		if md_query.captures[md_id] == "frontmatter" then
			frontmatter_node = md_node
			break
		end
	end

	if not frontmatter_node then
		return
	end

	local range = { frontmatter_node:range() }

	local yml_parser = ts.get_parser(buf, "yaml")
	local yml_tree = yml_parser:parse()[1]
	local yml_query = ts.query.parse("yaml", [[ ((block_mapping) @document) ]])
	for yml_id, yml_node in yml_query:iter_captures(yml_tree:root(), buf, range[1], range[3]) do
		if yml_query.captures[yml_id] == "document" then
			for child, name in yml_node:iter_children() do
				local key = ts.get_node_text(child:field("key")[1], buf)

				if key == "modified" then
					local node_range = { child:field("value")[1]:range() }
					vim.api.nvim_buf_set_text(
						buf,
						node_range[1],
						node_range[2],
						node_range[3],
						node_range[4],
						{ tostring(os.date("%Y-%m-%d %H:%M:%S")) }
					)
				end
			end
		end
	end
end
