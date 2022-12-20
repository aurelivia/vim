" Vim syntax file
" Language: JavaScript
" Maintainer: Me

if !exists('main_syntax')
	if exists('b:current_syntax')
		syntax clear
	endif
	let main_syntax = 'rust'
endif

let s:cpo_save = &cpo
set cpo&vim

syntax sync fromstart
syntax case match

syntax iskeyword @,48-57,_,192-255

syn cluster rustGenericContains contains=@rustType,rustLifetime

syn match rustUpper /\<\u\k*\>/
hi def link rustUpper Type
syn match rustConstant /\<\u[[:upper:]_]*\>/
hi def link rustConstant Constant
syn match rustMacro /\<\K\k*!/
hi def link rustMacro Special

syn region rustBlock matchgroup=rustBraces start=/{/ end=/}/ contains=TOP

" syn keyword rustKeyword crate dyn move super _ unsafe where
syn keyword rustKeyword if else match
syn keyword rustKeyword for while loop
syn keyword rustKeyword break continue
syn keyword rustKeyword async await
syn keyword rustKeyword in
syn keyword rustKeyword return
syn keyword rustKeyword const static skipwhite skipempty nextgroup=rustRef,rustConstIdentifier
syn keyword rustKeyword let skipwhite skipempty nextgroup=rustMutable,rustIdentifier,rustReference
syn keyword rustKeyword enum skipwhite skipempty nextgroup=rustEnumIdentifier
syn keyword rustKeyword struct skipwhite skipempty nextgroup=rustStructIdentifier
syn keyword rustKeyword fn skipwhite skipempty nextgroup=rustFunction
syn keyword rustKeyword use mod extern skipwhite skipempty nextgroup=rustModule,rustCrate
syn keyword rustKeyword impl skipwhite skipempty nextgroup=rustTypeIdentifier
hi def link rustKeyword Statement

syn keyword rustModifier pub
syn keyword rustModifier async await
syn keyword rustModifier as skipwhite skipempty nextgroup=@rustType
hi def link rustModifier Keyword

syn keyword rustRef contained ref skipwhite skipempty nextgroup=rustIdentifier
hi def link rustRef Keyword

syn keyword rustCrate contained crate skipwhite skipempty nextgroup=rustModule
hi def link rustCrate Keyword

syn match rustIdentifier contained /\K\k*/ skipwhite skipempty nextgroup=rustTypeDef
syn match rustConstIdentifier contained /\K\k*/ skipwhite skipempty nextgroup=rustTypeDef
hi def link rustConstIdentifier Constant

" ----- LITERALS -----
syn cluster rustLiteral contains=rustBoolean,rustNumeric,rustChar,rustString
syn cluster rustPrimitive contains=@rustLiteral,rustTuple,rustArray

syn keyword rustBoolean true false
hi def link rustBoolean Boolean

syn match rustNumeric display /\<[0-9][0-9_]*\%([iu]\%(size\|8\|16\|32\|64\|128\)\)\=/
syn match rustNumeric display /\<0x[a-fA-F0-9_]\+\%([iu]\%(size\|8\|16\|32\|64\|128\)\)\=/
syn match rustNumeric display /\<0o[0-7_]\+\%([iu]\%(size\|8\|16\|32\|64\|128\)\)\=/
syn match rustNumeric display /\<0b[01_]\+\%([iu]\%(size\|8\|16\|32\|64\|128\)\)\=/
syn match rustNumeric display /\<[0-9][0-9_]*\.\%([^[:cntrl:][:space:][:punct:][:digit:]]\|_\|\.\)\@!/
syn match rustNumeric display /\<[0-9][0-9_]*\%(\.[0-9][0-9_]*\)\%([eE][+-]\=[0-9_]\+\)\=\(f32\|f64\)\=/
syn match rustNumeric display /\<[0-9][0-9_]*\%(\.[0-9][0-9_]*\)\=\%([eE][+-]\=[0-9_]\+\)\(f32\|f64\)\=/
syn match rustNumeric display /\<[0-9][0-9_]*\%(\.[0-9][0-9_]*\)\=\%([eE][+-]\=[0-9_]\+\)\=\(f32\|f64\)/
hi def link rustNumeric Number

syn match rustEscape display /\\\%(x\x\{2}\|u{[0-9a-fA-F]\{4,6}}\|.\)/
hi def link rustEscape Character
syn match rustChar display /'\%([^\\]\|\\\%(x\x\{2}\|u{[0-9a-fA-F]\{4,6}}\|.\)\)'/ contains=rustEscape
hi def link rustChar Character
syn region rustString start=/[br]\?"/ skip=/\\"/ end=/"/ extend contains=rustEscape
hi def link rustString String

