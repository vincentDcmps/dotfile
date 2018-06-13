
execute pathogen#infect()
if has("autocmd")
    autocmd! bufwritepost .vimrc source ~/.vimrc
endif
"cancel vi compability
set nocompatible 
" enable syntax highlighting
syntax enable

filetype plugin on 
filetype indent on 
filetype on
"cursor position
"met a jour le titre de la fenetre
set title 
" show line numbers
set number
"show long line on few line
set wrap
" set tabs to have 4 spaces
set ts=4

" indent when moving to the next line while writing code
set autoindent

" expand tabs into spaces
set expandtab

" show a visual line under the cursor's current line
set cursorline

" show the matching part of the pair for [] {} and ()
"set background=dark
set showmatch

"--search
set ignorecase
set smartcase
set incsearch
set hlsearch

" Active le comportement ’habituel’ de la touche retour en arriere
set backspace=indent,eol,start
" Cache les fichiers lors de l’ouverture d’autres fichiers
set hidden

set ruler
"activation gestion souris
set mouse=a
"change la couleur"
"set background=dark
colorscheme matrix

"aactiver nerdtree ctrl n
map <C-n> :NERDTreeToggle<CR>
"set lightline plugins
"set laststatus=2
"set noshowmode
let g:airline#extensions#tabline#enabled =1 
"plugin syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
"plugin yourcompleteme
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"taglist conf
let Tlist_Use_Right_Window=1
let Tlist_Auto_Open=0
let Tlist_Enable_Fold_Column=0
let Tlist_Compact_Format=0
let Tlist_WinWidth=28
let Tlist_Exit_OnlyWindow=1
let Tlist_File_Fold_Auto_Close = 1
" enable all Python syntax highlighting features
let python_highlight_all = 1
syntax on
set encoding=utf-8
filetype indent on
let g:pymode_options = 1


"maping
let mapleader = ','
" Desactiver les touches directionnelles
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>
" Les ; sont rarement utilises l’un a la suite de l’autre
:imap ;; <Esc>
:map ;; <Esc>
python3 from powerline.vim import setup as powerline_setup
python3 powerline_setup()
python3 del powerline_setup
set laststatus=2 " Always display the statusline in all windows
set showtabline=2 " Always display the tabline, even if there is only one tab
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)
set t_Co=256
