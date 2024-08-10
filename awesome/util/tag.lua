local M = {}

function M.tiled_clients(tag)
	local clients = {}
	for _, c in ipairs(tag:clients()) do
		if not c.floating and not c.minimized then
			table.insert(clients, c)
		end
	end
	return clients
end

return M
