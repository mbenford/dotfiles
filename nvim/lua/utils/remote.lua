local M = {}

function M.connected_clients()
	local channels = vim.tbl_filter(function(chan)
		return chan.stream == "socket"
	end, vim.api.nvim_list_chans())

	return vim.tbl_map(function(chan)
		return chan.client
	end, channels)
end

function M.detach_or_quit()
	if #M.connected_clients() == 0 then
		vim.cmd.qall()
		return
	end

	local choice = vim.fn.confirm("A client is connected to this Neovim instance", "&Detach\n&Quit")
	if choice == 1 then
		vim.cmd.detach()
	elseif choice == 2 then
		vim.cmd.qall()
	end
end

return M
