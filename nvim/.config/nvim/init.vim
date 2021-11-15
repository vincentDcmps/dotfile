let g:python3_host_prog='/usr/bin/python3'
let g:python_host_prog='/usr/bin/python'
call plug#begin('~/.local/share/nvim/plugged')
	Plug 'davidhalter/jedi-vim'
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'zhou13/vim-easyescape'
  Plug 'zchee/deoplete-jedi'
	Plug 'scrooloose/nerdtree'
	Plug 'SirVer/ultisnips'
	Plug 'honza/vim-snippets'
	Plug 'tpope/vim-fugitive'
	Plug 'freitass/todo.txt-vim'
	Plug 'junegunn/fzf'
	Plug 'dense-analysis/ale'
  Plug 'rktjmp/lush.nvim'
  Plug 'ellisonleao/gruvbox.nvim'
  Plug 'Shougo/deoplete.nvim' , { 'do': ':UpdateRemotePlugins' }
  Plug 'lewis6991/gitsigns.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'romgrk/barbar.nvim'
  Plug 'yamatsum/nvim-cursorline'
  Plug 'famiu/feline.nvim'
  Plug 'windwp/nvim-autopairs'
  Plug 'lukas-reineke/indent-blankline.nvim'
  Plug 'kyazdani42/nvim-tree.lua'
  Plug 'folke/which-key.nvim'
  Plug 'AckslD/nvim-whichkey-setup.lua'
  Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
call plug#end()
"Config Section
set number

let g:deoplete#enable_at_startup = 1
let g:airline_powerline_fonts = 1
let mapleader = "\<Space>"
let g:easyescape_chars = { "j": 1, "k": 1 }
let g:easyescape_timeout = 100
let g:ale_lint_on_enter = 1
let g:ale_lint_on_save                = 1
let g:ale_fix_on_save                 = 1
let g:ale_sign_column_always = 1
let g:airline#extensions#ale#enabled = 1
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['prettier'],
\   'markdown': ['prettier'],
\   'yaml': ['prettier'],
\   'python': ['black'],
\}
inoremap jk <esc>
inoremap kj <esc>
set ignorecase
set smartcase
set mouse=a
colorscheme gruvbox
set background=dark " use dark mode
set tabstop=2       " number of visual spaces per TAB
set softtabstop=2   " number of spaces in tab when editing
set shiftwidth=2   " number of spaces to use for autoindent
set expandtab       " tabs are space
set autoindent
set copyindent      " copy indent from the previous line
set termguicolors
nnoremap <C-n> :NvimTreeToggle<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>
nnoremap <leader>n :NvimTreeFindFile<CR>
nnoremap <silent> <C-s>    :BufferPick<CR>
noremap <silent> <C-n> :lua require'tree'.toggle()<CR>
lua require('init')
" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %
