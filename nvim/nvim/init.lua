vim.loader.enable()
require'config'

vim.cmd[[
packadd! matchit
packadd! cfilter

" mark trailing spaces as errors
match IncSearch '\s\+$'

inoremap <script><silent><nowait><expr> <Tab> pumvisible() ? "\<C-y>" : codeium#Accept()

hi SpellBad font='Monospace 9' gui=underline guifg=#d1242f guibg=none
]]
