local awful = require("awful")
local fs = require("gears.filesystem")
local naughty = require("naughty")

local filename = fs.get_xdg_config_home() .. 'autorun.sh'
if fs.file_executable(filename) then
  awful.spawn.with_shell(filename)
else
  naughty.notify({ title = "AwesomeWM", text = filename .. " not found" })
end
