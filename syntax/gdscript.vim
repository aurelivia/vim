" Vim syntax file
" Language: JavaScript
" Maintainer: Me

if !exists('main_syntax')
	if exists('b:current_syntax')
		syntax clear
	endif
	let main_syntax = 'gdscript'
endif

let s:cpo_save = &cpo
set cpo&vim





" Comments
syn region  gdsComment start=/#/ end=/$/ contains=@Spell,gdsCommentAnnotation
hi def link gdsComment Comment
syn keyword gdsCommentAnnotation contained TODO
hi def link gdsCommentAnnotation Keyword

" Primitives
syn keyword gdsBoolean  true false
hi def link gdsBoolean  Boolean
syn keyword gdsConstant PI TAU INF NAN null
hi def link gdsConstant Number
syn match   gdsNumber   "\<0x\%(_\=\x\)\+\>"
syn match   gdsNumber   "\<0b\%(_\=[01]\)\+\>"
syn match   gdsNumber   "\<\d\%(_\=\d\)*\>"
syn match   gdsNumber   "\<\d\%(_\=\d\)*\%(e[+-]\=\d\%(_\=\d\)*\)\=\>"
syn match   gdsNumber   "\<\d\%(_\=\d\)*\.\%(e[+-]\=\d\%(_\=\d\)*\)\=\%(\W\|$\)\@="
syn match   gdsNumber   "\%(^\|\W\)\@1<=\%(\d\%(_\=\d\)*\)\=\.\d\%(_\=\d\)*\%(e[+-]\=\d\%(_\=\d\)*\)\=\>"
hi def link gdsNumber   Number
syn region  gdsString   start=`r\?\z(["']\)` skip=`\\\%(\z1\|$\)` end=`\z1\|$` contains=gdsEscaped extend
hi def link gdsString   String
syn match   gdsEscaped  contained /\v\\%(x\x\x|u%(\x{4}|\{\x{4,5}})|c\u|.)/
hi def link gdsEscaped  Special

" Operators
syn keyword gdsOperator not and or
syn match   gdsOperator `[-+*/^%!~&|<>=]`
hi def link gdsOperator Operator
syn match   gdsBegin    /:\s*$/
hi def link gdsBegin    Operator

" Keywords
syn keyword gdsKeyword    as pass self parent tool breakpoint await yield assert
hi def link gdsKeyword    Keyword
syn match   gdsAnnotation /^@\k\+\>/
hi def link gdsAnnotation Keyword

" Statements
syn keyword gdsStatement if is in elif else for while match break continue return class_name extends static enum preload
syn keyword gdsStatement var const skipwhite nextgroup=gdsDeclaration
syn keyword gdsStatement func signal skipwhite nextgroup=gdsFuncDec
hi def link gdsStatement Statement

" Functions
syn match   gdsFunction /\<\k\+\ze\s*(/
hi def link gdsFunction Function

" Declarations
syn keyword gdsType        void bool int float String
syn match   gdsType        /\<\u\k*\>/
hi def link gdsType        Type
syn match   gdsDeclaration contained /\h\w*/ skipwhite nextgroup=gdsTypeDec
syn match   gdsFuncDec     contained /\<\k\+\s*\ze(/ skipwhite nextgroup=gdsFuncArgs
hi def link gdsFuncDec     Function
syn region  gdsFuncArgs    contained start=/(/ end=/)/ contains=gdsTypeDec
syn match   gdsTypeDec     contained /:/ skipwhite nextgroup=gdsType
hi def link gdsTypeDec     Special





let b:current_syntax = 'gdscript'

if main_syntax == 'gdscript'
	unlet main_syntax
endif

let &cpo = s:cpo_save
unlet s:cpo_save