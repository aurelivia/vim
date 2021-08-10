" Vim syntax file
" Language: JavaScript
" Maintainer: Me

if !exists('main_syntax')
	if exists('b:current_syntax')
		finish
	endif
	let main_syntax = 'javascript'
endif

syntax sync fromstart
syntax case match

syntax cluster jsNotObject contains=jsParen,jsBracket,jsType,jsVariable,jsApply,jsDot,jsOperator,jsTernary,jsBoolean,jsString,jsTemplateLiteral,jsTag,jsNumber,jsFloat,jsNull,jsThis,jsRegExp,jsFunction,jsArrowFunction,jsGlobals,jsComment,jsCustomConstant
syntax cluster jsExpression contains=@jsNotObject,jsObject
syntax cluster jsBlockContains contains=@jsNotObject,jsBlock,jsDefinition,jsAsyncAwait,jsStatement,jsLabel,jsConditional,jsLoop,jsThrow,jsTry
syntax cluster jsAny contains=@jsBlockContains,jsObject

syntax match jsNoise contained /[,;:]/
syntax region jsBlock matchgroup=jsBraces start=/{/ end=/}/ contains=@jsBlockContains extend fold
syntax region jsParen matchgroup=jsParens start=/(/ end=/)/ contains=@jsExpression extend fold
syntax region jsBracket matchgroup=jsBrackets start=/\[/ end=/\]/ contains=@jsExpression,jsSpread extend

" Variables
syntax match jsPlain contained /\<\K\k*/
syntax match jsType /\<\u\k*/
syntax match jsApply /\<[a-z_\$]\k*\ze\s*(/ nextgroup=jsAppliedContents
syntax match jsAppliedProp contained /\<\K\k*\ze\s*(/ nextgroup=jsAppliedContents
syntax region jsAppliedContents contained matchgroup=jsParens start=/(/ end=/)/ contains=@jsExpression extend
" syntax region jsApply start=/\<\K\k*\ze\s*\[/ end=/\ze\]\s*(/ contains=jsAppliedProp extend
" syntax region jsAppliedProp contained matchgroup=jsBracketsApply start=/\[/ end=/\]/ contains=@jsExpression skipwhite skipempty nextgroup=jsAppliedProp extend
syntax match jsDot /\./ skipwhite skipempty nextgroup=jsAppliedProp,jsTag,jsProto,jsPlain
syntax keyword jsProto contained prototype __proto__

syntax keyword jsOperator delete instanceof typeof void in of skipwhite skipempty nextgroup=@jsExpression
syntax match jsOperator /new\%(\.target\)\?/ skipwhite skipempty nextgroup=@jsExpression
syntax match jsOperator "[-!|&+<>=%/*~^]" skipwhite skipempty nextgroup=@jsExpression
syntax region jsTernary matchgroup=jsTernaries start=/?:\@!/ end=/\%(:\|}\@=\)/ contains=@jsExpression skipwhite skipempty nextgroup=@jsExpression extend
highlight jsTernary NONE
highlight link jsTernary NONE
syntax match jsOperator /?\.\ze\_D/
syntax match jsOperator /??/ skipwhite skipempty nextgroup=@jsExpression
syntax match jsSpread /\.\.\./ skipwhite skipempty nextgroup=@jsExpression

" Primitives
syntax keyword jsBoolean true false
syntax match jsEscaped contained /\v\\%(x\x\x|u%(\x{4}|\{\x{4,5}})|c\u|.)/
syntax region jsString start=`\z(["']\)` skip=`\\\%(\z1\|$\)` end=`\z1\|$` contains=jsEscaped,@Spell extend
syntax region jsTemplateLiteral start=/`/ skip=/\\`/ end=/`/ contains=jsEscaped,@Spell,jsTemplateExpression extend
syntax region jsTemplateExpression contained matchgroup=jsBraces start=/${/ end=/}/ contains=@jsExpression keepend
syntax match jsTag /\<\K\k*\ze`/
syntax match jsNumber /\c\<\%(\d\+\%(e[+-]\=\d\+\)\=\|0b[01]\+\|0o\o\+\|0x\x\+\)\>/
syntax keyword jsNumber Infinity
syntax match jsFloat /\c\<\%(\d\+\.\d\+\|\d\+\.\|\.\d\+\)\%(e[+-]\=\d\+\)\=\>/
syntax keyword jsNull null undefined NaN
syntax keyword jsThis this

" RegExp
syntax region jsRegExp start=`\%(\%(\<return\|\<typeof\|\_[^)\]'"[:blank:][:alnum:]_$]\)\s*\)\@<=/\ze[^*/]` skip=`\\.\|\[[^]]\{1,}\]` end=`/[gimyus]\{,6}` contains=@jsRegExpStuff,jsRegExpGroup oneline keepend extend
syntax cluster jsRegExpStuff contains=jsEscaped,jsRegExpBoundary,jsRegExpBackref,jsRegExpQuantifier,jsRegExpOr,jsRegExpMod,jsRegExpCharClass
syntax region jsRegExpGroup contained start=/[^\\](/lc=1 skip=/\\.\|\[\(\\.\|[^]]\+\)\]/ end=/)/ contains=@jsRegExpStuff
syntax region jsRegExpCharClass contained start=/\[/ skip=/\\./ end=/\]/ contains=jsEscaped extend
syntax match jsRegExpBoundary contained /\v\c[$^]|\\b/
syntax match jsRegExpBackref contained /\v\\[1-9]\d*/
syntax match jsRegExpQuantifier contained /\v[^\\]%([?*+]|\{\d+%(,\d*)?})\??/lc=1
syntax match jsRegExpOr contained /|/
syntax match jsRegExpMod contained /\v\(\?[:=!>]/lc=1

" Objects
syntax region jsObject contained matchgroup=jsBraces start=/{/ end=/}/ contains=jsObjectVariable,jsObjectKey,jsObjectKeyString,jsObjectkeyExpression,jsObjectFunction,jsSpread extend fold
syntax region jsObjectValue contained start=/:/ end=/[,}]\&/ contains=@jsExpression extend
syntax match jsObjectVariable contained /\k*\ze\s*[,}]/
syntax match jsObjectKey contained /\<\k*\s*\ze\s*:/ contains=jsEvents skipwhite skipempty nextgroup=jsObjectValue
syntax region jsObjectKeyString contained start=`\z(["']\)` skip=`\\\%(\z1\|$\)` end=`\z1\|$` contains=jsEscaped,@Spell skipwhite skipempty nextgroup=jsObjectValue
syntax region jsObjectKeyExpression contained matchgroup=jsBrackets start=/\[/ end=/\]/ contains=@jsExpression skipwhite skipempty nextgroup=jsObjectValue
syntax match jsObjectFunction contained /\<\K\k*\ze\_s*(/ skipwhite skipempty nextgroup=jsArguments

" Destructuring
syntax region jsObjectDestructure contained matchgroup=jsBraces start=/{/ end=/}/ extend contains=jsDestructureProp,jsDestructureExpression
syntax region jsArrayDestructure contained matchgroup=jsBrackets start=/\[/ end=/\]/ extend
syntax match jsDestructureValue contained /\k\+/
syntax match jsDestructureProp contained /\k\+\ze\s*=/ skipwhite skipempty nextgroup=jsDestructureDefault
syntax match jsDestructureProp contained /\k\+\ze\s*:/ skipwhite skipempty nextgroup=jsDestructureAssignment
syntax region jsDestructureExpression contained matchgroup=jsBrackets start=/\[/ end=/\]/ contains=@jsExpression skipwhite skipempty nextgroup=jsDestructureAssignment,jsDestructureDefault extend
syntax region jsDestructureAssignment contained start=/:/ end=/[,}=]\&/ contains=jsDestructureValue extend skipwhite skipempty nextgroup=jsDestructureDefault
syntax region jsDestructureDefault contained start=/=/ end=/[,}\]]\&/ contains=@jsExpression extend

