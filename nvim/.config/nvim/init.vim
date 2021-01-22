
call plug#begin('~/.local/share/nvim/plugged')
	Plug 'davidhalter/jedi-vim'
	Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
	Plug 'zhou13/vim-easyescape'
	Plug 'zchee/deoplete-jedi'
	Plug 'vim-airline/vim-airline'
	Plug 'jiangmiao/auto-pairs'
	Plug 'scrooloose/nerdcommenter'
	Plug 'terryma/vim-multiple-cursors'
	Plug 'scrooloose/nerdtree'
	Plug 'morhetz/gruvbox'
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
map <C-n> :NERDTreeToggle<CR>
set ignorecase
set smartcase
set mouse=a
colorscheme gruvbox
set background=dark " use dark mode
set ts=4
