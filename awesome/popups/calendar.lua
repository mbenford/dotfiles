local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local stringx = require("pl.stringx")
local Popup = require("util.popup")
local fn = require("util.fn")
local ez = require("util.ez")

local styles = {
	weekday = {
		fg = beautiful.calendar_weekday_fg,
	},
	weekday_weekend = {
		fg = beautiful.calendar_weekend_fg,
	},
	header = {
		fg = beautiful.calendar_header_fg,
	},
	focus = {
		fg = beautiful.calendar_focus_fg,
		border_width = 2,
		border_color = beautiful.calendar_focus_fg,
		format = fn.bind(string.format, "<b>%s</b>"),
	},
	month = {
		fg = beautiful.calendar_month_fg,
	},
	normal = {
		fg = beautiful.calendar_normal_fg,
		bg = beautiful.calendar_day_border_color,
		border_width = 1,
		border_color = beautiful.calendar_day_border_color,
	},
	normal_weekend = {
		fg = beautiful.calendar_weekend_fg,
		bg = beautiful.calendar_day_border_color,
		border_width = 1,
		border_color = beautiful.calendar_day_border_color,
	},
}

local calendar = wibox.widget({
	widget = wibox.widget.calendar.month,
	start_sunday = true,
	long_weekdays = true,
	font = beautiful.calendar_font,
	flex_height = true,
	spacing = 5,
	fn_embed = function(widget, flag, date)
		if flag == "normal" or flag == "weekday" then
			local weekday = tonumber(os.date("%w", os.time(date)))
			if weekday == 0 or weekday == 6 then
				flag = flag .. "_weekend"
			end
		end

		local style = styles[flag] or styles.normal

		if widget.text ~= nil then
			widget.text = stringx.strip(widget.text)
			widget.halign = "center"
		end

		if style.format then
			widget.markup = style.format(widget.text)
		end

		return wibox.widget({
			widget = wibox.container.background,
			fg = style.fg,
			border_color = style.border_color,
			border_width = style.border_width,
			shape = fn.bind_right(require("gears.shape").rounded_rect, 5),
			{
				widget = wibox.container.margin,
				margins = 5,
				widget,
			},
		})
	end,
})

local popup = Popup({
	placement = function(c)
		awful.placement.top_right(c, { honor_workarea = true })
	end,
	ontop = true,
	border_color = beautiful.popup_border_color,
	border_width = beautiful.popup_border_width,
	widget = {
		widget = wibox.container.margin,
		margins = { bottom = 10, left = 10, right = 10 },
		forced_width = 400,
		forced_height = 300,
		calendar,
	},
})
popup:xprops({
	position = "right",
})
popup:keygrabber({
	timeout = 60,
	keybindings = ez.keys({
		["h"] = function()
			calendar.date.month = calendar.date.month - 1
			calendar.date = os.date("*t", os.time(calendar.date))
		end,
		["l"] = function()
			calendar.date.month = calendar.date.month + 1
			calendar.date = os.date("*t", os.time(calendar.date))
		end,
		["j"] = function()
			calendar.date.year = calendar.date.year + 1
			calendar.date = os.date("*t", os.time(calendar.date))
		end,
		["k"] = function()
			calendar.date.year = calendar.date.year - 1
			calendar.date = os.date("*t", os.time(calendar.date))
		end,
		["t"] = function()
			calendar.date = os.date("*t")
		end,
	}),
})

return {
	show = function()
		calendar.date = os.date("*t")
		popup:show({ screen = screen.primary })
	end,
}
