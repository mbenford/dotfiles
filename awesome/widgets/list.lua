local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")

local List = {}

function List:set_items(items)
	self:clear()
	if #items == 0 then
		self.widget = self._private.empty_widget
		return
	end

	local page_template = {
		spacing = 10,
		layout = wibox.layout.flex[self._private.layout],
	}

	for index, value in ipairs(items) do
		local container = wibox.widget({
			id = "background_role",
			fg = self._private.item_fg,
			bg = self._private.item_bg,
			shape = self._private.item_shape,
			border_color = self._private.item_border_color,
			border_width = self._private.item_border_width,
			widget = wibox.container.background,
		})
		container:set_widget(self._private.item_creator(index, value))

		local page_index = self:_get_page_index(index)
		if self._private.pages[page_index] == nil then
			self._private.pages[page_index] = wibox.widget(page_template)
		end
		self._private.pages[page_index]:add(container)
	end

	self._private.count = #items
	self:select(1)
end

function List:clear()
	for _, value in ipairs(self._private.pages) do
		value:reset()
	end
	self._private.pages = {}
	self._private.selected_index = 0
end

function List:select_next()
	self:select(self._private.selected_index + 1)
end

function List:select_prev()
	self:select(self._private.selected_index - 1)
end

function List:select(index)
	if index < 1 then
		index = 1
	elseif index > self._private.count then
		index = self._private.count
	end

	local selected = self:_get_item_widget(self._private.selected_index)
	if selected then
		gears.table.crush(selected, {
			fg = self._private.item_fg,
			bg = self._private.item_bg,
			border_color = self._private.item_border_color,
		})
	end

	selected = self:_get_item_widget(index)
	if selected then
		gears.table.crush(selected, {
			fg = self._private.item_fg_selected,
			bg = self._private.item_bg_selected,
			border_color = self._private.item_border_color_selected,
		})
		self.widget = self._private.pages[self:_get_page_index(index)]
		self._private.selected_index = index
	end
end

function List:start_selection()
	local grabber = awful.keygrabber({
		keypressed_callback = function(grabber, mod, key)
			if key == "h" then
				self:select(self._private.selected_index - self._private.page_size)
				return
			end

			if key == "l" then
				self:select(self._private.selected_index + self._private.page_size)
				return
			end

			if key == "j" then
				self:select_next()
				return
			end

			if key == "k" then
				self:select_prev()
				return
			end

			if key == "Return" then
				grabber:stop()
				self:emit_signal("selection::confirmed", self._private.selected_index)
				return
			end

			if key == "Escape" then
				grabber:stop()
				self:emit_signal("selection::stopped")
				return
			end

			self:emit_signal("selection::keypressed", grabber, mod, key, self._private.selected_index)
		end,
	})
	grabber:start()
end

function List:_get_item_widget(index)
	local widget_index = index % self._private.page_size
	if widget_index == 0 then
		widget_index = self._private.page_size
	end

	local page = self._private.pages[self:_get_page_index(index)]
	return page and page.children[widget_index] or nil
end

function List:_get_page_index(index)
	return math.ceil(index / self._private.page_size)
end

local function new(args)
	args = args or {}

	local container = wibox.container.background()
	gears.table.crush(container, List)
	container.bg = args.bg or beautiful.bg_normal

	gears.table.crush(container._private, {
		layout = args.layout or "vertical",
		item_fg = args.item_fg or beautiful.fg_normal,
		item_bg = args.item_bg or beautiful.bg_normal,
		item_shape = args.item_shape,
		item_border_color = args.item_border_color or beautiful.notification_border_color,
		item_border_width = args.item_border_width or 1,
		item_fg_selected = args.item_fg_selected,
		item_bg_selected = args.item_bg_selected,
		item_border_color_selected = args.item_border_color_selected or beautiful.notification_border_color_selected,
		item_creator = args.item_creator,
		page_size = args.page_size or 5,

		count = 0,
		selected_index = 0,
		pages = {},
		empty_widget = args.empty_widget or {
			widget = wibox.container.place,
			valign = "center",
			halign = "center",
			{
				widget = wibox.widget.textbox,
				text = "No items",
			},
		},
	})

	if args.items then
		container:set_items(args.items)
	end

	return container
end

return setmetatable(List, {
	__call = function(_, ...)
		return new(...)
	end,
})
