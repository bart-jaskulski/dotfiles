vim9script

set nocompatible

# Count line numbers from current row
set number
set relativenumber

set ruler

# Show command and insert mode
set showmode

# Use some unified indentation rules
set autoindent
set smartindent
set smarttab
set expandtab
set tabstop=2
set softtabstop=2
# mostly used with >> and <<
set shiftwidth=2

# stop vim from silently messing with files that it shouldn't
set nofixendofline

# set nobackup
# set nowritebackup
# set noswapfile
set directory=~/.vimswap

set textwidth=72
set formatoptions=cq1lmMjp

# Avoid hit enter to continue
set shortmess=aoOtTI

g:mapleader = " "

set hlsearch
set incsearch
set linebreak
set ignorecase smartcase
# wrap around when searching
set wrapscan

# stop complaints about switching buffer with changes
set hidden

# faster scrolling
set ttyfast

# don't redraw while executing macros
set lazyredraw

filetype plugin on

# better command-line completion
set wildmenu

syntax on

# let g:everforest_transparent_background = 2
# let base16colorspace=256
# colorscheme one

set scrolloff=8
set clipboard=unnamed
set nocursorline

set colorcolumn=80
set ttimeout
set ttimeoutlen=100

# automatically read a file if changed outside
set autoread
# automatically write files when changing when multiple files open
set autowrite

set rulerformat=%30(%=%#LineNr#%.50f\ [%{strlen(&ft)?&ft:'none'}]\ %l:%c\ %p%%%)

# mark trailing spaces as errors
match IncSearch '\s\+$'

hi Normal ctermbg=NONE

set mouse=a

set display=lastline
set sidescrolloff=5

set complete-=1
# enable omni-completion
# set omnifunc=syntaxcomplete#Complete

set showtabline=2

# Don't display chars in TTY
if has_key(environ(), 'DISPLAY')
# better ascii friendly listchars
  set listchars=lead:*,trail:*,nbsp:*,extends:>,precedes:<,tab:\|>
  set list
endif

# {{{NAVIGATION

# set path+=**

# Improve netrw
g:netrw_keepdir = 1
g:netrw_winsize = 25
g:netrw_banner = 0
g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+' .. netrw_gitignore#Hide()
g:netrw_hide = 1
g:netrw_localcopydircmdopt = ' -Rr'
g:netrw_localmkdiropt = ' -p'
g:netrw_localrmdiropt = ' -p'
# Tree display
g:netrw_liststyle = 3
g:netrw_sizestyle = "H"

hi! link netrwMarkFile Search

# Simply open links with `gx` through lynx in new window
g:netrw_browsex_viewer = "tmux new-window lynx"

# Open explorer in cwd
nnoremap <leader><TAB> :Lexplore %:p:h<CR>

# Add simpler bindings inside netrw
def NetrwMapping()
  nmap <buffer> H u
  nmap <buffer> h -^
  nmap <buffer> l <CR>

  nmap <buffer> P <C-w>z
  nmap <buffer> L <CR>:Lexplore<CR>
  nmap <buffer> <leader><TAB> :q<CR>
  nmap <buffer> ~ :execute 'edit ' . getcwd()<CR>
enddef

augroup netrw_mapping
  autocmd!
  autocmd filetype netrw NetrwMapping()
augroup END

# View all buffers
nnoremap <space><space> :ls<CR> :b <space>

# Use ripgrep for searching
if executable('rg')
  set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
endif

# Trailing space is intended
nnoremap <silent> <leader>fw :lgrep 

# NAVIGATION}}}

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nnoremap <silent> <leader>x :q<CR>

# Yank consistent with delete or select
map Y y$

au FileType gitcommit,markdown,text setlocal spell
au FileType markdown,text {
  set tw=0
  noremap j gj
  noremap k gk
  inoremap <buffer> --<space> –<space>
}

# only load plugins if Plug detected
if filereadable(expand("~/.vim/autoload/plug.vim"))
  # github.com/junegunn/vim-plug
  plug#begin('~/.local/share/vim/plugins')
#     Plug 'phpactor/phpactor', {'for': 'php', 'tag': '*', 'do': 'composer install --no-dev -o'}
    Plug '~/Repos/github.com/junegunn/fzf'
    Plug 'vim-vdebug/vdebug', {'for': 'php'}
#     Plug 'dense-analysis/ale'
    Plug 'junegunn/fzf.vim'
    Plug 'Exafunction/codeium.vim'

  plug#end()

  nnoremap <silent> <leader>ff :FZF<CR>

  g:vdebug_options = {
    'port': 9003,
    'path_maps': {
      "/var/www/html": "/home/bjaskulski/Templates/WordPress",
      "/var/www/html/wp-content/plugins/woocommerce": "/home/bjaskulski/Plugins/woocommerce"
    },
    'break_on_open': 0,
    'watch_window_style': 'compact',
  }

  g:vdebug_keymap = {
    "run": "<leader>dr",
    "run_to_cursor": "<leader>dt",
    "step_over": "<leader>dn",
    "step_into": "<leader>di",
    "step_out": "<leader>do",
    "close": "<leader>dc",
    "detach": "<F7>",
    "set_breakpoint": "<F10>",
    "get_context": "<F11>",
    "eval_under_cursor": "<F12>",
    "eval_visual": "<Leader>e",
  }
endif

packadd lsp
var lspServers = [
  {
    name: 'phpactor',
    filetype: ['php'],
    path: '/home/bjaskulski/bin/phpactor',
    args: ['language-server']
  }
]

g:LspAddServer(lspServers)
