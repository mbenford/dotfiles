local wibox = require("wibox")

return function(...)
	local container = wibox.widget({
		layout = wibox.layout.fixed.horizontal,
		spacing = 10,
	})

	for i, widget in ipairs({ ... }) do
		widget.indicator = { index = i, visible = widget.visible }
		if widget.indicator.visible then
			container:add(widget)
		end

		widget:connect_signal("widget::layout_changed", function(self)
			if self.visible and not self.indicator.visible then
				self.indicator.visible = true
				container:insert(self.indicator.index, self)
			elseif not self.visible and self.indicator.visible then
				self.indicator.visible = false
				container:remove(self.indicator.index)
			end
		end)
	end

	return container
end
