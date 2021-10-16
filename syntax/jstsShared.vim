syntax cluster jstsPrimitive contains=jstsBoolean,jstsString,jstsTemplateLiteral,jstsNumber,jstsFloat,jstsNull
syntax cluster jstsDefaultNotObject contains=@jstsPrimitive,jstsRegExp,jstsParen,jstsBracket,jstsApply,jstsOperator,jstsTernary,jstsThis,jstsFunction,jstsArrowFunction,jstsGlobals,jstsComment,jstsClass
syntax cluster jstsDefaultBlockContains contains=@jstsNotObject,jstsBlock,jstsDefinition,jstsAsyncAwait,jstsStatement,jstsLabel,jstsConditional,jstsLoop,jstsThrow,jstsTry,jstsDelete
syntax cluster jstsDefaultExportable contains=jstsDefinition,jstsObject,jstsAsyncAwait,jstsFunction,jstsClass

syntax match jstsNoise contained /[,;:]/
syntax region jstsBlock matchgroup=jstsBraces start=/{/ end=/}/ contains=@jstsBlockContains extend fold
syntax region jstsParen matchgroup=jstsParens start=/(/ end=/)/ contains=@jstsExpression extend fold
syntax region jstsBracket matchgroup=jstsBrackets start=/\[/ end=/\]/ contains=@jstsExpression,jstsSpread extend

" syntax match jstsApply /\<[a-z_\$]\k*\ze\s*([^;]\{-})\s*\%(=>\)\@!/ skipwhite nextgroup=jstsAppliedContents
" Primitives
syntax keyword jstsBoolean true false
syntax match jstsEscaped contained /\v\\%(x\x\x|u%(\x{4}|\{\x{4,5}})|c\u|.)/
syntax region jstsString start=`\z(["']\)` skip=`\\\%(\z1\|$\)` end=`\z1\|$` contains=jstsEscaped,@Spell extend
syntax region jstsTemplateLiteral start=/`/ skip=/\\`/ end=/`/ contains=jstsEscaped,@Spell,jstsTemplateExpression extend
syntax region jstsTemplateExpression contained matchgroup=jstsBraces start=/${/ end=/}/ contains=@jstsExpression keepend
syntax match jstsTag /\<\K\k*\ze`/
syntax match jstsNumber /\c\<\%(\d\+\%(e[+-]\=\d\+\)\=\|0b[01]\+\|0o\o\+\|0x\x\+\)\>/
syntax keyword jstsNumber Infinity
syntax match jstsFloat /\c\<\%(\d\+\.\d\+\|\d\+\.\|\.\d\+\)\%(e[+-]\=\d\+\)\=\>/
syntax keyword jstsNull null undefined NaN
syntax keyword jstsThis this

" Operators
syntax keyword jstsOperator instanceof typeof in of new skipwhite skipempty nextgroup=@jstsExpression
syntax match jstsOperator /new\.target/
syntax match jstsOperator "[-!|&+<>=%/*~^]" skipwhite skipempty nextgroup=@jstsExpression
syntax region jstsTernary matchgroup=jstsTernaries start=/?\ze[^?:.]/ end=/:/ contains=@jstsExpression extend skipwhite skipempty nextgroup=@jstsExpression
syntax match jstsOperator /?\.\ze\D/
syntax match jstsOperator /??/ skipwhite skipempty nextgroup=@jstsExpression
syntax match jstsSpread /\.\.\./ skipwhite skipempty nextgroup=@jstsExpression
syntax match jstsDelete /[^.]\s*\zsdelete /
hi def link jstsDelete jstsOperator

