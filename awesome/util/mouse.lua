local api = { mouse = mouse }

local M = {}

function M.move_to_screen(screen)
	local geometry = screen.geometry
	api.mouse.coords({
		x = geometry.x + geometry.width / 2,
		y = geometry.y + geometry.height / 2,
		silent = true,
	})
end

function M.move_to_client(client)
	api.mouse.coords({
		x = client.x + client.width / 2,
		y = client.y + client.height / 2,
		silent = true,
	})
end

return M
