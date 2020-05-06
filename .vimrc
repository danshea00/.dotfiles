set nocompatible

" ================ General Config ====================

set number relativenumber                      "Line numbers are good
set hidden

syntax on

set noswapfile
set nobackup
set nowb


" ================== Vundle =========================
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'morhetz/gruvbox'
Plugin 'scrooloose/nerdtree'
Plugin 'itchyny/lightline.vim'
Plugin 'dense-analysis/ale'
Plugin 'sophacles/vim-processing'

call vundle#end()
filetype plugin indent on

" ================= Lightline =======================
set laststatus=2
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ }

" ================ Indentation ======================

set autoindent
set smartindent
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab

" Auto indent pasted text
nnoremap p p=`]<C-o>
nnoremap P P=`]<C-o>

filetype plugin on
filetype indent on

set nowrap       "Don't wrap lines
set linebreak    "Wrap lines at convenient points

" ================ Folds ============================

set foldmethod=indent   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default


" ================ Scrolling ========================

set scrolloff=8         "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1

" ================ Search ===========================

set incsearch       " Find the next match as we type the search
set hlsearch        " Highlight searches by default
set ignorecase      " Ignore case when searching...
set smartcase       " ...unless we type a capital

" ================= Theme ============================
colorscheme gruvbox
set bg=dark


" ================ Mappings ==========================
map <C-o> :NERDTreeToggle<CR>

