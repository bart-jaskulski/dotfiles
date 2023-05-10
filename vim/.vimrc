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

set nobackup
set noswapfile
set nowritebackup

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

" better ascii friendly listchars
set listchars=lead:*,trail:*,nbsp:*,extends:>,precedes:<,tab:\|>
set list

set path+=**

" Use ripgrep for searching
if executable('rg')
  set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
endif

noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

nnoremap <silent> <leader>x :q<CR>

" Yank consistent with delete or select
map Y y$

au FileType gitcommit,markdown,text setlocal spell
au FileType markdown,text set tw=0
au FileType markdown,text noremap j gj
au FileType markdown,text noremap k gk

" Simply open links with `gx` through lynx in new window
let g:netrw_browsex_viewer= "tmux new-window lynx"
