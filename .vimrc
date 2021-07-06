" Colemak keyboard tweaks.
" function! Colemak()
"   nnoremap l u
"
"   " right hand nav
"   nnoremap n j
"   vnoremap n j
"   nnoremap e k
"   vnoremap e k
"   nnoremap i l
"   vnoremap i l
"   nnoremap k n
"   nnoremap K N
"
"   " m goes to insert mode, or with shift at beginning of line
"   nnoremap m i
"   nnoremap M I
"
"   " shift+i does nothing
"   nnoremap I <nop>
"
"   " move around the word
"   nnoremap f e
"   nnoremap <c-t> <c-f>
" endfunction
"command Colemak call Colemak()

" Store temporary files in .vim to keep the working directories clean.
set directory=~/.vim/swap
set undodir=~/.vim/undo

" Enable persistent undo.
set undofile

set nocompatible
set hlsearch

syntax on
colorscheme onedark

" Show line numbers as relative so relative navigation is easier. Show actual
" line number for active line.
set number
set relativenumber

set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent

set linebreak
set showmatch
set scrolloff=8

" Show line and character number in lower right hand corner.
set ruler

set wildmenu

let g:limelight_conceal_ctermfg='8'
call plug#begin('~/.vim/plugged')
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
call plug#end()

autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

nnoremap <C-s> :Goyo<CR>

filetype on


set wildmenu
set wildmode=list:longest
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx
