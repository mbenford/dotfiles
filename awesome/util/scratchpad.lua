local awful = require("awful")
local ruled = require("ruled")

local api = { client = client }

local function get_width(value)
	return value > 1 and value or math.ceil(awful.screen.focused().workarea.width * value)
end

local function get_height(value)
	return value > 1 and value or math.ceil(awful.screen.focused().workarea.height * value)
end

local function show_client(sp)
	sp.client:move_to_tag(awful.screen.focused().selected_tag)
	sp.client:activate({ context = "unminimize", raise = true })
	sp.client:geometry({ width = get_width(sp.width), height = get_height(sp.height) })
	sp.placement(sp.client)
end

awful.client.property.persist("scratchpad_id", "string")
local M = { scratchpads = {} }

function M.register(name, opts)
	M.scratchpads[name] = {
		id = name,
		client = nil,
		command = opts.command,
		rule = opts.rule,
		placement = (opts.placement or awful.placement.centered) + awful.placement.no_offscreen,
		width = opts.width,
		height = opts.height,
		skip_taskbar = true,
		floating = true,
	}
end

function M.toggle(name)
	local sp = M.scratchpads[name]

	if sp.client == nil then
		awful.spawn(sp.command)
		ruled.client.append_rule({
			id = "sp_" .. sp.id,
			rule = sp.rule,
			callback = function(client)
				sp.client = client
				ruled.client.remove_rule("sp_" .. sp.id)
				show_client(sp)
			end,
			properties = {
				scratchpad_id = sp.id,
				placement = sp.placement,
				width = get_width(sp.width),
				height = get_height(sp.height),
				floating = true,
				skip_taskbar = true,
			},
		})
		return
	end

	sp.client.hidden = not sp.client.hidden
	if not sp.client.hidden then
		show_client(sp)
	end
end

api.client.connect_signal("request::manage", function(client)
	local scratchpad = M.scratchpads[client.scratchpad_id]
	if scratchpad and scratchpad.client == nil then
		client.hidden = true
		scratchpad.client = client
	end
end)

api.client.connect_signal("request::unmanage", function(client)
	local scratchpad = M.scratchpads[client.scratchpad_id]
	if scratchpad and scratchpad.client ~= nil then
		scratchpad.client = nil
	end
end)

api.client.connect_signal("unfocus", function(client)
	if client.scratchpad_id ~= "" then
		client:tags({})
		client.hidden = true
	end
end)

return M
