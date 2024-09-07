local widgets = {
	"clock",
	"distro",
	"hardware",
	"layout",
	"list",
	"notification",
	"pulseaudio",
	"systray",
	"taglist",
	"tasklist",
	"util",
	"vpn",
	"wifi",
	"window",
}

local modules = {}
for _, name in ipairs(widgets) do
	modules[name] = require("widgets." .. name)
end
return modules
