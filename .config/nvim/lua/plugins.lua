-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone --depth 10 https://github.com/wbthomason/packer.nvim ' .. install_path)
end

-- vim.api.nvim_exec(
--   [[
--   augroup Packer
--     autocmd!
--     autocmd BufWritePost init.lua PackerCompile
--   augroup end
-- ]],
--   false
-- )

local use = require('packer').use
require('packer').startup(function()
  use 'wbthomason/packer.nvim' -- Package manager
  use 'tpope/vim-fugitive' -- Git commands in nvim
  -- use 'tpope/vim-rhubarb' -- Fugitive-companion to interact with github
  use 'tpope/vim-commentary' -- "gc" to comment visual regions/lines
  use 'tpope/vim-surround'
  -- use 'ludovicchabant/vim-gutentags' -- Automatic tags management
  -- UI to select things (files, grep results, open buffers...)
  use { 'nvim-telescope/telescope.nvim', cmd = { 'Telescope' }, requires = { { 'nvim-lua/popup.nvim' }, { 'nvim-lua/plenary.nvim' } } }
  use 'joshdick/onedark.vim' -- Theme inspired by Atom
  use 'itchyny/lightline.vim' -- Fancier statusline
  -- Add indentation guides even on blank lines
  use 'lukas-reineke/indent-blankline.nvim'
  -- Highlight, edit, and navigate code using a fast incremental parsing library
  use { 'nvim-treesitter/nvim-treesitter' }
  -- Additional textobjects for treesitter
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use 'neovim/nvim-lspconfig' -- Collection of configurations for built-in LSP client
  use { 'hrsh7th/nvim-compe', wants = "LuaSnip" } -- Autocompletion plugin
  use 'L3MON4D3/LuaSnip' -- Snippets plugin
  -- Better navidation with NvimTree
  use { 'kyazdani42/nvim-tree.lua', cmd = "NvimTreeToggle" }
  use 'kyazdani42/nvim-web-devicons'
  -- Outline
  use { 'simrat39/symbols-outline.nvim', cmd = "SymbolsOutline" }
  -- Enter distraction free mode
  use 'junegunn/goyo.vim'
  use 'junegunn/limelight.vim'

  use 'Pocco81/AutoSave.nvim'
  use { 'windwp/nvim-autopairs' }
  -- Ensure files consistency
  use 'editorconfig/editorconfig-vim'
  -- Code quality check with maker
  use { 'neomake/neomake', ft = { 'php', 'lua', 'javascript', 'javascript.jsx', 'typescript', 'css', 'html' } }
  -- PHP related plugins
  use { 'alvan/vim-php-manual', ft = { 'php' } }
  use { 'phpactor/phpactor', ft = { 'php' }, run = function() vim.fn['phpactor#Update()'](0) end }
end)


vim.api.nvim_command('autocmd! User GoyoEnter Limelight')
vim.api.nvim_command('autocmd! User GoyoLeave Limelight!')

-- vim.api.nvim_command('call neomake#configure#automake("nrwi", 500)')

require('nvim-autopairs').setup()
