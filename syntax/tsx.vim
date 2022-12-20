" Vim syntax file
" Language: JavaScript
" Maintainer: Me

if !exists("main_syntax")
  if exists("b:current_syntax")
		syntax clear
  endif
  let main_syntax = 'tsx'
endif

let s:cpo_save = &cpo
set cpo&vim

syntax sync fromstart
syntax case match

source <sfile>:h/jsts.vim

syntax region tsxTag matchgroup=tsxTagCarets start=/<\ze\z(\K\k*\)\%(\/\@1<!>\|\s.*\/\@1<!>\)/ end=/<\/\ze\z1>/ extend contains=tsxTagName,tsxComponent,tsxBody skipwhite skipempty nextgroup=tsxEndTagName,tsxEndTagComponent
syntax region tsxInlineTag matchgroup=tsxTagCarets start=/<\ze\z(\K\k*\)\%(\/>\|\s.*\/>\)/ end=/\/>/ extend contains=tsxTagName,tsxComponent
hi def link tsxTagCarets Comment
syntax match tsxTagName contained /\<\l\k*/ skipwhite skipempty nextgroup=tsxProp
hi def link tsxTagName Keyword
syntax match tsxComponent contained /\<\u\k*/ skipwhite skipempty nextgroup=tsxProp
hi def link tsxComponent Constant
syntax match tsxProp contained /\<\K\k*/ skipwhite skipempty nextgroup=tsxPropEquals,tsxProp
hi def link tsxProp Boolean
syntax match tsxPropEquals contained /=/ skipwhite skipempty nextgroup=tsxExpression,@jstsLiterals
hi def link tsxPropEquals Operator

syntax region tsxBody contained matchgroup=tsxTagCarets start=/\/\@1<!>/ end=/\ze<\// extend contains=tsxTag,tsxInlineTag,tsxExpression
syntax region tsxExpression contained matchgroup=jstsBraces start=/{/ end=/}/ extend contains=@jstsExpression

syntax match tsxEndTagName contained /\<\l\k*/ skipwhite skipempty nextgroup=tsxEndEndTag
hi def link tsxEndTagName Keyword
syntax match tsxEndTagComponent contained /\<\u\k*/ skipwhite skipempty nextgroup=tsxEndEndTag
hi def link tsxEndTagComponent Constant
syntax match tsxEndEndTag contained />/
hi def link tsxEndEndTag Comment

let b:current_syntax = "tsx"
if main_syntax == 'tsx'
  unlet main_syntax
endif

let &cpo = s:cpo_save
unlet s:cpo_save