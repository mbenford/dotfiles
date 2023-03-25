local M = {}

M.borders = {
	top_left = '🭽',
	top = '▔',
	top_right = '🭾',
	right = '▕',
	bottom_right = '🭿',
	bottom = '▁',
	bottom_left = '🭼',
	left = '▏',
}

M.border_float = {
	{ M.borders.top_left },
	{ M.borders.top },
	{ M.borders.top_right },
	{ M.borders.right },
	{ M.borders.bottom_right },
	{ M.borders.bottom },
	{ M.borders.bottom_left },
	{ M.borders.left },
}

M.lsp_icons = {
	Array = '  ',
	Boolean = '  ',
	Class = ' ',
	Color = ' ',
	Constant = ' ',
	Constructor = ' ',
	Enum = ' ',
	EnumMember = ' ',
	Event = ' ',
	Field = ' ',
	File = ' ',
	Folder = ' ',
	Function = ' ',
	Interface = ' ',
	Keyword = ' ',
	Method = ' ',
	Module = ' ',
	Namespace = '  ',
	Null = '  ',
	Number = '  ',
	Object = '  ',
	Operator = ' ',
	Package = '  ',
	Property = ' ',
	Reference = ' ',
	Snippet = ' ',
	String = '  ',
	Struct = ' ',
	Text = ' ',
	TypeParameter = ' ',
	Unit = ' ',
	Value = ' ',
	Variable = ' ',
}

return M
