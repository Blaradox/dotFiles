"" Plugins {{{1

call plug#begin()
" Cosmetic
Plug 'joshdick/onedark.vim'
Plug 'crusoexia/vim-monokai'
Plug 'jacoborus/tender.vim'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'yggdroot/indentline'
Plug 'ap/vim-css-color'
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
  execute 'highlight User1           guifg=' . l:blk . ' guibg=' . l:grn
  execute 'highlight User2           guifg=' . l:wht . ' guibg=' . l:gry
  execute 'highlight User3           guifg=' . l:wht . ' guibg=' . l:blk
  execute 'highlight User4           guifg=' . l:blk . ' guibg=' . l:red
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

"" Statusline {{{1

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
  try
    let l:counts = ale#statusline#Count(bufnr(''))
    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors
  catch
    let l:counts = {'total': 0}
  endtry
  return l:counts.total == 0 ? '' : printf(
    \ 'W:%d E:%d',
    \ l:all_non_errors,
    \ l:all_errors
    \)
endfunction

function! PrintFileType() abort
  if strlen(&filetype) == 0
    return "NO FT"
  else
    return toupper(&filetype)
  endif
endfunction

function! PrintGitBranch() abort
  try
    let l:branch = fugitive#head()
  catch
    let l:branch = ''
  endtry
  if strlen(l:branch) == 0
    return ''
  else
    return 'ᚠ '.l:branch
  endif
endfunction

set statusline=                               " Reset status line
set statusline+=%1*                           " Highlight User 1
set statusline+=\ %{g:currentmode[mode()]}    " Show mode
set statusline+=%<                            " Start truncating here
set statusline+=%2*                           " Highlight User 2
set statusline+=%(\ %{PrintGitBranch()}\ %)   " Show git branch
set statusline+=%3*                           " Highlight User 3
set statusline+=\ %t                          " Show tail of filename
set statusline+=\ %([%R%H%M%W]%)              " Show flags
set statusline+=%=                            " Start right align
set statusline+=%2*                           " Highlight User 2
set statusline+=\ %2l,                        " Line number
set statusline+=\ %-2c                        " Column number
set statusline+=\ %1*                         " Highlight User 1
set statusline+=\ %{PrintFileType()}\ %*      " File type
set statusline+=%4*                           " Highlight Errors
set statusline+=%(\ %{LinterStatus()}\ %)%*   " Show ALE warnings/errors

"" Plugin Settings {{{1

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
  let g:palenight_terminal_italics = 1
  colorscheme palenight
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
endtry
