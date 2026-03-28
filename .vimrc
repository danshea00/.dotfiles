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
call plug#begin()
Plug 'prabirshrestha/vim-lsp'
Plug 'morhetz/gruvbox'
Plug 'scrooloose/nerdtree'
Plug 'itchyny/lightline.vim'
Plug 'dense-analysis/ale'
Plug 'sophacles/vim-processing'
Plug 'justinmk/vim-sneak'
Plug 'airblade/vim-gitgutter'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }

call plug#end()
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
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

lua << EOF
vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
  pattern = {'*.tac'},
  callback = function(ev)
	vim.lsp.start({
  	name = 'tacc',
  	cmd = {'/usr/bin/artaclsp'},
  	cmd_args = {'-I', '/bld/'},
  	root_dir = '/src',
	})
  end
})
vim.filetype.add({
  extension = {
    -- TAC files
    tin = 'cpp',
    itin = 'cpp',
    tac = 'tac',
    -- BUILD.qb files
    qb = 'python',
    qbi = 'python',
    -- Other
    fin = 'python',
  }
})
EOF
