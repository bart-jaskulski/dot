set nocompatible

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
set shiftwidth=2

" Format long text
set textwidth=72
set formatoptions=cq1lmMjp

let mapleader = " "

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

set hidden

hi Normal ctermbg=NONE

set mouse=a

set display=lastline
set sidescrolloff=5

set complete-=1
set omnifunc=syntaxcomplete#Complete

set showtabline=2

set listchars=tab:>=
set list

set path+=**

" Use ripgrep for searching
set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case

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
