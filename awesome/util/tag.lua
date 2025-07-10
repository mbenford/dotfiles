local api = { screen = screen, client = client }
local awful = require("awful")

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

function M.visible_clients(tag)
	local clients = {}
	for _, c in ipairs(tag:clients()) do
		if not c.minimized and not c.hidden then
			table.insert(clients, c)
		end
	end
	return clients
end

function M.view(tag_name)
	return function()
		local tag = awful.tag.find_by_name(nil, tag_name)
		if tag then
			awful.screen.focus(tag.screen)
			tag:view_only()
		end
	end
end

function M.bind(fn)
	return function()
		local client = api.client.focus
		if client == nil then
			return
		end

		local tag = client.screen.selected_tag
		if tag then
			fn(tag, client)
		end
	end
end

return M
