"===============================================================================
"  _ _              _  _
" | | | _ _ ._ _  _| || | ___
" | ' || | || ' |/ . || |/ ._>
" |__/ `___||_|_|\___||_|\___.
"
"===============================================================================
"
filetype off                  " required
" set the runtime path to include Vundle and initialize
set rtp+=/usr/local/opt/fzf
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
" Cosmetic
Plugin 'vim-airline/vim-airline'
Plugin 'edkolev/tmuxline.vim'
Plugin 'joshdick/onedark.vim'
Plugin 'dylanaraps/wal.vim'
Plugin 'yggdroot/indentline'
Plugin 'ap/vim-css-color'
" Syntax
Plugin 'pangloss/vim-javascript'
" Git
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-fugitive'
" Useful
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-commentary'
Plugin 'godlygeek/tabular'
Plugin 'kana/vim-textobj-user'
Plugin 'julian/vim-textobj-variable-segment'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'jiangmiao/auto-pairs'
" Linting
Plugin 'w0rp/ale'
" Fuzzy
Plugin 'junegunn/fzf.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

"===============================================================================
"  ___                  ___       ___           _    _
" / __> ___ ._ _  ___  | . \ ___ | | '___  _ _ | | _| |_ ___
" \__ \<_> || ' |/ ._> | | |/ ._>| |-<_> || | || |  | | <_-<
" <___/<___||_|_|\___. |___/\___.|_| <___|`___||_|  |_| /__/
"
"===============================================================================
" Good start URL: http://vim.wikia.com/wiki/Example_vimrc

syntax on                              " Enable syntax highligting
set hidden                             " Can switch between unsaved buffers
set wildmenu                           " Better command-line completion
set showcmd                            " Show partial commands
set lazyredraw                         " Redraw screen less often
set hlsearch                           " Highlight searches
set incsearch                          " Show searches as you type
set ignorecase                         " Case insensitive search
set smartcase                          " Except when using capital letters
set gdefault                           " Global flag is now implied on regex
set backspace=indent,eol,start         " Allow backspace over anything
set autoindent                         " Always auto indent
set ruler                              " Display cursor position
set laststatus=2                       " Always display status line
set confirm                            " Confirm commands instead of failing
set visualbell                         " Visual bell instead of beeping
set t_vb=                              " No flashing
set mouse=a                            " Enable mouse everywhere
set number                             " Display line numbers
set notimeout ttimeout ttimeoutlen=200
set pastetoggle=<F11>
set encoding=utf-8                     " Set standard file encoding
set colorcolumn=80                     " Coloured column for long lines
set nowrap                             " No word wrapping
set splitbelow                         " Splits open below
set splitright                         " Splits open to the right

" Have Y act like C and D
nnoremap Y y$
" Allow word under cursor refactoring
nnoremap c* *Ncgn
nnoremap c# #NcgN

"===============================================================================
"  __ __        ___       ___           _    _
" |  \  \ _ _  | . \ ___ | | '___  _ _ | | _| |_ ___
" |     || | | | | |/ ._>| |-<_> || | || |  | | <_-<
" |_|_|_|`_. | |___/\___.|_| <___|`___||_|  |_| /__/
"        <___'
"===============================================================================
"
"use Mac OS X dictionary
set dictionary=/usr/share/dict/words

" Set vim to use bash for compatability
set shell=bash\ -i
if &diff
  set shell=bash
endif

" https://www.reddit.com/r/vim/wiki/tabstop
set tabstop=8
set softtabstop=2
set shiftwidth=2
set expandtab " use spaces instead of tabs

" Change cursor shape in different modes
let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"

" The <Leader> key is pressed before any shortcut to trigger the command
let mapleader="\<SPACE>"

" Clear highlight and redraw screen
nnoremap <leader>hh :nohlsearch<CR>:redraw!<CR>
" Toggle spell checking
nnoremap <leader>ss :setlocal spell!<CR>

" Dealing with the system clipboard
nnoremap <leader>y "*y
vnoremap <leader>y "*y
nnoremap <leader>p "*p
vnoremap <leader>p "*p
nnoremap <leader>P "*P

