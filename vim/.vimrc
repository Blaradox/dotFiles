"===============================================================================
"  ___  _            _
" | . \| | _ _  ___ <_>._ _  ___
" |  _/| || | |/ . || || ' |<_-<
" |_|  |_|`___|\_. ||_||_|_|/__/
"              <___'
"===============================================================================

" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
" Cosmetic
Plug 'edkolev/tmuxline.vim'
Plug 'joshdick/onedark.vim'
Plug 'crusoexia/vim-monokai'
Plug 'jacoborus/tender.vim'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'dylanaraps/wal.vim'
Plug 'yggdroot/indentline'
Plug 'ap/vim-css-color'
Plug 'airblade/vim-gitgutter'
" Syntax
Plug 'pangloss/vim-javascript'
Plug 'crusoexia/vim-javascript-lib'
" tpope
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-characterize'
" Useful
Plug 'godlygeek/tabular'
Plug 'christoomey/vim-tmux-navigator'
Plug 'markonm/traces.vim'
" Linting
Plug 'w0rp/ale'
" Fuzzy
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
call plug#end()

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
set nobackup                           " No backup files
set autoread                           " Re-read files changed outside of vim

" Have Y act like C and D
nnoremap Y y$
" Allow word under cursor refactoring
nnoremap c* *Ncgn
nnoremap c# #NcgN

" Allow saving if not opened as root
command! W w !sudo tee "%" > /dev/null

" Show tabs and trailing whitespace
set list listchars=tab:>>,trail:~
if has('multi_byte') && $DISPLAY !=? ''
    set listchars=tab:»»,trail:•
    set fillchars=vert:┃ showbreak=↪
endif

" Deal with swap files
if !isdirectory($HOME . '/.vim/swap') && has('unix')
  :silent !mkdir -p ~/.vim/swap >/dev/null 2>&1
endif
set directory=.swp/,~/.vim/swp//,/tmp//,.

" Deal with undo files
if exists('+undofile')
  if !isdirectory($HOME . '/.vim/undo') && has('unix')
    :silent !mkdir -p ~/.vim/undo > /dev/null 2>&1
  endif
  set undofile
  set undodir=.undo/,~/.vim/undo//,/tmp//,.
endif

" Determine operating system
if !exists('g:os')
  if has('win64') || has('win32') || has('win16')
    let g:os = "Windows"
  else
    let g:os = substitute(system('uname'), '\n', '', '')
  endif
endif

"===============================================================================
"  __ __        ___       ___           _    _
" |  \  \ _ _  | . \ ___ | | '___  _ _ | | _| |_ ___
" |     || | | | | |/ ._>| |-<_> || | || |  | | <_-<
" |_|_|_|`_. | |___/\___.|_| <___|`___||_|  |_| /__/
"        <___'
"===============================================================================

" Set vim to use bash for compatability
set shell=bash\ -i
if &diff
  set shell=bash
endif

" Use Mac OS X dictionary
if g:os == "Darwin"
  set dictionary=/usr/share/dict/words
endif

" Allow mouse scroll in simple terminal
if g:os == "Linux"
  set ttymouse=sgr
endif

" kitty does not support background color erase
if $TERMINFO =~ "kitty"
  let &t_ut=''
endif

" https://www.reddit.com/r/vim/wiki/tabstop
set tabstop=8
set softtabstop=2
set shiftwidth=2
set expandtab " use spaces instead of tabs

" The <Leader> key is pressed before any shortcut to trigger the command
let mapleader="\<SPACE>"

" Clear highlight and redraw screen
nnoremap <leader>hh :nohlsearch<CR>:redraw!<CR>
" Toggle spell checking
nnoremap <leader>ss :setlocal spell!<CR>

" Deal with the system clipboard
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>p "+p
vnoremap <leader>p "+p
nnoremap <leader>P "+P

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

" Make arrow keys resize viewports
nnoremap <Left> :vertical resize -2<CR>
nnoremap <Right> :vertical resize +2<CR>
nnoremap <Up> :resize -2<CR>
nnoremap <Down> :resize +2<CR>

" http://vim.wikia.com/wiki/Remove_unwanted_spaces
function! StripTrailingWhitespace() abort
  if !&binary && &filetype != 'diff'
    let l:winview = winsaveview()
    silent! %s/\s\+$//e
    call winrestview(l:winview)
  endif
endfunction

nnoremap <leader>ww :call StripTrailingWhitespace()<CR>