" RegExp
syntax region jstsRegExp start=`\%(\%(\<return\|\<typeof\|\_[^)\]'"[:blank:][:alnum:]_$]\)\s*\)\@<=/\ze[^*/]` skip=`\\.\|\[[^]]\{1,}\]` end=`/[gimyus]\{,6}` contains=@jstsRegExpStuff,jstsRegExpGroup oneline keepend extend
syntax cluster jstsRegExpStuff contains=jstsEscaped,jstsRegExpBoundary,jstsRegExpBackref,jstsRegExpQuantifier,jstsRegExpOr,jstsRegExpMod,jstsRegExpCharClass
syntax region jstsRegExpGroup contained start=/[^\\](/lc=1 skip=/\\.\|\[\(\\.\|[^]]\+\)\]/ end=/)/ contains=@jstsRegExpStuff
syntax region jstsRegExpCharClass contained start=/\[/ skip=/\\./ end=/\]/ contains=jstsEscaped extend
syntax match jstsRegExpBoundary contained /\v\c[$^]|\\b/
syntax match jstsRegExpBackref contained /\v\\[1-9]\d*/
syntax match jstsRegExpQuantifier contained /\v[^\\]%([?*+]|\{\d+%(,\d*)?})\??/lc=1
syntax match jstsRegExpOr contained /|/
syntax match jstsRegExpMod contained /\v\(\?[:=!>]/lc=1

" Statements
syntax match jstsLabel /\<\K\k*\s*::\@!/ contains=jstsNoise
syntax match jstsLabelKey contained /\<\K\k*\ze\s*\_[;]/

syntax keyword jstsAsyncAwait async await
syntax keyword jstsStatement return with yield debugger
syntax keyword jstsStatement break continue skipwhite skipempty nextgroup=jstsLabelKey
syntax keyword jstsConditional if else switch
syntax region jstsCase contained matchgroup=jstsConditional start=/\<\%(case\|default\)\>/ end=/:\@=/ contains=@jstsExpression keepend
syntax keyword jstsLoop while do
syntax keyword jstsLoop for skipwhite skipempty nextgroup=jstsForStatement
syntax region jstsForStatement contained matchgroup=jstsParens start=/(/ end=/)/ extend contains=@jstsExpression,jstsDefinition
syntax keyword jstsThrow throw

syntax keyword jstsTry try skipwhite skipempty nextgroup=jstsTryCatch
syntax region jstsTryCatch contained matchgroup=jstsBraces start=/{/ end=/}/ contains=@jstsBlockContains extend fold skipwhite skipempty nextgroup=jstsCatch,jstsFinally
syntax keyword jstsCatch contained catch skipwhite skipempty nextgroup=jstsCatchArguments
syntax region jstsCatchArguments contained matchgroup=jstsArgumentParens start=/(/ end=/)/ contains=@jstsArgumentContains extend skipwhite skipempty nextgroup=jstsTryCatch
syntax keyword jstsFinally contained finally

" Functions
syntax match jstsArrowFunction /\<\K\k*\s*=>/ contains=jstsOperator skipwhite skipempty nextgroup=jstsBlock,@jstsNotObject
syntax match jstsArrowFunction /([^()]*)\s*=>/ contains=@jstsArgumentContains skipwhite skipempty nextgroup=jstsBlock,@jstsNotObject
hi def link jstsArrowFunction jstsOperator

syntax match jstsApply /\<\%(async\|await\)\@![a-z_\$]\k*\ze\s*(/ skipwhite nextgroup=jstsAppliedContents
syntax region jstsAppliedContents contained matchgroup=jstsParens start=/(/ end=/)/ contains=@jstsExpression extend
syntax match jstsArgumentComma contained /,/

" Objects
syntax region jstsObject contained matchgroup=jstsBraces start=/{/ end=/}/ contains=jstsObjectVariable,jstsObjectKey,jstsObjectKeyString,jstsObjectExpression,jstsMethodKeyword,jstsMethod,jstsSpread,jstsComment
syntax match jstsObjectKey contained /\<\K\k*\ze\s*:/ skipwhite skipempty nextgroup=jstsObjectValue
syntax region jstsObjectValue contained start=/:/ end=/[,}]\&/ extend contains=@jstsExpression
syntax region jstsObjectKeyString contained start=/\z(["']\)/ skip=/\\\z1/ end=/\z1\|$/ contains=jstsEscaped,@Spell skipwhite skipempty nextgroup=jstsObjectValue
syntax region jstsObjectExpression contained matchgroup=jstsBrackets start=/\[/ end=/\]/ extend contains=@jstsExpression skipwhite skipempty nextgroup=jstsObjectValue
syntax match jstsMethodKeyword contained /\%(get\|set\|async\)\ze\_s\+\%(\k\|\[\)/ skipwhite skipempty nextgroup=jstsFunctionIdentifier,jstsObjectExpression
hi def link jstsMethodKeyword Keyword
syntax match jstsMethod contained /\<\K\k*\ze\_s*(/ skipwhite skipempty nextgroup=jstsArguments

" Destructuring
syntax region jstsObjectDestructure contained matchgroup=jstsBraces start=/{/ end=/}/ extend contains=jstsDestructureProp,jstsDestructureExpression
syntax region jstsArrayDestructurshke contained matchgroup=jstsBrackets start=/\[/ end=/\]/ extend
syntax match jstsDestructureValue contained /\k\+/
syntax match jstsDestructureProp contained /\k\+\ze\s*=/ skipwhite skipempty nextgroup=jstsDestructureDefault
syntax match jstsDestructureProp contained /\k\+\ze\s*:/ skipwhite skipempty nextgroup=jstsDestructureAssignment
syntax region jstsDestructureExpression contained matchgroup=jstsBrackets start=/\[/ end=/\]/ contains=@jstsExpression skipwhite skipempty nextgroup=jstsDestructureAssignment,jstsDestructureDefault extend
syntax region jstsDestructureAssignment contained start=/:/ end=/[,}=]\&/ contains=jstsDestructureValue extend skipwhite skipempty nextgroup=jstsDestructureDefault
syntax region jstsDestructureDefault contained start=/=/ end=/[,}\]]\&/ contains=@jstsExpression extend

" Classes
syntax keyword jstsClassExtends contained extends skipwhite skipempty nextgroup=jstsExtendsName
syntax match jstsExtendsName contained /\<\K\k*/ skipwhite skipempty nextgroup=jstsClassBody

" Modules
syntax keyword jstsModule import skipwhite skipempty nextgroup=jstsModuleAny,jstsModuleIdentifier,jstsModuleObject
syntax keyword jstsModule export skipwhite skipempty nextgroup=@jstsExportable,jstsModuleDefault,jstsModuleAny,jstsModuleIdentifier,jstsModuleObject
syntax match jstsModuleIdentifier contained /\<\K\k*/ skipwhite skipempty nextgroup=jstsModuleAs,jstsModuleFrom
syntax match jstsModuleAny contained /\*/ skipwhite skipempty nextgroup=jstsModuleAs,jstsModuleFrom
syntax keyword jstsModuleAs contained as skipwhite skipempty nextgroup=jstsModuleIdentifier
syntax keyword jstsModuleFrom contained from
syntax keyword jstsModuleDefault contained default skipwhite skipempty nextgroup=@jstsExpression,jstsObject
hi def link jstsModuleDefault Keyword
syntax region jstsModuleObject contained matchgroup=jstsBraces start=/{/ end=/}/ extend fold contains=jstsModuleIdentifier,jstsComment skipwhite skipempty nextgroup=jstsModuleFrom

" Globals
syntax keyword jstsGlobals arguments console document fetch window module exports global process __dirname __filename decodeURI decodeURIComponent encodeURI encodeURIComponent eval isFinite isNaN parseFloat parseInt Error EvalError InternalError RangeError ReferenceError StopIteration SyntaxError TypeError URIError

" Comments
syntax region jstsComment start='//' end=/$/ contains=@Spell extend keepend
syntax region jstsComment start='/\*' end='\*/' contains=@Spell extend keepend fold
syntax region jstsComment start=/\%^#!/ end=/$/ display
hi def link jstsComment Comment





hi def link jstsApply Function
hi def link jstsApplyBrackets Function
hi def link jstsAppliedProp jstsApply
hi def link jstsArgumentComma jstsFunction
hi def link jstsArgumentParens jstsFunction
hi def link jstsAsyncAwait Keyword
hi def link jstsBoolean Boolean
hi def link jstsBraces Noise
hi def link jstsBracketsApply jstsApply
hi def link jstsCatch jstsTry
hi def link jstsClass Statement
hi def link jstsClassExtends jstsClass
hi def link jstsClassKeyword Keyword
hi def link jstsClassName jstsType
hi def link jstsConditional Conditional
hi def link jstsCustomConstant Constant
hi def link jstsDefinition Statement
" hi def link jstsDefinition jstsStorageClass
hi def link jstsEscaped Special
hi def link jstsEvents Constant
hi def link jstsExtendsName jstsClassName
hi def link jstsFinally jstsTry
hi def link jstsFloat jstsNumber
hi def link jstsFunction Statement
hi def link jstsFunctionIdentifier Function
hi def link jstsGlobals Constant
hi def link jstsLabel Keyword
hi def link jstsLabelKey jstsLabel
hi def link jstsLoop Repeat
hi def link jstsMethod jstsFunctionIdentifier
hi def link jstsMethodKeyword Keyword
" hi def link jstsModule Include
hi def link jstsModule Statement
hi def link jstsModuleAny Noise
hi def link jstsModuleAs jstsModule
hi def link jstsModuleComma Noise
hi def link jstsModuleFrom jstsModule
hi def link jstsNoise Noise
hi def link jstsNull Boolean
hi def link jstsNumber Number
hi def link jstsObjectKeyString String
hi def link jstsObjectFunction Function
hi def link jstsOperator Operator
hi def link jstsParens Noise
hi def link jstsPrivateField Special
hi def link jstsProto Constant
hi def link jstsRegExp String
hi def link jstsRegExpBackref SpecialChar
hi def link jstsRegExpBoundary SpecialChar
hi def link jstsRegExpCharClass Character
hi def link jstsRegExpGroup jstsRegExp
hi def link jstsRegExpMod SpecialChar
hi def link jstsRegExpOr Conditional
hi def link jstsRegExpQuantifier SpecialChar
hi def link jstsSpread Operator
hi def link jstsStatement Statement
hi def link jstsString String
hi def link jstsTag Keyword
hi def link jstsTemplateLiteral jstsString
hi def link jstsTernaries jstsOperator
hi def link jstsThis Keyword
hi def link jstsThrow Exception
hi def link jstsTry Exception
hi def link jstsType Type