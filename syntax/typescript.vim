" Vim syntax file
" Language: JavaScript
" Maintainer: Me

if !exists("main_syntax")
  if exists("b:current_syntax")
    finish
  endif
  let main_syntax = 'typescript'
endif

let s:cpo_save = &cpo
set cpo&vim

syntax sync fromstart
syntax case match

source <sfile>:h/jsts.vim

syn region jstsArrowFunction matchgroup=jstsArgumentParens start=~(\ze\%(/\*.\{-}\*/\)\?\_s*\%(\%([a-zA-Z_$]\+\>?\?:\)\|\%([^():?]*)\_s*=>\)\|\%():\)\|\%({}:\)\)~ end=/)/ extend contains=@jstsArgumentsContains skipwhite skipempty nextgroup=jstsTypeReturned,jstsArrow
" syn region jstsArrowFunction matchgroup=jstsArgumentParens start=~(\ze[^()]*)\_s*\%(:.\{-}\)\?\_s*\%(=>\|{\)~ end=/)/ extend contains=@jstsArgumentsContains skipwhite skipempty nextgroup=jstsReturnType,jstsArrow


let b:current_syntax = "typescript"
if main_syntax == 'typescript'
  unlet main_syntax
endif

let &cpo = s:cpo_save
unlet s:cpo_save
