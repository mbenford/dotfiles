local Lazy = setmetatable({}, {
	__call = function(_, fn, ...)
		local args = { ... }
		return function()
			return fn(unpack(args))
		end
	end,
})

function Lazy.require(module_name, fn_name, ...)
	local args = { ... }
	return function()
		local fn = require(module_name)[fn_name]
		return fn(unpack(args))
	end
end

return Lazy
