--Set colorscheme (order is important here)
vim.o.termguicolors = true
vim.g.onedark_terminal_italics = 1
vim.cmd [[colorscheme onedark]]

vim.o.showmode = false

--Set statusbar
vim.g.lightline = {
  colorscheme = 'onedark',
  active = { left = { { 'mode', 'paste' }, { 'gitbranch', 'readonly', 'filename', 'modified' } } },
  component = { filename = '%{expand("%:~:.")}' },
  component_function = { gitbranch = 'fugitive#head' },
}
