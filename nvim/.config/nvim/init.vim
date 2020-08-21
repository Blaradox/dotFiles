"" Plugins {{{1

try
  call plug#begin()
  " Cosmetic
  Plug 'yggdroot/indentline'
  Plug 'arcticicestudio/nord-vim'
  Plug 'ap/vim-css-color'
  " tpope
  Plug 'tpope/vim-abolish'
  Plug 'tpope/vim-characterize'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-eunuch'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-rsi'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-unimpaired'
  " Useful
  Plug 'jiangmiao/auto-pairs'
  Plug 'editorconfig/editorconfig-vim'
  Plug 'wellle/targets.vim'
  Plug 'markonm/traces.vim'
  Plug 'justinmk/vim-dirvish'
  Plug 'tommcdo/vim-lion'
  Plug 'christoomey/vim-tmux-navigator'
  " Fuzzy
  Plug '/usr/local/opt/fzf'
  Plug 'junegunn/fzf.vim'
  " Linting
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  call plug#end()
catch
  echom 'vim-plug not installed'
endtry

"" Sane Defaults {{{1

" Good start URL: http://vim.wikia.com/wiki/Example_vimrc
" Or https://github.com/tpope/vim-sensible

set hidden                             " Can switch between unsaved buffers
set lazyredraw                         " Redraw screen less often
set ignorecase                         " Case insensitive search
set smartcase                          " Except when using capital letters
set gdefault                           " Global flag is now implied on regex
set confirm                            " Confirm commands instead of failing
set visualbell                         " Visual bell instead of beeping
set mouse=a                            " Enable mouse everywhere
set number                             " Display line numbers
set notimeout ttimeout ttimeoutlen=200
set pastetoggle=<F11>
set colorcolumn=80                     " Coloured column for long lines
set nowrap                             " No word wrapping
set splitbelow                         " Splits open below
set splitright                         " Splits open to the right
set nobackup                           " No backup files

" Have Y act like C and D
nnoremap Y y$
" Allow word under cursor refactoring
nnoremap c* *Ncgn
nnoremap c# #NcgN
" Target contents of fold
onoremap iz :<C-u>normal! [zV]z<cr>
xnoremap iz [zo]z

" Allow saving if not opened as root
try
  command! W SudoWrite
catch
  command! W w !sudo tee "%" > /dev/null
endtry

" Deal with swap files
if !isdirectory($HOME . '/.cache/nvim/swap') && has('unix')
  :silent !mkdir -p ~/.cache/nvim/swap >/dev/null 2>&1
endif
set directory=.swap/,/tmp//,~/.cache/nvim/swap//,.

" Deal with undo files
if exists('+undofile')
  if !isdirectory($HOME . '/.cache/nvim/undo') && has('unix')
    :silent !mkdir -p ~/.cache/nvim/undo > /dev/null 2>&1
  endif
  set undofile
  set undodir=.undo/,/tmp//,~/.cache/nvim/undo//,.
endif

" Show tabs and trailing whitespace
set list listchars=tab:>>,trail:~
if has('multi_byte')
    set listchars=tab:»»,trail:•
    set fillchars=vert:┃ showbreak=↪
endif

" http://vim.wikia.com/wiki/Remove_unwanted_spaces
function! StripTrailingWhitespace() abort
  if !&binary && &filetype != 'diff'
    let l:winview = winsaveview()
    silent! %s/\s\+$//e
    call winrestview(l:winview)
  endif
endfunction

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
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>c :lcd <C-r>=expand("%:.:h") . "/"<CR>
nnoremap <leader>e :edit <C-r>=expand("%:.:h") . "/**"<CR>
nnoremap <leader>f :Files<CR>
nnoremap <leader>g :grep<space>
nnoremap <leader>l :Lines<CR>
nnoremap <leader>q :buffer #<CR>
nnoremap <leader>r :Rg<space>
nnoremap <leader>v :vsplit<CR>

" Make arrow keys resize viewports
nnoremap <Left> :vertical resize -2<CR>
nnoremap <Right> :vertical resize +2<CR>
nnoremap <Up> :resize -2<CR>
nnoremap <Down> :resize +2<CR>

"" External Programs {{{1

" Use ripgrep as default grep program
if executable('rg')
  set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case\ --hidden
  set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

" Grep through directory with fzf and rg
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --hidden --smart-case --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

"" Compatibility {{{2

" Determine operating system
if !exists('g:os')
  if has('win64') || has('win32') || has('win16')
    let g:os = "Windows"
  else
    let g:os = substitute(system('uname'), '\n', '', '')
  endif
endif

" Set vim to use bash for compatability
" set shell=bash\ -i
if &diff
  set shell=bash
endif

" Use Mac OS X dictionary
if g:os == "Darwin" || g:os == "Linux"
  set dictionary+=/usr/share/dict/words
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

"" Plugin Settings {{{1

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
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']
let g:fzf_buffers_jump = 1
let g:indentLine_char = '│'
let g:indentLine_color_term = 15
augroup DisableIndentLine
  autocmd!
  autocmd FileType markdown let g:indentLine_enabled=0
augroup END
let g:dirvish_mode = ':sort ,^.*[\/],'
augroup DirvishMappings
  autocmd!
  autocmd FileType dirvish
        \ nnoremap <silent><buffer> L :<C-u>call dirvish#open('edit', 0)<CR>
  autocmd FileType dirvish
        \ nnoremap <silent><buffer> H :<C-u>exe 'Dirvish %:p:h'.repeat(':h',v:count1)<CR>
augroup END

