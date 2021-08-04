local function map(mode, key, command, opts)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, key, command, options)
end

--Remap space as leader key
map('', '<Space>', '<Nop>')
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Y yank until the end of line
map('n', 'Y', 'y$')

map('n', '<C-h>', ':noh<CR>')
-- NvimTree
map('n', '<C-\\>', ':NvimTreeToggle<CR>')

-- comment
map('n', '<leader>/', ':Commentary<CR>')
map('v', '<leader>/', ':Commentary<CR>')

-- outline
map('n', '<M-7>', ':SymbolsOutline<CR>')

-- Telescope
map('n', '<leader><space>', [[<cmd>lua require('telescope.builtin').buffers()<CR>]])
map('n', '<leader>ff', [[<cmd>lua require('telescope.builtin').find_files({previewer = false})<CR>]])
map('n', '<leader>sb', [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>]])
map('n', '<leader>sh', [[<cmd>lua require('telescope.builtin').help_tags()<CR>]])
map('n', '<leader>st', [[<cmd>lua require('telescope.builtin').tags()<CR>]])
map('n', '<leader>sd', [[<cmd>lua require('telescope.builtin').grep_string()<CR>]])
map('n', '<C-N>', [[<cmd>lua require('telescope.builtin').live_grep()<CR>]])
map('n', '<leader>so', [[<cmd>lua require('telescope.builtin').tags{ only_current_buffer = true }<CR>]])
map('n', '<leader>?', [[<cmd>lua require('telescope.builtin').oldfiles()<CR>]])

map('v', 'K', ":m '<-2<CR>gv=gv")
map('v', 'J', ":m '>+1<CR>gv=gv")

-- Copy to clipboard
map('v', '<leader>y', '"+y')
map('n', '<leader>y', '"+y')
map('n', '<leader>Y', 'gg"+yG')

--Remap for dealing with word wrap
map('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true })
map('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true })

-- Search and replace
map('n', 'cn', '*``cgn')
map('n', 'cN', '*``cgN')

-- Keep center when going through search or joining lines
map('n', 'n', 'nzzzv')
map('n', 'N', 'Nzzzv')
map('n', 'J', 'mzJ`z')

-- Map tab to the above tab complete functiones
map('i', '<Tab>', 'v:lua.tab_complete()', { expr = true })
map('s', '<Tab>', 'v:lua.tab_complete()', { expr = true })
map('i', '<S-Tab>', 'v:lua.s_tab_complete()', { expr = true })
map('s', '<S-Tab>', 'v:lua.s_tab_complete()', { expr = true })

map('i', '<C-E>', 'v:lua.change_choice()', { expr = true })
map('s', '<C-E>', 'v:lua.change_choice()', { expr = true })

-- Map compe confirm and complete functions
map('i', '<cr>', 'compe#confirm(luaeval("require \'nvim-autopairs\'.autopairs_cr() "))', { expr = true })
map('i', '<c-space>', 'compe#complete()', { expr = true })

-- Undo breakpoints for stream of text
map('i', ',', ',<c-g>u')
map('i', '.', '.<c-g>u')
map('i', '!', '!<c-g>u')
map('i', '{', '{<c-g>u')
map('i', '?', '?<c-g>u')
