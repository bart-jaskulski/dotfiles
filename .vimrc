set nocompatible

set autoindent

set autowrite

set number
set relativenumber

set ruler

" Show command and insert mode
set showmode

set tabstop=2

let mapleader = " "

set smartindent

set smarttab

set nobackup
set noswapfile
set nowritebackup

set hlsearch
set incsearch
set linebreak
set ignorecase smartcase

set hidden
set ttyfast

filetype plugin on

map Y y$

set wildmenu

syntax on
colorscheme onedark

set scrolloff=8
set shortmess=aIT
set clipboard=unnamed
set nocursorline

set colorcolumn=80
set ttimeout
set ttimeoutlen=100

set autoread
set autowrite

set background=dark

set rulerformat=%30(%=%#LineNr#%.50f\ [%{strlen(&ft)?&ft:'none'}]\ %l:%c\ %p%%%)

match IncSearch '\s\+$'

set textwidth=72
set hidden

hi Normal ctermbg=NONE

set mouse=a

set display=lastline
set sidescrolloff=5

set complete-=1
set omnifunc=syntaxcomplete#Complete

set showtabline=2

noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

nnoremap <silent> <leader>x :q<CR>
