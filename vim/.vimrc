"" Sane Defaults {{{1

" Good start URL: http://vim.wikia.com/wiki/Example_vimrc
" Or https://github.com/tpope/vim-sensible

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
" Target contents of fold
onoremap iz :<C-u>normal! [zV]z<cr>
xnoremap iz [zo]z

" Allow saving if not opened as root
command! W w !sudo tee "%" > /dev/null

" Deal with swap files
if !isdirectory($HOME . '/.cache/vim/swap') && has('unix')
  :silent !mkdir -p ~/.cache/vim/swap >/dev/null 2>&1
endif
set directory=.swap/,/tmp//,~/.cache/vim/swap//,.

" Deal with undo files
if exists('+undofile')
  if !isdirectory($HOME . '/.cache/vim/undo') && has('unix')
    :silent !mkdir -p ~/.cache/vim/undo > /dev/null 2>&1
  endif
  set undofile
  set undodir=.undo/,/tmp//,~/.cache/vim/undo//,.
endif

" Show tabs and trailing whitespace
set list listchars=tab:>>,trail:~
if has('multi_byte')
    set listchars=tab:»»,trail:•
    set fillchars=vert:┃ showbreak=↪
endif

"" External Programs {{{1

" Use ripgrep as default grep program
if executable('rg')
  set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case\ --hidden
  set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

"" Opinionated Defaults {{{1

" https://www.reddit.com/r/vim/wiki/tabstop
set tabstop=8
set softtabstop=2
set shiftwidth=2
set expandtab " use spaces instead of tabs

" The <Leader> key is pressed before any shortcut to trigger the command
let mapleader="\<SPACE>"

" Clear highlight and redraw screen
nnoremap <leader>h :nohlsearch<CR>:redraw!<CR>
" Toggle spell checking
nnoremap <leader>s :setlocal spell!<CR>

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

" https://www.vi-improved.org/recommendations/
" https://vimways.org/2019/vim-and-the-working-directory/
set path+=**
nnoremap <leader>a :argadd <C-r>=fnameescape(expand('%:p:h'))<CR>/*<C-d>
nnoremap <leader>b :buffer <C-d>
nnoremap <leader>c :lcd <C-r>=expand("%:.:h") . "/"<CR>
nnoremap <leader>e :edit <C-r>=expand("%:.:h") . "/"<CR>
nnoremap <leader>g :grep<space>
nnoremap <leader>q :buffer #<CR>
nnoremap <leader>v :vsplit<CR>

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

" Determine whether using kitty terminal
if !exists('g:kitty')
  if $TERMINFO =~ 'kitty'
    let g:kitty = 1
  else
    let g:kitty = 0
  endif
endif

"" }}}

" Set vim to use bash for compatability
" set shell=bash\ -i
if &diff
  set shell=bash
endif

" Use Mac OS X dictionary
if g:os == "Darwin" || g:os == "Linux"
  set dictionary+=/usr/share/dict/words
endif

" Allow mouse scroll in simple terminal
if g:os == "Linux"
  set ttymouse=sgr
endif

" kitty does not support background color erase
if g:kitty == 1
  let &t_ut=''
endif

"" }}}2

" Change cursor shape in different modes
if g:os == "Darwin" && g:kitty == 0
  " if you're using iTerm2
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_SR = "\<Esc>]50;CursorShape=2\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
  if !empty($TMUX)
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
  endif
elseif g:os == "Linux" || g:kitty == 1
  " if you're using kitty, urxvt, st, or xterm
  let &t_SI = "\<Esc>[6 q"
  let &t_SR = "\<Esc>[4 q"
  let &t_EI = "\<Esc>[2 q"
  if !empty($TMUX)
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>[6 q\<Esc>\\"
    let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>[4 q\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>[2 q\<Esc>\\"
  endif
endif

"" Auto Commands {{{1

" Jump between buffers
augroup Marks
  autocmd!
  autocmd BufLeave *.css,*.scss  normal! mC
  autocmd BufLeave *.html        normal! mH
  autocmd BufLeave *.js,*.ts     normal! mJ
  autocmd BufLeave *.vue         normal! mV
  autocmd BufLeave *.yml,*.yaml  normal! mY
  autocmd BufLeave .env*         normal! mE
  autocmd BufLeave *.md          normal! mM
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
  highlight ExtraWhitespace cterm=NONE ctermbg=red guibg=red
endfunction

" Execute color changes
augroup MyColors
  autocmd!
  autocmd Colorscheme * call MyHighlights()
augroup END

"" Statusline {{{1

" https://shapeshed.com/vim-statuslines/
set statusline=                            " Reset status line
set statusline+=%#Pmenu#                   " Set highlight
set statusline+=\ %{PrintModified()}       " Show modified
set statusline+=%([%R%H%W]%q%)             " Show modified
set statusline+=%(\ %{PrintGitBranch()}%)  " Show git branch
set statusline+=\ %*                       " Restore normal highlight
set statusline+=\ %f                       " Show tail of filename
set statusline+=%=                         " Start right align
set statusline+=%<                         " Start truncating here
set statusline+=\ %y                       " File type
set statusline+=\ %3p%%                    " Percent of file
set statusline+=\ %4l,                     " Line number
set statusline+=%-2c                       " Column number

function! PrintGitBranch() abort
  try
    let l:branchname = system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
  catch
    let l:branchname = ''
  endtry
  return l:branchname
endfunction

function! PrintModified() abort
  let l:symbol=&modifiable ? '' : '-'
  let l:symbol.=&modified ? '+' : ''
  if l:symbol == ''
    let l:symbol=' '
  endif
  let l:modified='[' . l:symbol . ']'
  return l:modified
endfunction

"" Plugin Settings {{{1

" set colorscheme
colorscheme default
