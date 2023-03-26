local awful = require("awful")

local function get_steps()
	local geometry = awful.screen.focused().geometry
	return math.ceil(geometry.width / 5), math.ceil(geometry.height / 5)
end

local M = {}

function M.move_up(client)
	local _, sy = get_steps()
	M.place(client, client.x, client.y - sy)
end

function M.move_down(client)
	local _, sy = get_steps()
	M.place(client, client.x, client.y + sy)
end

function M.move_left(client)
	local sx, _ = get_steps()
	M.place(client, client.x - sx, client.y)
end

function M.move_right(client)
	local sx, _ = get_steps()
	M.place(client, client.x + sx, client.y)
end

function M.center(client)
	if not client.floating then
		return
	end
	awful.placement.centered(client)
end

function M.place(client, x, y)
	if not client.floating then
		return
	end
	client.x = x
	client.y = y
	awful.placement.no_offscreen(client)
end

return M
