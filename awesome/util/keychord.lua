local awful = require("awful")

return function(keys)
	local grabber = awful.keygrabber({
		timeout = 5,
		keypressed_callback = function(grabber, mod, key)
			grabber:stop()

			if keys[key] ~= nil then
				keys[key]()
			end
		end,
	})

	return function()
		grabber:start()
	end
end
