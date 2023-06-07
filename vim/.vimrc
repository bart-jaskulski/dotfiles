set nocompatible

" Count line numbers from current row
set number
set relativenumber

set ruler

" Show command and insert mode
set showmode

" Use some unified indentation rules
set autoindent
set smartindent
set smarttab
set expandtab
set tabstop=2
set softtabstop=2
" mostly used with >> and <<
set shiftwidth=2

" stop vim from silently messing with files that it shouldn't
set nofixendofline

" set nobackup
" set nowritebackup
" set noswapfile
set directory=~/.vimswap

set textwidth=72
set formatoptions=cq1lmMjp

" Avoid hit enter to continue
set shortmess=aoOtTI

let mapleader = " "

set hlsearch
set incsearch
set linebreak
set ignorecase smartcase
" wrap around when searching
set wrapscan

" stop complaints about switching buffer with changes
set hidden

" faster scrolling
set ttyfast

" don't redraw while executing macros
set lazyredraw

filetype plugin on

" better command-line completion
set wildmenu

syntax on
colorscheme onedark

set scrolloff=8
set clipboard=unnamed
set nocursorline

set colorcolumn=80
set ttimeout
set ttimeoutlen=100

" automatically read a file if changed outside
set autoread
" automatically write files when changing when multiple files open
set autowrite

set rulerformat=%30(%=%#LineNr#%.50f\ [%{strlen(&ft)?&ft:'none'}]\ %l:%c\ %p%%%)

" mark trailing spaces as errors
match IncSearch '\s\+$'

hi Normal ctermbg=NONE

set mouse=a

set display=lastline
set sidescrolloff=5

set complete-=1
" enable omni-completion
set omnifunc=syntaxcomplete#Complete

set showtabline=2

" Don't display chars in TTY
if has_key(environ(), 'DISPLAY')
" better ascii friendly listchars
  set listchars=lead:*,trail:*,nbsp:*,extends:>,precedes:<,tab:\|>
  set list
endif

" {{{NAVIGATION

set path+=**

" Improve netrw
let g:netrw_keepdir = 1
let g:netrw_winsize = 25
let g:netrw_banner = 0
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+' . netrw_gitignore#Hide()
let g:netrw_hide = 1
let g:netrw_localcopydircmdopt = ' -Rr'
let g:netrw_localmkdiropt = ' -p'
let g:netrw_localrmdiropt = ' -p'
" Tree display
let g:netrw_liststyle = 3
let g:netrw_sizestyle = "H"

hi! link netrwMarkFile Search

" Simply open links with `gx` through lynx in new window
let g:netrw_browsex_viewer= "tmux new-window lynx"

" Open explorer in cwd
nnoremap <leader><TAB> :Lexplore %:p:h<CR>

" Add simpler bindings inside netrw
function! NetrwMapping()
  nmap <buffer> H u
  nmap <buffer> h -^
  nmap <buffer> l <CR>

  nmap <buffer> P <C-w>z
  nmap <buffer> L <CR>:Lexplore<CR>
  nmap <buffer> <leader><TAB> :q<CR>
  nmap <buffer> ~ :execute 'edit ' . getcwd()<CR>
endfunction

augroup netrw_mapping
  autocmd!
  autocmd filetype netrw call NetrwMapping()
augroup END

" View all buffers
nnoremap <space><space> :ls<CR> :b <space>

" Use ripgrep for searching
if executable('rg')
  set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
endif

" Trailing space is intended
nnoremap <silent> <leader>fw :lgrep 

" NAVIGATION}}}

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nnoremap <silent> <leader>x :q<CR>

" Yank consistent with delete or select
map Y y$

au FileType gitcommit,markdown,text setlocal spell
au FileType markdown,text set tw=0
au FileType markdown,text noremap j gj
au FileType markdown,text noremap k gk

" Simply open links with `gx` through lynx in new window
let g:netrw_browsex_viewer= "tmux new-window lynx"
