-- Save swap files in /tmp
vim.o.swapfile = true
vim.o.directory = '/tmp'

-- Set highlight on search
vim.o.hlsearch = true
vim.o.incsearch = true

vim.o.scrolloff = 8
vim.o.sidescrolloff = 8

-- Make line relative numbers default
vim.wo.number = true
vim.wo.relativenumber = true

-- Enable persistent undo
vim.bo.undofile = true

-- Do not save when switching buffers
vim.o.hidden = true

--Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.showmatch = true
vim.o.matchtime = 10

vim.o.termguicolors = true

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- Nice menu when typing `:find *.py`
vim.g.wildmode = longest,list,full
vim.g.wildmenu = true

-- Ignore files
vim.opt.wildignore:prepend('*_build/*')
vim.opt.wildignore:prepend('**/coverage/*')
vim.opt.wildignore:prepend('**/node_modules/*')
vim.opt.wildignore:prepend('**/android/*')
vim.opt.wildignore:prepend('**/ios/*')
vim.opt.wildignore:prepend('**/.git/*')

vim.g.indent_blankline_show_current_context = true

vim.g.php_manual_online_search_shortcut = '<leader>m'

vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
vim.go.foldlevelstart = 99
