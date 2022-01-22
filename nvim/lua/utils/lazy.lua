return function(triggers, plugins)
	for name, value in pairs(triggers) do
		for _, p in pairs(plugins) do
			p[name] = value
		end
	end
end