" Statements
syntax keyword jsDefinition const var let skipwhite skipempty nextgroup=jsObjectDestructure,jsArrayDestructure,jsType,jsPlain
syntax keyword jsAsyncAwait async await
syntax match jsLabel /\<\K\k*\s*::\@!/ contains=jsNoise
syntax match jsLabelKey contained /\<\K\k*\ze\s*\_[;]/
syntax keyword jsStatement return with yield debugger
syntax keyword jsStatement break continue skipwhite skipempty nextgroup=jsLabelKey
syntax keyword jsConditional if else switch
syntax region jsCase contained matchgroup=jsConditional start=/\<\%(case\|default\)\>/ end=/:\@=/ contains=@jsExpression keepend
syntax keyword jsLoop while do
syntax keyword jsLoop for skipwhite skipempty nextgroup=jsForStatement
syntax region jsForStatement contained matchgroup=jsParens start=/(/ end=/)/ extend contains=@jsExpression,jsDefinition
syntax keyword jsThrow throw

syntax keyword jsTry try skipwhite skipempty nextgroup=jsTryCatch
syntax region jsTryCatch contained matchgroup=jsBraces start=/{/ end=/}/ contains=@jsBlockContains extend fold skipwhite skipempty nextgroup=jsCatch,jsFinally
syntax keyword jsCatch contained catch skipwhite skipempty nextgroup=jsCatchArguments
syntax region jsCatchArguments contained matchgroup=jsArgumentParens start=/(/ end=/)/ contains=@jsArgumentContains extend skipwhite skipempty nextgroup=jsTryCatch
syntax keyword jsFinally contained finally

