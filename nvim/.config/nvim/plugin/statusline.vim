" https://shapeshed.com/vim-statuslines/
set statusline=                            " Reset status line
set statusline+=%#Pmenu#                   " Set highlight
set statusline+=\ %{PrintModified()}       " Show modified
set statusline+=%([%R%H%W]%q%)             " Show modified
set statusline+=%(\ %{PrintGitBranch()}%)  " Show git branch
set statusline+=\ %*                       " Restore normal highlight
set statusline+=%<                         " Start truncating here
set statusline+=\ %f                       " Show tail of filename
set statusline+=%=                         " Start right align
set statusline+=\ [%{PrintFiletype()}]     " File type
set statusline+=\ %4l,                     " Line number
set statusline+=%-2c                       " Column number
set statusline+=\ %4P\                     " Percent of file

function! PrintGitBranch() abort
  try
    let l:branchname = fugitive#head()
  catch
    let l:branchname = ''
  endtry
  return l:branchname
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

