require('settings')
require('plugins')
require('ui')
require('keybinds')
require('utils')

require('plugins.symbols')
require('plugins.lsp')
require('plugins.compe')
require('plugins.luasnip')
require('plugins.tresitter')

--Incremental live completion
vim.o.inccommand = 'nosplit'

--Enable mouse mode
vim.o.mouse = 'a'

--Enable break indent
vim.o.breakindent = true

--Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'

--Map blankline
vim.g.indent_blankline_char = '┊'
vim.g.indent_blankline_filetype_exclude = { 'help', 'packer' }
vim.g.indent_blankline_buftype_exclude = { 'terminal', 'nofile' }
vim.g.indent_blankline_char_highlight = 'LineNr'
vim.g.indent_blankline_show_trailing_blankline_indent = false

-- Telescope
-- require('telescope').setup {
--   defaults = {
--     mappings = {
--       i = {
--         ['<C-u>'] = false,
--         ['<C-d>'] = false,
--       },
--     },
--   },
-- }

