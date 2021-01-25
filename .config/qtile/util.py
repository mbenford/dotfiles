import os

def get_displays():
	displays = os.popen(
		"xrandr | grep -E '\sconnected\s(primary|[0-9])'"
	).read()[:-1].split("\n")
	return len(displays)