" Customizing the wildmenu
" https://stackoverflow.com/questions/16082991/vim-switching-between-files-rapidly-using-vanilla-vim-no-plugins
set wildmode=list:full
set wildignorecase
set wildignore=*.swp,*.bak
set wildignore+=*.pyc,*.cache,*.min.*
set wildignore+=*/.git/**/*,*/node_modules/**/*
set wildcharm=<C-z>

" Juggling with Files and Buffers
set path+=**
nnoremap <leader>l :Lines<CR>
nnoremap <leader>f :Files<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>s :sfind *
nnoremap <leader>v :vert sfind *
nnoremap <leader>t :tabfind *

" Only search under directory of current file
nnoremap <leader>F :find <C-R>=expand('%:h').'/*'<CR>
nnoremap <leader>S :sfind <C-R>=expand('%:h').'/*'<CR>
nnoremap <leader>V :vert sfind <C-R>=expand('%:h').'/*'<CR>
nnoremap <leader>T :tabfind <C-R>=expand('%:h').'/*'<CR>
nnoremap <leader>B :sbuffer <C-z><S-Tab>

" http://vim.wikia.com/wiki/Remove_unwanted_spaces
function! StripTrailingWhitespace()
  let l:winview = winsaveview()
  silent! %s/\s\+$//
  call winrestview(l:winview)
endfunction

nnoremap <leader>ww :call StripTrailingWhitespace()<CR>

"===============================================================================
"  ___        _         ___                                 _
" | . | _ _ _| |_ ___  |  _> ___ ._ _ _ ._ _ _  ___ ._ _  _| | ___
" |   || | | | | / . \ | <__/ . \| ' ' || ' ' |<_> || ' |/ . |<_-<
" |_|_|`___| |_| \___/ `___/\___/|_|_|_||_|_|_|<___||_|_|\___|/__/
"
"===============================================================================

" Jump between WebDev files
augroup WEBDEV
  autocmd!

  autocmd BufLeave *.css  normal! mC
  autocmd BufLeave *.html normal! mH
  autocmd BufLeave *.js   normal! mJ
  autocmd BufLeave *.php  normal! mP
  autocmd FileType JavaScript inoremap ;; <END>;
  autocmd FileType JavaScript inoremap ,, <END>,
augroup END

" Markdown setting changes
augroup Markdown
  autocmd!

  autocmd FileType markdown set colorcolumn=
  autocmd FileType markdown setlocal wrap
augroup END

" Automatically generate shortcuts after editing file
augroup ShortcutSync
  autocmd!

  autocmd BufWritePost ~/.scripts/folders,~/.scripts/configs !bash ~/.scripts/shortcuts.sh
augroup END

"===============================================================================
"  ___  _            _        ___        _   _   _
" | . \| | _ _  ___ <_>._ _  / __> ___ _| |_| |_<_>._ _  ___  ___
" |  _/| || | |/ . || || ' | \__ \/ ._> | | | | | || ' |/ . |<_-<
" |_|  |_|`___|\_. ||_||_|_| <___/\___. |_| |_| |_||_|_|\_. |/__/
"              <___'                                    <___'
"===============================================================================

" https://shapeshed.com/vim-netrw/
" Replace NERDtree with default netrw
nnoremap <leader><Tab> :Lexplore<CR>
let g:netrw_banner = 0       " disable banner
let g:netrw_liststyle = 3    " tree view
let g:netrw_altv = 1         " open splits to the right
let g:netrw_preview = 1      " open previews vertically
let g:netrw_winsize = 20     " make netrw take up 20% of the window
let g:netrw_list_hide = '.*\.swp,.git/'

let g:onedark_termcolors = 16
colorscheme onedark
let g:airline_theme='onedark'
let g:airline_powerline_fonts = 0
let g:airline#extensions#tmuxline#enabled = 0
let g:airline#extensions#ale#enabled = 1
let g:airline_section_z = '%3p%% %{g:airline_symbols.linenr}%3l:%-2v'
let g:tmuxline_powerline_separators = 0
let g:indentLine_char = '|'
let g:javascript_plugin_jsdoc = 1
let g:indentLine_color_term = 15
let g:fzf_buffers_jump = 1
set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case

