"" Plugins {{{1

" Install vim-plug at first run
let autoload_plug_path = stdpath('data') . '/site/autoload/plug.vim'
if !filereadable(autoload_plug_path)
  silent execute '!curl -fLo ' . autoload_plug_path . '  --create-dirs
      \ "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
unlet autoload_plug_path

call plug#begin()
" Cosmetic
Plug 'drewtempelmeyer/palenight.vim'
Plug 'arcticicestudio/nord-vim'
Plug 'yggdroot/indentline'
Plug 'ap/vim-css-color'
Plug 'itchyny/lightline.vim'
Plug 'maximbaz/lightline-ale'
" Syntax
Plug 'pangloss/vim-javascript'
Plug 'crusoexia/vim-javascript-lib'
" tpope
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-characterize'
" Useful
Plug 'wellle/targets.vim'
Plug 'godlygeek/tabular', { 'on': 'Tabularize' }
Plug 'christoomey/vim-tmux-navigator'
Plug 'markonm/traces.vim'
" Linting
Plug 'w0rp/ale'
" Fuzzy
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
call plug#end()

"" Sane Defaults {{{1

" Good start URL: http://vim.wikia.com/wiki/Example_vimrc
" Or https://github.com/tpope/vim-sensible

set colorcolumn=80                     " Coloured column for long lines
set confirm                            " Confirm commands instead of failing
set gdefault                           " Global flag is now implied on regex
set hidden                             " Can switch between unsaved buffers
set lazyredraw                         " Redraw screen less often
set mouse=a                            " Enable mouse everywhere
set nobackup                           " No backup files
set notimeout ttimeout ttimeoutlen=200
set nowrap                             " No word wrapping
set number                             " Display line numbers
set pastetoggle=<F11>
set ignorecase                         " Case insensitive search
set smartcase                          " Except when using capital letters
set splitbelow                         " Splits open below
set splitright                         " Splits open to the right
set visualbell                         " Visual bell instead of beeping

" Have Y act like C and D
nnoremap Y y$
" Allow word under cursor refactoring
nnoremap c* *Ncgn
nnoremap c# #NcgN
" Target contents of fold
onoremap iz :<c-u>normal! [zV]z<cr>
xnoremap iz [zo]z

" Allow saving if not opened as root
try
  command! W SudoWrite
catch
  command! W w !sudo tee "%" > /dev/null
endtry

" Deal with swap files
set directory=/tmp//,.
set undofile
set undodir=/tmp//,.

" Show tabs and trailing whitespace
set list listchars=tab:>>,trail:~
if has('multi_byte')
    set listchars=tab:»»,trail:•
    set fillchars=vert:┃ showbreak=↪
endif

"" External Programs {{{1

" Use ripgrep as default grep program
if executable('rg')
  set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
endif

" Grep through directory with fzf and rg
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --hidden --smart-case --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

"" Opinionated Defaults {{{1

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
nnoremap <leader>r :Rg<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader><Tab> :buffer #<CR>
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

"" Compatibility {{{2

"" Setup variables {{{

" Determine operating system
if !exists('g:os')
  if has('win64') || has('win32') || has('win16')
    let g:os = "Windows"
  else
    let g:os = substitute(system('uname'), '\n', '', '')
  endif
endif

"" }}}

" Set vim to use bash for compatability
set shell=bash\ -i
if &diff
  set shell=bash
endif

" Use Mac OS X dictionary
if g:os == "Darwin"
  set dictionary=/usr/share/dict/words
endif

"" Auto Commands {{{1

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

" Activate and deactivate `cursorline`
augroup Cursorline
  autocmd!
  autocmd WinEnter,BufEnter * set cursorline
  autocmd WinLeave,BufLeave * set nocursorline
augroup END

" Match trailing whitespace
augroup MatchWhitespace
  autocmd!
  autocmd BufWinEnter * match ExtraWhitespace /\s\+$\| \+\ze\t/
  autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
  autocmd InsertLeave * match ExtraWhitespace /\s\+$/
  autocmd BufWinLeave * call clearmatches()
augroup END

" Setup colors
function! MyHighlights() abort
  let l:blk = '#292d3e'
  let l:red = '#ff5370'
  let l:grn = '#c3e88d'
  let l:wht = '#bfc7d5'
  let l:gry = '#3e4452'
  execute 'highlight ExtraWhitespace guibg=' . l:red
endfunction

" Execute color changes
augroup MyColors
  autocmd!
  autocmd Colorscheme * call MyHighlights()
augroup END

augroup FoldMarkers
  autocmd!
  autocmd BufEnter,WinEnter init.vim setlocal foldmethod=marker foldlevel=1
augroup END

"" Plugin Settings {{{1

" https://shapeshed.com/vim-netrw/
" Replace NERDtree with default netrw
let g:netrw_banner = 0       " disable banner
let g:netrw_liststyle = 3    " tree view
let g:netrw_altv = 1         " open splits to the right
let g:netrw_preview = 1      " open previews vertically
let g:netrw_winsize = 20     " make netrw take up 20% of the window
let g:netrw_list_hide = '.*\.swp,.git/'

" set colorscheme
try
  " let g:palenight_terminal_italics = 1
  let g:nord_italic = 1
  let g:nord_italic_comments = 1
  colorscheme nord
  set termguicolors
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
endtry

" miscellaneous settings
try
  let g:tmuxline_powerline_separators = 0
  let g:indentLine_char = '│'
  let g:indentLine_color_term = 15
  let g:javascript_plugin_jsdoc = 1
  let g:fzf_buffers_jump = 1
  let g:lightline = {
    \  'colorscheme': 'nord',
    \  'active': {
    \    'left': [ [ 'mode', 'paste' ],
    \              [ 'git_branch' ],
    \              [ 'readonly', 'filename', 'modified' ] ],
    \    'right': [ [ 'filetype' ],
    \               [ 'lineinfo' ],
    \               [ 'linter_checking', 'linter_errors', 'linter_warnings' ] ]
    \  },
    \  'component': {
    \    'filetype': '%{&filetype!=#""?toupper(&filetype):"NO FT"}',
    \  },
    \  'component_function': {
    \    'git_branch': 'fugitive#head',
    \  },
    \ }
  let g:lightline.component_expand = {
    \  'linter_checking': 'lightline#ale#checking',
    \  'linter_warnings': 'lightline#ale#warnings',
    \  'linter_errors': 'lightline#ale#errors',
    \  'linter_ok': 'lightline#ale#ok',
    \ }
  let g:lightline.component_type = {
    \  'linter_checking': 'left',
    \  'linter_warnings': 'warning',
    \  'linter_errors': 'error',
    \  'linter_ok': 'left',
    \ }
  let g:lightline#ale#indicator_checking = "\uf110 "
  let g:lightline#ale#indicator_warnings = "\uf071 "
  let g:lightline#ale#indicator_errors = "\uf05e "
  augroup MarkdownFiles
    autocmd!
    autocmd FileType markdown let g:indentLine_enabled=0
  augroup END
endtry