syn region rustTuple matchgroup=rustTupleParens start=/(\ze\%()\|[^()]\{-},\)/ end=/)/ extend contains=TOP,rustTupleComma
hi def link rustTupleParens Operator
syn match rustTupleComma contained display /,/
hi def link rustTupleComma Operator

syn match rustApply /[a-z_]\k*\s*\ze(/ skipwhite skipempty nextgroup=rustAppliedContents
hi def link rustApply Function
syn match rustApplyMacro /\K\k*!\s*\ze(/ skipwhite skipempty nextgroup=rustAppliedContents
hi def link rustApplyMacro Special
syn region rustAppliedContents contained matchgroup=rustApplyParens start=/(/ end=/)/ extend contains=TOP

syn keyword rustMutable contained mut skipwhite skipempty nextgroup=rustIdentifier
hi def link rustMutable Keyword


syn match rustUnderscore display /[^[:keyword:]]\zs_\ze[^[:keyword:]]/
hi def link rustUnderscore Keyword

" ----- OPERATORS -----

syn match rustOperator display "[-!|&+<>=%/*^]"
syn match rustOperator display /&&\|||/
syn match rustOperator display /::/
syn match rustOperator display /\.\./
hi def link rustOperator Operator

" ----- TYPES -----

syn cluster rustType contains=rustTypeName,rustTypeTuple,rustTypeArray
syn match rustTypeName contained /\K\k*/ skipwhite skipempty nextgroup=rustTypeGeneric
hi def link rustTypeName Type

syn match rustTypeIdentifier contained /\K\k*/
hi def link rustTypeIdentifier Type
syn match rustTypeDef contained display /:/ skipwhite skipempty nextgroup=@rustType,rustTypeReference
hi def link rustTypeDef Operator

syn region rustTypeTuple contained matchgroup=rustTupleParens start=/(/ end=/)/ extend contains=@rustType,rustTupleComma

syn region rustTypeArray contained start=/\[/ end=/\]/ extend keepend contains=@rustType,rustTypeArrayDelimit
syn match rustTypeArrayDelimit contained display /;/
hi def link rustTypeArrayDelimit Operator

syn region rustTypeGeneric contained matchgroup=Operator start=/</ end=/>/ extend contains=@rustGenericContains

" ----- ENUMS -----

syn match rustEnumIdentifier contained /\K\k*/ skipwhite skipempty nextgroup=rustEnumBlock
hi def link rustEnumIdentifier Type
syn region rustEnumBlock contained start=/{/ end=/}/ extend contains=rustEnumMember
syn match rustEnumMember contained /\K\k*/ skipwhite skipempty nextgroup=rustEnumComposition
hi def link rustEnumMember Type
syn region rustEnumComposition contained matchgroup=rustOperator start=/(/ end=/)/ extend contains=@rustType

" ----- STRUCTS -----

syn match rustStructIdentifier contained /\K\k*/ skipwhite skipempty nextgroup=rustStructBlock,rustStructGeneric
hi def link rustStructIdentifier Type
syn region rustStructGeneric contained matchgroup=Operator start=/</ end=/>/ extend contains=@rustGenericContains skipwhite skipempty nextgroup=rustStructBlock
syn region rustStructBlock contained start=/{/ end=/}/ extend contains=rustTypeDef,rustStructPub
syn keyword rustStructPub contained pub
hi def link rustStructPub Keyword

" ----- FUNCTIONS -----

syn match rustFunction contained /\K\k*/ skipwhite skipempty nextgroup=rustArguments,rustFunctionGeneric
hi def link rustFunction Function
syn region rustFunctionGeneric contained matchgroup=Operator start=/</ end=/>/ extend contains=@rustGenericContains skipwhite skipempty nextgroup=rustArguments
syn region rustArguments contained start=/(/ end=/)/ extend contains=rustArgType,rustTypeReference,rustReferenceMutable skipwhite skipempty nextgroup=rustReturnType
syn match rustArgType contained display /:/ skipwhite skipempty nextgroup=@rustType,rustTypeReference
hi def link rustArgType Operator
syn match rustReturnType contained display /->/ skipwhite skipempty nextgroup=@rustType,rustTypeReference
hi def link rustReturnType Operator

" ----- REFERENCES -----

syn match rustReference contained display /&/ skipwhite skipempty nextgroup=rustReferenceMutable,rustLifetime
hi def link rustReference Keyword
syn match rustTypeReference contained display /&/ skipwhite skipempty nextgroup=rustTypeReferenceMutable,rustTypeLifetime,@rustType
hi def link rustTypeReference Keyword
syn keyword rustReferenceMutable contained mut
hi def link rustReferenceMutable Keyword
syn keyword rustTypeReferenceMutable contained mut skipwhite skipempty nextgroup=@rustType
hi def link rustTypeReferenceMutable Keyword

syn match rustLifetime contained /'[a-z][a-z0-9_]*/
syn match rustLifetime contained /'_/
hi def link rustLifetime Keyword
syn match rustTypeLifetime contained /'[a-z][a-z0-9_]*/ skipwhite skipempty nextgroup=@rustType
syn match rustTypeLifetime contained /'_/ skipwhite skipempty nextgroup=@rustType
hi def link rustTypeLifetime Keyword

" ----- ATTRIBUTES -----

syn region rustAttribute start=/#!\?\[/ end=/\]/ contains=rustString,rustDerive
hi def link rustAttribute PreProc
syn match rustDerive contained /derive\ze(/ skipwhite skipempty nextgroup=rustDerives
hi def link rustDerive Special
syn region rustDerives contained matchgroup=rustParens start=/(/ end=/)/ extend contains=rustUpper

syn match rustModule contained /\K\%(\k\|[:]\)*/
hi def link rustModule String

syn region rustComment start='//' end=/$/ contains=@Spell extend keepend containedin=ALL
hi def link rustComment Comment

" syn match rustLifetime display /'\K[^\k]*/
" hi def link rustLifetime Type
"
"
"
"
" syn keyword rustSelf self
" hi def link rustSelf Keyword
"
" syn match rustApply /\K\k*\ze\s*(/
" syn match rustApply /\K\k*::</
" hi def link rustApply Function
" syn match rustApplyMacro /\K\k*!\ze\s*(/
" hi def link rustApplyMacro Macro
"
" syn keyword rustConditional if else match
" hi def link rustConditional Statement
" syn keyword rustLoop for loop while
" hi def link rustLoop Statement
" syn keyword rustBreak break continue
" hi def link rustBreak Statement
" syn keyword rustAsync async await
" hi def link rustAsync Statement
"
" syn keyword rustStruct struct skipwhite skipempty nextgroup=rustStructIdentifier
" hi def link rustStruct Statement
" syn match rustStructIdentifier contained /\K\k*/ skipwhite skipempty nextgroup=rustStructBlock
" hi def link rustStructIdentifier Type
" syn region rustStructBlock contained matchgroup=rustBraces start=/{/ end=/}/ contains=@rustStructContains extend fold
" syn cluster rustStructContains contains=rustStructType
" syn match rustStructType contained /:\s*\zs\K\k*/
" hi def link rustStructType Type
"
" syn keyword rustEnum enum skipwhite skipempty nextgroup=rustType
" hi def link rustEnum Statement
"
" syn match rustType contained /\<\K\k*/
" hi def link rustType Type
"
" syn keyword rustFunction fn skipwhite skipempty nextgroup=rustFunctionIdentifier
" hi def link rustFunction Statement
"
" syn match rustFunctionIdentifier contained /\K\k*/ skipwhite skipempty nextgroup=rustArguments
" hi def link rustFunctionIdentifier Function
"
" syn region rustArguments contained matchgroup=rustParens start=/(/ end=/)/ contains=@rustArgumentsContains skipwhite skipempty nextgroup=rustReturnType
" syn cluster rustArgumentsContains contains=rustArgType
" syn match rustArgType contained /:/ skipwhite skipempty nextgroup=rustType
" hi def link rustArgType Operator
"
" syn match rustReturnType contained /->/ skipwhite skipempty nextgroup=rustType
" hi def link rustReturnType Operator
"
" syn keyword rustPub pub skipwhite skipempty nextgroup=rustPubScope
" hi def link rustPub Keyword
" syn region rustPubScope contained matchgroup=rustParens start=/(/ end=/)/ contains=rustScopeCrate
" syn keyword rustScopeCrate contained crate
" hi def link rustScopeCrate Keyword
"
" syn keyword rustDefinition let skipwhite skipempty nextgroup=rustDefinitionIdentifier, rustMutable
" syn keyword rustDefinitionMutable contained mut skipwhite skipempty nextgroup=rustDefinitionIdentifier
" hi def link rustDefinitionMutable Keyword
"
" syn match rustDefinitionIdentifier contained /\K\k*/ skipwhite skipempty nextgroup=rustDefinitionType
" syn match rustDefinitionType contained /:/ skipwhite skipempty nextgroup=rustType
"

let b:current_syntax = 'rust'

if main_syntax == 'rust'
	unlet main_syntax
endif

let &cpo = s:cpo_save
unlet s:cpo_save