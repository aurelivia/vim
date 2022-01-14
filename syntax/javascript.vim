" Vim syntax file
" Language: JavaScript
" Maintainer: Me

if !exists('main_syntax')
	if exists('b:current_syntax')
		finish
	endif
	let main_syntax = 'javascript'
endif

let s:cpo_save = &cpo
set cpo&vim

syntax sync fromstart
syntax case match

syntax cluster jstsNotObject contains=@jstsDefaultNotObject
syntax cluster jstsExpression contains=@jstsNotObject,jstsObject,jstsType
syntax cluster jstsBlockContains contains=@jstsDefaultBlockContains,jstsType
syntax cluster jstsArgumentContains contains=jsArgument,jstsArgumentComma,jstsType,jstsComment
syntax cluster jstsExportable contains=@jstsDefaultExportable,jstsType

source <sfile>:h/jstsShared.vim

" Definition
syntax keyword jstsDefinition const let var
syntax match jstsType /\<\u\k*/

" Classes
syntax keyword jstsClass class skipwhite skipempty nextgroup=jstsClassBody,jstsClassName,jstsClassExtends
syntax match jstsClassName contained /\<\K\k*/ skipwhite skipempty nextgroup=jstsClassExtends,jstsClassBody
syntax region jstsClassBody contained matchgroup=jstsBraces start=/{/ end=/}/ contains=@jstsExpression

" Functions
syntax keyword jstsFunction function skipwhite skipempty nextgroup=jstsFunctionGenerator,jstsFunctionIdentifier,jstsArguments
syntax match jstsFunctionGenerator contained /\*/ skipwhite skipempty nextgroup=jstsFunctionIdentifier,jstsArguments
syntax match jstsFunctionIdentifier contained /\<\K\k*/ skipwhite skipempty nextgroup=jstsArguments
syntax region jstsArguments contained matchgroup=jstsArgumentParens start=/(/ end=/)/ extend contains=@jstsArgumentContains skipwhite skipempty nextgroup=jstsBlock
syntax match jsArgument contained /\<\K\k*/ skipwhite skipempty nextgroup=jsArgumentDefault
syntax match jsArgumentDefault contained /=/ skipwhite skipempty nextgroup=@jstsExpression
hi def link jsArgumentDefault jstsOperator

" Modules
syntax keyword jstsModule import skipwhite skipempty nextgroup=jstsModuleAny,jstsModuleIdentifier,jstsModuleObject
syntax keyword jstsModule export skipwhite skipempty nextgroup=@jstsExportable,jstsModuleDefault,jstsModuleAny,jstsModuleIdentifier,jstsModuleObject

" Classes
" syntax keyword jsClass class skipwhite skipempty nextgroup=jsClassBody,jsClassName,jsClassExtends
" syntax match jsClassName contained /\<\K\k*/ skipwhite skipempty nextgroup=jsClassExtends,jsClassBody
" syntax keyword jsClassExtends contained extends skipwhite skipempty nextgroup=jsExtendsName
" syntax match jsExtendsName contained /\<\K\k*/ skipwhite skipempty nextgroup=jsClassBody
" syntax region jsClassBody contained matchgroup=jsBraces start=/{/ end=/}/ contains=jsPrivateField,jsClassKeyword,jsMethodKeyword,jsMethod,jsComputedMethod,@jsExpression
" syntax keyword jsClassKeyword contained static
" syntax match jsPrivateField contained /#\k*/ skipwhite skipempty nextgroup=jsArguments

let b:current_syntax = 'javascript'

if main_syntax == 'javascript'
	unlet main_syntax
endif

let &cpo = s:cpo_save
unlet s:cpo_save