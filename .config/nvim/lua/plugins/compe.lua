-- Compe setup
require('compe').setup {
	enabled = true;
	autocomplete = true;
	preselect = 'enable';
	min_length = 1,
	documentation = true;
	source = {
		path = true,
		nvim_lsp = true,
		luasnip = true,
		buffer = false,
		calc = false,
		nvim_lua = true,
		vsnip = false,
		ultisnips = false,
		tresitter = true
	},
}

-- Utility functions for compe and luasnip
local t = function(str)
	return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
	local col = vim.fn.col '.' - 1
	if col == 0 or vim.fn.getline('.'):sub(col, col):match '%s' then
		return true
	else
		return false
	end
end
