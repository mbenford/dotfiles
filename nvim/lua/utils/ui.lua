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
	{ M.borders.top_left, 'FloatBorder' },
	{ M.borders.top, 'FloatBorder' },
	{ M.borders.top_right, 'FloatBorder' },
	{ M.borders.right, 'FloatBorder' },
	{ M.borders.bottom_right, 'FloatBorder' },
	{ M.borders.bottom, 'FloatBorder' },
	{ M.borders.bottom_left, 'FloatBorder' },
	{ M.borders.left, 'FloatBorder' },
}
return M
