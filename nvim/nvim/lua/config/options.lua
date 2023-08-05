vim.g.mapleader = ' '

-- Count line numbers from current row
vim.opt.number = true
vim.opt.relativenumber = true

-- Display any signs over numbers
vim.opt.signcolumn = "yes"

-- Show command and insert mode
vim.opt.showmode = true

vim.opt.history = 10000

vim.opt.sessionoptions:remove { 'blank', 'buffers', 'folds', 'help', 'terminal' }

-- Use some unified indentation rules
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
-- mostly used with >> and <<
vim.opt.shiftwidth = 2

-- If folds are enabled, leave some of them closed
vim.opt.foldlevel=999
vim.opt.foldmethod='expr'
vim.opt.foldnestmax=2
vim.opt.foldminlines=5
vim.opt.foldexpr='nvim_treesitter#foldexpr()'

-- stop vim from silently messing with files that it shouldn't
vim.opt.fixendofline = false

-- set nobackup
-- set nowritebackup
-- set noswapfile
-- vim.opt.directory='~/.vimswap'

vim.opt.textwidth=72
vim.opt.formatoptions='cq1lmMjp'

-- Avoid hit enter to continue
vim.opt.shortmess = {
  a = true, -- use abbreviation
  o = true, -- use abbreviation
  O = true, -- use abbreviation
  s = true, S = true, -- search info is on statusline
  t = true, -- truncate messages
  T = true, -- truncate messages
  I = true, -- hide info page
  W = true, -- don't care about written
  F = true, -- don't care file info
}

vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.linebreak = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
-- wrap around when searching
vim.opt.wrapscan = true

-- stop complaints about switching buffer with changes
vim.opt.hidden = true

-- faster scrolling
vim.opt.ttyfast = true

-- don't redraw while executing macros
vim.opt.lazyredraw = true

-- better command-line completion
vim.opt.wildmenu = true

vim.opt.scrolloff=8
vim.opt.clipboard='unnamed'
vim.opt.cursorline = true

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.colorcolumn='80'
vim.opt.ttimeout = true
vim.opt.ttimeoutlen=100

-- automatically read a file if changed outside
vim.opt.autoread = true
-- automatically write files when changing when multiple files open
vim.opt.autowrite = true

vim.opt.mouse='a'

vim.opt.display='lastline'
vim.opt.sidescrolloff=3

vim.opt.complete:remove { 't' ,'i' }
vim.opt.completeopt = { 'menuone', 'noinsert', 'noselect' }
vim.opt.wildmode='longest:full'

-- Show tab line only if there are 2+ tabs
vim.opt.showtabline = 1

vim.opt.path:prepend { 'src/**', 'assets/**' }

-- Display status line only for the last window
vim.opt.laststatus = 2
vim.opt.cmdheight = 1
-- vim.opt.statusline = "%!v:lua.require'statusline'.run()"
-- vim.opt.statusline = "%F %y %=%l:%c %p%%"

if os.getenv('DISPLAY') ~= nil then
  vim.opt.termguicolors = true
  vim.opt.background = 'light'
  -- display hidden chars only in TTY
  -- better ascii friendly listchars
  vim.opt.listchars = {
    lead = '*', trail = '*', tab = '|>',
    extends = '…', precedes = '…', nbsp = '␣'
  }
  vim.opt.list = true
  vim.opt.pumblend=10
  vim.opt.pumheight=10
  vim.opt.winblend=10
else
  vim.opt.background = 'dark'
end

-- Use ripgrep for searching
if vim.fn.executable('rg') == 1 then
  vim.opt.grepprg='rg --vimgrep --no-heading --smart-case'
end

-- Disable unnecessary providers
vim.g.loaded_python3_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
