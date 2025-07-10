local api = { awesome = awesome, screen = screen }
local wibox = require("wibox")
api.awesome.register_xproperty("awesomewm_popup_backdrop", "boolean")

local backdrops = {}

for s in api.screen do
	local backdrop = wibox({
		visible = false,
		ontop = true,
		screen = s,
		type = "splash",
		width = s.geometry.width,
		height = s.geometry.height,
		x = s.geometry.x,
		y = s.geometry.y,
	})
	backdrop:set_xproperty("awesomewm_popup_backdrop", true)
	table.insert(backdrops, backdrop)
end

local function show(opts)
	opts = opts or { bg = "#000000", opacity = 0.8 }
	for _, backdrop in ipairs(backdrops) do
		backdrop.bg = opts.bg .. string.format("%02x", math.floor(opts.opacity * 255))
		backdrop.visible = true
	end
end

local function hide()
	for _, backdrop in ipairs(backdrops) do
		backdrop.visible = false
	end
end

return {
	show = show,
	hide = hide,
}
