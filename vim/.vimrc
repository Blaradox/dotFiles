"===============================================================================
"  _ _              _  _
" | | | _ _ ._ _  _| || | ___
" | ' || | || ' |/ . || |/ ._>
" |__/ `___||_|_|\___||_|\___.
"===============================================================================
"
" Setup Vundle
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-surround'
Plugin 'vim-airline/vim-airline'
Plugin 'edkolev/tmuxline.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-fugitive'
Plugin 'yggdroot/indentline'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'joshdick/onedark.vim'
Plugin 'w0rp/ale'
Plugin 'tpope/vim-commentary'
Plugin 'dylanaraps/wal.vim'
Plugin 'godlygeek/tabular'
Plugin 'tpope/vim-repeat'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" " :PluginList       - lists configured plugins
" " :PluginInstall    - installs plugins; append `!` to update or just
" :PluginUpdate
" " :PluginSearch foo - searches for foo; append `!` to refresh local cache
" " :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
" "
" " see :h vundle for more details or wiki for FAQ
" " Put your non-Plugin stuff after this line
"
"===============================================================================
"  _ _ _  _  _    _   ___                       _
" | | | |<_>| |__<_> | __>__   ___ ._ _ _  ___ | | ___
" | | | || || / /| | | _> \ \/<_> || ' ' || . \| |/ ._>
" |__/_/ |_||_\_\|_| |___>/\_\<___||_|_|_||  _/|_|\___.
"                                         |_|
"===============================================================================
"
" URL: http://vim.wikia.com/wiki/Example_vimrc
" Authors: http://vim.wikia.com/wiki/Vim_on_Freenode
" Description: A minimal, but feature rich, example .vimrc. If you are a
"              newbie, basing your first .vimrc on this file is a good choice.
"              If you're a more advanced user, building your own .vimrc based
"              on this file is still a good idea.
syntax on
set hidden
set showcmd
set hlsearch
set ignorecase
set smartcase
set backspace=indent,eol,start
set autoindent
set nostartofline
set ruler
set laststatus=2
set confirm
set visualbell
set t_vb=
set mouse=a
set number
set notimeout ttimeout ttimeoutlen=200
set pastetoggle=<F11>
map Y y$
nnoremap <C-L> :nohl<CR><C-L>

"===============================================================================
"  ___                               _
" | . \ ___  _ _  ___ ___ ._ _  ___ | |
" |  _// ._>| '_><_-</ . \| ' |<_> || |
" |_|  \___.|_|  /__/\___/|_|_|<___||_|
"===============================================================================
"
" Personal mappings "Blaradox"

" Set vim to use bash for compatability
set shell=bash\ -i

" Set standard file encoding
set encoding=utf8

" Indentation settings to use 2 spaces instead of tabs.
set shiftwidth=2
set softtabstop=2
set expandtab

" Display a coloured column to indicate lines of 80+ characters
set colorcolumn=80
  autocmd FileType markdown set colorcolumn=

" Set no word wrappings, except for in Markdown files
set nowrap
  autocmd FileType markdown setlocal wrap

" The <Leader> key is pressed before any shortcut to trigger the command.
let mapleader="\<SPACE>"

" Dealing with the system clipboard
nmap <leader>y "*y
vmap <leader>y "*y
nmap <leader>p "*p
vmap <leader>p "*p
nmap <leader>P "*P

" https://stackoverflow.com/questions/16082991/vim-switching-between-files-rapidly-using-vanilla-vim-no-plugins
" Customizing the wildmenu
set wildmenu
set wildmode=list:full
set wildignorecase
set wildignore=*.swp,*.bak
set wildignore+=*/.git/**/*,*/node_modules/**/*

" Juggling with Files
set path=.,**
nnoremap <leader>f :find *
nnoremap <leader>s :sfind *
nnoremap <leader>v :vert sfind *
nnoremap <leader>t :tabfind *

" Juggling with Buffers
set wildcharm=<C-z>
nnoremap <leader>b :buffer <C-z><S-Tab>
nnoremap <leader>B :sbuffer <C-z><S-Tab>

" http://vim.wikia.com/wiki/Remove_unwanted_spaces
" A function to remove whitespace, use `:call TrimeWhiteSpace`
fun! TrimWhitespace()
    let l:save = winsaveview()
    %s/\s\+$//e
    call winrestview(l:save)
endfun

" Change cursor shape in different modes
let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"

" https://shapeshed.com/vim-netrw/
" Replace NERDtree with default netrw
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_altv = 1
let g:netrw_winsize = 25

" Plugin Settings
let g:onedark_termcolors = 16
colorscheme onedark
let g:airline_theme='onedark'
let g:airline_powerline_fonts = 0
let g:airline#extensions#tmuxline#enabled = 0
let g:airline#extensions#ale#enabled = 1
let g:airline_section_z = '%3p%% %{g:airline_symbols.linenr}%3l:%-2v'
let g:tmuxline_powerline_separators = 0
let g:indentLine_char = '|'

