local lazy = require("utils.lazy")
local autocmd = vim.api.nvim_create_autocmd
local group = vim.api.nvim_create_augroup("Custom", { clear = true })

-- Saves all modified buffers when Neovim loses focus
autocmd("FocusLost", {
	group = group,
	command = "silent! wa",
})

-- Creates a highlight effect when text is yanked (copied)
autocmd("TextYankPost", {
	group = group,
	callback = lazy(vim.hl.on_yank, { higroup = "TextYank", timeout = 200 }),
})

-- Adds a buffer-local keybinding 'q' to close some windows based on their file type
autocmd("FileType", {
	group = group,
	pattern = { "help", "qf", "vim", "checkhealth", "man" },
	callback = function(event)
		require("which-key").add({ "q", "<C-w>q", buffer = event.buf, desc = "Close window" })
	end,
})

-- Opens help files in a floating window
autocmd("BufWinEnter", {
	group = group,
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

-- Stops insert mode when Snacks input is shown as has any content (eg: LSP rename)
autocmd("BufWinEnter", {
	group = group,
	callback = function(event)
		local filetype = vim.bo[event.buf].filetype
		if filetype ~= "snacks_input" then
			return
		end

		vim.schedule(function()
			local line_count = vim.api.nvim_buf_line_count(event.buf)
			local has_content = line_count > 1 or vim.api.nvim_buf_get_lines(event.buf, 0, 1, false)[1] ~= ""
			if not has_content then
				return
			end

			vim.cmd.stopinsert()
			vim.cmd.normal("0")
		end)
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

autocmd("User", {
	pattern = "MiniFilesActionRename",
	callback = function(event)
		if Snacks then
			Snacks.rename.on_rename_file(event.data.from, event.data.to)
		end
	end,
})

-- local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
-- autocmd("User", {
-- 	pattern = "CodeCompanion*",
-- 	group = group,
-- 	callback = function(request)
-- 		local event = request.match:gsub("CodeCompanion", "")
-- 		if event ~= "RequestStarted" or event == "RequestFinished" then
-- 			return
-- 		end
--
-- 		vim.notify("Thinking...", "info", {
-- 			id = "code_companion_status",
-- 			title = "Code Companion",
-- 			history = false,
-- 			keep = function()
-- 				return event ~= "RequestFinished"
-- 			end,
-- 			opts = function(notif)
-- 				notif.icon = ""
-- 				if vim.endswith(event, "Started") then
-- 					---@diagnostic disable-next-line: undefined-field
-- 					notif.icon = spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
-- 				elseif vim.endswith(event, "Finished") then
-- 					notif.icon = " "
-- 				end
-- 			end,
-- 		})
-- 	end,
-- })

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
