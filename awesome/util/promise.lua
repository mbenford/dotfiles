local gears = require("gears")

local Promise = {}
Promise.__index = Promise

function Promise:resolve(value)
	if self.state == "pending" then
		self.state = "resolved"
		self.value = value
		gears.timer.delayed_call(self.callback)
	end
end

function Promise:next(cb)
	local next = Promise.new()
	local callback = function()
		local result = cb(self.value)
		if getmetatable(result) == Promise then
			result:next(function(value)
				next:resolve(value)
			end)
		else
			next:resolve(result)
		end
	end

	if self.state == "pending" then
		self.callback = callback
	elseif self.state == "resolved" then
		gears.timer.delayed_call(callback)
	end

	return next
end

function Promise.new()
	local self = {
		callback = nil,
		state = "pending",
		value = nil,
	}
	return setmetatable(self, Promise)
end

function Promise.all(...)
	local promises = { ... }
	local values = {}
	local result = Promise.new()

	for _, p in ipairs(promises) do
		p:next(function(value)
			table.insert(values, value)
			if #values == #promises then
				result:resolve(values)
			end
		end)
	end

	return result
end

return Promise
