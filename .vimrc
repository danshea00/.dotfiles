set nocompatible

" ================ General Config ====================

set number relativenumber                      "Line numbers are good
set hidden

syntax on

set noswapfile
set nobackup
set nowb


" ================== Vundle =======================
filetype off
set runtimepath+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'prabirshrestha/vim-lsp'
Plugin 'morhetz/gruvbox'
Plugin 'scrooloose/nerdtree'
Plugin 'itchyny/lightline.vim'
Plugin 'dense-analysis/ale'
Plugin 'sophacles/vim-processing'
Plugin 'justinmk/vim-sneak'
Plugin 'airblade/vim-gitgutter'
if has('nvim')
  Plugin 'nvim-lua/plenary.nvim'
  Plugin 'nvim-telescope/telescope.nvim', { 'rev': '0.1.8' }
endif
Plugin 'github/copilot.vim'

call vundle#end()
filetype plugin indent on

" ================= Lightline =======================
set laststatus=2
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ }


" ==================== Sneak ========================
let g:sneak#label = 1

" ================ Indentation ======================

set autoindent
set smartindent
set smarttab
set shiftwidth=3
set softtabstop=3
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
let g:gruvbox_contrast_dark='hard'
colorscheme gruvbox
set bg=dark


" ================ Mappings ==========================
map <C-o> :NERDTreeToggle<CR>


" ================ Telescope ==========================
" Find files using Telescope command-line sugar.
if has('nvim')
  nnoremap <leader>ff <cmd>Telescope find_files<cr>
  nnoremap <leader>fg <cmd>Telescope live_grep<cr>
  nnoremap <leader>fb <cmd>Telescope buffers<cr>
  nnoremap <leader>fh <cmd>Telescope help_tags<cr>
endif
