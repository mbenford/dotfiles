local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")

local List = {}

local function new(args)
	args = args or {}

	local container = wibox.widget({
		widget = wibox.container.background,
		bg = args.bg,
		{
			widget = wibox.container.margin,
			margins = args.margins,
			{
				id = "content",
				layout = wibox.layout.align.vertical,
			},
		},
	})
	container:connect_signal("button::press", function(self, x, y, button)
		if button == 4 then
			self:prev_item()
		elseif button == 5 then
			self:next_item()
		end
	end)

	gears.table.crush(container, List)
	gears.table.crush(container._private, {
		layout = args.layout or "vertical",
		cycle = args.cycle or false,
		item_fg = args.item_fg,
		item_bg = args.item_bg,
		item_shape = args.item_shape,
		item_border_color = args.item_border_color or beautiful.border_normal,
		item_border_width = args.item_border_width or 1,
		item_fg_selected = args.item_fg_selected,
		item_bg_selected = args.item_bg_selected,
		item_border_color_selected = args.item_border_color_selected or beautiful.border_normal,
		item_creator = args.item_creator,
		page_size = args.page_size or 5,
		page_indicator_shape = args.page_indicator_shape or gears.shape.rectangle,
		page_indicator_width = args.page_indicator_width or 20,
		page_indicator_height = args.page_indicator_height or 3,
		page_indicator_margin = args.page_indicator_margin or 5,
		page_indicator_spacing = args.page_indicator_spacing or 5,
		page_indicator_bg = args.page_indicator_bg or beautiful.border_normal,
		page_indicator_bg_selected = args.page_indicator_bg_selected or beautiful.border_focus,
		empty_widget = args.empty_widget or wibox.widget({
			widget = wibox.container.place,
			valign = "center",
			halign = "center",
			{
				widget = wibox.widget.textbox,
				text = "No items",
			},
		}),

		count = 0,
		selected_index = 0,
		pages = {},
	})

	if args.items then
		container:set_items(args.items)
	end

	return container
end

function List:set_items(items)
	self:clear()

	if #items == 0 then
		self:_content_widget().second = self._private.empty_widget
		return
	end

	local page_template = {
		spacing = 10,
		layout = wibox.layout.flex[self._private.layout],
	}

	for index, value in ipairs(items) do
		local container = wibox.widget({
			fg = self._private.item_fg,
			bg = self._private.item_bg,
			shape = self._private.item_shape,
			border_color = self._private.item_border_color,
			border_width = self._private.item_border_width,
			widget = wibox.container.background,
			self._private.item_creator(index, value),
		})
		container:connect_signal("mouse::enter", function()
			self:select(index)
		end)

		local page_index = self:_page_index(index)
		if self._private.pages[page_index] == nil then
			self._private.pages[page_index] = wibox.widget(page_template)
		end
		self._private.pages[page_index]:add(container)
	end

	self._private.count = #items
	self:select(1)
end

function List:clear()
	self:_content_widget():reset()
	for _, value in ipairs(self._private.pages) do
		value:reset()
	end
	self._private.pages = {}
	self._private.selected_index = 0
end

function List:next_item()
	self:select(self._private.selected_index + 1)
end

function List:prev_item()
	self:select(self._private.selected_index - 1)
end

function List:prev_page()
	self:select(self._private.selected_index - self._private.page_size)
end

function List:next_page()
	self:select(self._private.selected_index + self._private.page_size)
end

function List:select(index)
	if index < 1 then
		index = self._private.cycle and self._private.count or 1
	elseif index > self._private.count then
		index = self._private.cycle and 1 or self._private.count
	end

	local selected = self:_item_widget(self._private.selected_index)
	if selected then
		gears.table.crush(selected, {
			fg = self._private.item_fg,
			bg = self._private.item_bg,
			border_color = self._private.item_border_color,
		})
	end

	selected = self:_item_widget(index)
	if selected then
		gears.table.crush(selected, {
			fg = self._private.item_fg_selected,
			bg = self._private.item_bg_selected,
			border_color = self._private.item_border_color_selected,
		})
		self:_content_widget().second = self._private.pages[self:_page_index(index)]
		self._private.selected_index = index
		self:_update_page_indicator()
	end
end

function List:selected()
	return self._private.selected_index
end

function List:_content_widget()
	return self:get_children_by_id("content")[1]
end

function List:_item_widget(index)
	local widget_index = index % self._private.page_size
	if widget_index == 0 then
		widget_index = self._private.page_size
	end

	local page = self._private.pages[self:_page_index(index)]
	return page and page.children[widget_index] or nil
end

function List:_page_index(index)
	return math.ceil(index / self._private.page_size)
end

function List:_update_page_indicator()
	if #self._private.pages <= 1 then
		self:_content_widget().third = nil
		return
	end

	local dots = wibox.widget({
		layout = wibox.layout.fixed.horizontal,
		spacing = self._private.page_indicator_spacing,
	})

	local page_index = self:_page_index(self._private.selected_index)
	for i = 1, #self._private.pages do
		dots:add(wibox.widget({
			widget = wibox.container.background,
			shape = gears.shape.rectangle,
			forced_width = self._private.page_indicator_width,
			forced_height = self._private.page_indicator_height,
			bg = i == page_index and self._private.page_indicator_bg_selected or self._private.page_indicator_bg,
		}))
	end

	self:_content_widget().third = wibox.widget({
		widget = wibox.container.margin,
		margins = { top = 5 },
		{
			widget = wibox.container.place,
			valign = "center",
			halign = "center",
			dots,
		},
	})
end

return setmetatable(List, {
	__call = function(_, ...)
		return new(...)
	end,
})
