
call plug#begin('~/.local/share/nvim/plugged')
	Plug 'davidhalter/jedi-vim'
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
	Plug 'zhou13/vim-easyescape'
	Plug 'zchee/deoplete-jedi'
	Plug 'vim-airline/vim-airline'
	Plug 'jiangmiao/auto-pairs'
	Plug 'scrooloose/nerdcommenter'
    "Plug 'terryma/vim-multiple-cursors'
	Plug 'scrooloose/nerdtree'
	Plug 'morhetz/gruvbox'
	Plug 'SirVer/ultisnips'
	Plug 'honza/vim-snippets'
	Plug 'tpope/vim-fugitive'
	Plug 'freitass/todo.txt-vim'
call plug#end()
"Config Section 
set number
let g:deoplete#enable_at_startup = 1
let g:airline_powerline_fonts = 1
let mapleader = "\<Space>"
let g:easyescape_chars = { "j": 1, "k": 1 }
let g:easyescape_timeout = 100
inoremap jk <esc>
inoremap kj <esc>
set ignorecase
set smartcase
set mouse=a
colorscheme gruvbox
set background=dark " use dark mode
set tabstop=4       " number of visual spaces per TAB
set softtabstop=4   " number of spaces in tab when editing
set shiftwidth=4    " number of spaces to use for autoindent
set expandtab       " tabs are space
set autoindent
set copyindent      " copy indent from the previous line

map <C-n> :NERDTreeToggle<CR>

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %
