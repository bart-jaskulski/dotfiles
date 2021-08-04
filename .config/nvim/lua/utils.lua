-- Highlight on yank
vim.api.nvim_exec(
  [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]],
  false
)

vim.api.nvim_exec(
  [[
  augroup NjkSupport
    autocmd BufReadPost *.njk set syntax=html
    autocmd BufReadPost *.njk set filetype=html
  augroup end
]],
  false
)