" Change cursor shape in different modes
if g:os == "Darwin" && $TERMINFO =~ "^(?!.*kitty)"
  " if you're using iTerm2
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_SR = "\<Esc>]50;CursorShape=2\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
  if !empty($TMUX)
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
  endif
elseif g:os == "Linux" || $TERMINFO =~ "kitty"
  " if you're using urxvt, st, or xterm
  let &t_SI = "\<Esc>[6 q"
  let &t_SR = "\<Esc>[4 q"
  let &t_EI = "\<Esc>[2 q"
  if !empty($TMUX)
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>[6 q\<Esc>\\"
    let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>[4 q\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>[2 q\<Esc>\\"
  endif
endif

"===============================================================================
"  ___                                 _
" |  _> ___ ._ _ _ ._ _ _  ___ ._ _  _| | ___
" | <__/ . \| ' ' || ' ' |<_> || ' |/ . |<_-<
" `___/\___/|_|_|_||_|_|_|<___||_|_|\___|/__/
"
"===============================================================================

" Use ripgrep as default grep program
if executable('rg')
  set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
endif

" Grep through directory with fzf and rg
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \ <bang>0)

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

" Match trailing whitespace
augroup MatchWhitespace
  autocmd!
  autocmd BufWinEnter * match ExtraWhitespace /\s\+$\| \+\ze\t/
  autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
  autocmd InsertLeave * match ExtraWhitespace /\s\+$/
  autocmd BufWinLeave * call clearmatches()
augroup END

" Activate and deactivate `cursorline`
augroup Cursorline
  autocmd!
  autocmd WinEnter,BufEnter * set cursorline
  autocmd WinLeave,BufLeave * set nocursorline
augroup END

" Setup colors
function! MyHighlights() abort
  highlight ExtraWhitespace cterm=NONE ctermbg=red guibg=red
  highlight User1           cterm=NONE ctermfg=00 ctermbg=02
  highlight User2           cterm=NONE ctermfg=07 ctermbg=08
  highlight User3           cterm=NONE ctermfg=07 ctermbg=NONE
endfunction

" Execute color changes
augroup MyColors
  autocmd!
  autocmd Colorscheme * call MyHighlights()
augroup END

" statusline
set noshowmode
let g:currentmode={
      \ 'n'  : 'NORMAL ',
      \ 'no' : 'N·OPERATOR PENDING ',
      \ 'v'  : 'VISUAL ',
      \ 'V'  : 'V·LINE ',
      \ '' : 'V·BLOCK ',
      \ 's'  : 'SELECT ',
      \ 'S'  : 'S·LINE ',
      \ '' : 'S·BLOCK ',
      \ 'i'  : 'INSERT ',
      \ 'R'  : 'REPLACE ',
      \ 'Rv' : 'V·REPLACE ',
      \ 'c'  : 'COMMAND ',
      \ 'cv' : 'VIM EX ',
      \ 'ce' : 'EX ',
      \ 'r'  : 'PROMPT ',
      \ 'rm' : 'MORE ',
      \ 'r?' : 'CONFIRM ',
      \ '!'  : 'SHELL ',
      \ 't'  : 'TERMINAL '}

function! LinterStatus() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '' : printf(
    \ 'W:%d E:%d',
    \ l:all_non_errors,
    \ l:all_errors
    \)
endfunction

set statusline=                               " Reset status line
set statusline+=%1*                           " Highlight User 1
set statusline+=\ %{g:currentmode[mode()]}    " Show mode
set statusline+=%<                            " Start truncating here
set statusline+=%2*                           " Highlight User 2
set statusline+=%(\ ᚠ\ %{fugitive#head()}\ %) " Show git branch
set statusline+=%3*                           " Highlight User 3
set statusline+=\ %t                          " Show tail of filename
set statusline+=\ %([%R%H%M%W]%)              " Show flags
set statusline+=%=                            " Start right align
set statusline+=%2*                           " Highlight User 2
set statusline+=\ %3l,                        " Line number
set statusline+=\ %-2c                        " Column number
set statusline+=\ %1*                         " Highlight User 1
set statusline+=\ %Y\ %*                      " File type
set statusline+=%(\ %{LinterStatus()}\ %)

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

" set colorscheme
try
  set background=dark
  let g:palenight_terminal_italics = 1
  colorscheme palenight
  if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
  endif
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
endtry

let g:tmuxline_powerline_separators = 0
let g:indentLine_char = '│'
let g:indentLine_color_term = 15
let g:javascript_plugin_jsdoc = 1
let g:fzf_buffers_jump = 1

