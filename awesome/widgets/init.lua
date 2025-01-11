local widgets = {
	"audio",
	"clock",
	"distro",
	"hardware",
	"indicators",
	"list",
	"network",
	"notification",
	"systray",
	"tags",
	"util",
	"vpn",
	"window",
}

local modules = {}
for _, name in ipairs(widgets) do
	modules[name] = require("widgets." .. name)
end
return modules
