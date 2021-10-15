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

syntax cluster jstsExpression contains=@tsExpression
syntax cluster jstsBlockContains contains=@tsBlockContains

source <sfile>:h/tsShared.vim

let b:current_syntax = "typescript"
if main_syntax == 'typescript'
  unlet main_syntax
endif

let &cpo = s:cpo_save
unlet s:cpo_save