" Modules
syntax keyword jsModule import skipwhite skipempty nextgroup=jsModuleAny,jsModuleKeyword,jsModuleObject
syntax keyword jsModule export skipwhite skipempty nextgroup=@jsAny,jsModuleAny,jsModuleKeyword,jsModuleObject,jsModuleDefault
syntax match jsModuleAny contained /\*/ skipwhite skipempty nextgroup=jsModuleKeyword,jsModuleAs,jsModuleFrom
syntax match jsModuleComma contained /,/ skipwhite skipempty nextgroup=jsModuleKeyword,jsModuleAny,jsModuleObject
syntax keyword jsModuleAs contained as skipwhite skipempty nextgroup=jsModuleKeyword
syntax keyword jsModuleFrom contained from
syntax keyword jsModuleDefault contained default skipwhite skipempty nextgroup=@jsExpression
syntax keyword jsModuleDefaultObject contained default skipwhite skipempty nextgroup=jsModuleAs,jsModuleComma,jsModuleFrom
syntax match jsModuleKeyword contained /\<\K\k*/ skipwhite skipempty nextgroup=jsModuleAs,jsModuleFrom,jsModuleComma
syntax region jsModuleObject contained matchgroup=jsBraces start=/{/ end=/}/ contains=jsModuleKeyword,jsModuleComma,jsModuleAs,jsComment skipwhite skipempty nextgroup=jsModuleFrom fold

" Functions
syntax keyword jsFunction function skipwhite skipempty nextgroup=jsFunctionGenerator,jsFunctionIdentifier,jsArguments
syntax match jsFunctionGenerator contained /\*/ skipwhite skipempty nextgroup=jsFunctionIdentifier,jsArguments
syntax match jsFunctionIdentifier contained /\<\K\k*/ skipwhite skipempty nextgroup=jsArguments
syntax cluster jsArgumentContains contains=jsArgumentComma,jsArgumentDefault,jsObjectDestructure,jsArrayDestructure,jsSpread
syntax region jsArguments contained matchgroup=jsArgumentParens start=/(/ end=/)/ contains=@jsArgumentContains skipwhite skipempty nextgroup=jsBlock extend
syntax match jsArgumentComma contained /,/

syntax match jsArrowFunction /\<\K\k*\s*=>/ contains=jsOperator skipwhite skipempty nextgroup=jsBlock,@jsNotObject
syntax match jsArrowFunction /([^()]*)\s*=>/ contains=jsArguments,jsOperator extend skipwhite skipempty nextgroup=jsBlock,@jsNotObject
highlight jsArrowFunction NONE

syntax keyword jsGlobals arguments console document fetch window module exports global process __dirname __filename decodeURI decodeURIComponent encodeURI encodeURIComponent eval isFinite isNaN parseFloat parseInt Error EvalError InternalError RangeError ReferenceError StopIteration SyntaxError TypeError URIError

syntax match jsEvents /\<on\k*/

syntax region jsComment start='//' end=/$/ contains=@Spell extend keepend
syntax region jsComment start='/\*' end='\*/' contains=@Spell extend keepend fold
syntax region jsComment start=/\%^#!/ end=/$/ display

if !exists("jsSyntaxInit")
	hi def link jsApply Function
	hi def link jsApplyBrackets Function
	hi def link jsAppliedProp jsApply
	hi def link jsArgumentComma jsFunction
	hi def link jsArgumentParens jsFunction
	hi def link jsAsyncAwait Keyword
	hi def link jsBoolean Boolean
	hi def link jsBraces Noise
	hi def link jsBracketsApply jsApply
	hi def link jsCatch jsTry
	hi def link jsComment Comment
	hi def link jsConditional Conditional
	" hi def link jsDefinition StorageClass
	hi def link jsCustomConstant Constant
	hi def link jsDefinition jsStorageClass
	hi def link jsEscaped Special
	hi def link jsEvents Constant
	hi def link jsFinally jsTry
	hi def link jsFloat jsNumber
	hi def link jsFunction Statement
	hi def link jsFunctionIdentifier Function
	hi def link jsGlobals Constant
	hi def link jsLabel Keyword
	hi def link jsLabelKey jsLabel
	hi def link jsLoop Repeat
	" hi def link jsModule Include
	hi def link jsModule jsModules
	hi def link jsModuleAny Noise
	hi def link jsModuleAs jsModule
	hi def link jsModuleComma Noise
	hi def link jsModuleDefault jsModule
	hi def link jsModuleDefaultObject jsModuleDefault
	hi def link jsModuleFrom jsModule
	hi def link jsNoise Noise
	hi def link jsNull Boolean
	hi def link jsNumber Number
	hi def link jsObjectKeyString String
	hi def link jsObjectFunction Function
	hi def link jsOperator Operator
	hi def link jsParens Noise
	hi def link jsProto Constant
	hi def link jsRegExp String
	hi def link jsRegExpBackref SpecialChar
	hi def link jsRegExpBoundary SpecialChar
	hi def link jsRegExpCharClass Character
	hi def link jsRegExpGroup jsRegExp
	hi def link jsRegExpMod SpecialChar
	hi def link jsRegExpOr Conditional
	hi def link jsRegExpQuantifier SpecialChar
	hi def link jsSpread Operator
	hi def link jsStatement Statement
	hi def link jsString String
	hi def link jsTag Keyword
 	hi def link jsTemplateLiteral jsString
	hi def link jsTernaries jsOperator
	hi def link jsThis Keyword
	hi def link jsThrow Exception
	hi def link jsTry Exception
	hi def link jsType Type
endif

let b:current_syntax = 'javascript'

if main_syntax == 'javascript'
	unlet main_syntax
endif