local M = {
	borders = {
		top_left = '🭽',
		top = '▔',
		top_right = '🭾',
		right = '▕',
		bottom_right = '🭿',
		bottom = '▁',
		bottom_left = '🭼',
		left = '▏',
	}
}
M.border_float = {
	{ M.borders.top_left,},
	{ M.borders.top, },
	{ M.borders.top_right },
	{ M.borders.right },
	{ M.borders.bottom_right },
	{ M.borders.bottom },
	{ M.borders.bottom_left },
	{ M.borders.left },
}
return M
