" Vim syntax file
" Language: JavaScript
" Maintainer: Me

if !exists("main_syntax")
  if exists("b:current_syntax")
    finish
  endif
  let main_syntax = 'tsx'
endif

let s:cpo_save = &cpo
set cpo&vim

syntax sync fromstart
syntax case match

syntax cluster jstsExpression contains=@tsExpression,tsxTag,tsxEndTag
syntax cluster jstsBlockContains contains=@tsBlockContains

source <sfile>:h/tsShared.vim

syntax region tsxTag matchgroup=tsxTagCarets start=/<\ze\%(\/\?>\|\%(\%(\K\|{\)[^<;]\{-}\/\?>\)\)\%(\s*(\)\@!/ end=/\/\?>/ keepend contains=tsxComponent,tsxTagName
hi def link tsxTagCarets Comment
syntax match tsxComponent contained /\u\k*\ze\%(\s\|\/\|>\)/ skipwhite skipempty nextgroup=tsxProp
hi def link tsxComponent Function
syntax match tsxTagName contained /[a-z]\k*\ze\%(\s\|\/\|>\)/ skipwhite skipempty nextgroup=tsxProp
hi def link tsxTagName Keyword
syntax match tsxProp contained /\<\K\k*\ze\s*=/ skipwhite skipempty nextgroup=tsxPropEquals
hi def link tsxProp Boolean
syntax match tsxPropEquals contained /=/ skipwhite skipempty nextgroup=tsxExpression,@jstsPrimitive
hi def link tsxPropEquals jstsOperator
syntax region tsxExpression contained matchgroup=jstsBraces start=/{/ end=/}/ extend contains=@jstsExpression
syntax match tsxEndSlash contained /\//
hi def link tsxEndSlash tsxTagCarets

syntax region tsxEndTag matchgroup=tsxTagCarets start=/<\// end=/>/ keepend contains=tsxEndComponent,tsxEndTagName
syntax match tsxEndComponent contained /\u\k*/
hi def link tsxEndComponent tsxComponent
syntax match tsxEndTagName contained /\[a-z]\k*/
hi def link tsxEndTagName tsxTagName

let b:current_syntax = "tsx"
if main_syntax == 'tsx'
  unlet main_syntax
endif

let &cpo = s:cpo_save
unlet s:cpo_save