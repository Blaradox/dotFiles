" Very simple status line

if exists("g:loaded_baseline")
  finish
endif
let g:loaded_baseline = 1

" https://shapeshed.com/vim-statuslines/
set statusline=                              " Reset status line
set statusline+=%#ErrorMsg#                  " Set warning color
set statusline+=%(\ %{PrintCocStatus()}\ %)  " Show coc diagnostics
set statusline+=%#Pmenu#                     " Set highlight
set statusline+=\ %{PrintModified()}         " Show modified
set statusline+=%([%R%H%W]%q%)               " Show flags
set statusline+=%(\ %{PrintGitBranch()}%)    " Show git branch
set statusline+=\ %*                         " Restore normal highlight
set statusline+=%<                           " Start truncating here
set statusline+=\ %f                         " Show tail of filename
set statusline+=%=                           " Start right align
set statusline+=\ [%{PrintFiletype()}]       " File type
set statusline+=\ %4l,                       " Line number
set statusline+=%-2c                         " Column number
set statusline+=\ %4P\                       " Percent of file

function! PrintGitBranch() abort
  try
    let l:branchname = fugitive#head()
  catch
    let l:branchname = ''
  endtry
  return l:branchname
endfunction

function! PrintCocStatus() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  if empty(info) | return '' | endif
  let msgs = []
  if get(info, 'error', 0)
    call add(msgs, 'E' . info['error'])
  endif
  if get(info, 'warning', 0)
    call add(msgs, 'W' . info['warning'])
  endif
  if empty(msgs)
    return ''
  else
    return join(msgs, ' ') . ' ' . get(g:, 'coc_status', '')
  endif
endfunction

function! PrintModified() abort
  let l:symbol=&modified ? '+' : '⏺'
  if &modifiable
    return l:symbol
  else
    return '[-]'
  endif
endfunction

function! PrintFiletype() abort
  if &filetype == ''
    return ''
  else
    return &filetype
  endif
endfunction

