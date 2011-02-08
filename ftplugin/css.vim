function! Clean()
  " delete all comments
  %s@\v/\*([^*]|[\r\n]|(\*+([^*/]|[\r\n])))*\*+/@@g
  " call CssPretty to clean all the code
  call CssPretty()
  " delete all space/tabs at the start of the line
  %le
  " make all one liner
  %s/{\_.\{-}}/\=substitute(submatch(0), '\n', '', 'g')/
  " no highlight please
  nohl
  " delete last line
  normal! Gdd
  " go back to position
  exec "i"
endfunction

function! DelComments()
  " delete all comments
  %s@\v/\*([^*]|[\r\n]|(\*+([^*/]|[\r\n])))*\*+/@@g
  " delete all blank lines
  v/\S/d
  " no highlight please
  nohl
  " go back to position
  exec "i"
endfunction

function! OneLiner()
  " delete all space/tabs at the start of the line
  %le
  " make all one liner
  %s/{\_.\{-}}/\=substitute(submatch(0), '\n', '', 'g')/
  " no highlight please
  nohl
  " go back to position
  exec "i"
endfunction

function! MuliLiner()
  " call CssPretty to clean all the code
  call CssPretty()
  " no highlight please
  nohl
  " go back to position
  exec "i"
endfunction

" Folding for CSS
function! CssFold(lnum)
  let cline = getline(a:lnum)
  if cline =~ '\sstart\s*'
      return 'a1'
  elseif cline =~ '\send\s'
      return 's1'
  else
      return '='
  endif
endfunction

function! s:Complete(txt, width)
  let length = strlen(a:txt)
  if length > a:width
      return a:txt
  endif
  return a:txt . repeat(' ', a:width - length)
endfunction

function! CssFoldText()
  let lnum = v:foldstart + 1
  let txt = s:Complete(getline(lnum), 0)
  return txt
endfunction

set foldmethod=expr 
set foldexpr=CssFold(v:lnum) 
set foldtext=CssFoldText()
