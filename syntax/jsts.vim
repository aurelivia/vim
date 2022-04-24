syntax iskeyword @,48-57,_,192-255,$

syn cluster jstsNotObject contains=@jstsLiterals,jstsUpper,jstsRegExp,jstsParen,jstsBracket,jstsApply,jstsOperator,jstsTernary,jstsThis,jstsFunction,jstsArrowFunction,jstsGlobals,jstsClass,tsxTag
syn cluster jstsExpression contains=@jstsNotObject,jstsGenericArrow,jstsObject,jstsAppliedType,jstsCast
syn cluster jstsBlockContains contains=@jstsNotObject,jstsBlock,jstsDefinition,jstsAsync,jstsAwait,jstsStatement,jstsLabel,jstsConditional,jstsLoop,jstsThrow,jstsTry,jstsDelete,jstsAppliedType,jstsNamespace,jstsAbstract,jstsCast,jstsGenericArrow
syn cluster jstsNoComment contains=jstsComment,jstsString,jstsTemplateLiteral,jstsRegExp,jstsRegExpGroup,jstsRegExpCharClass,jstsObjectKeyString

syn region jstsBlock matchgroup=jstsBraces start=/{/ end=/}/ contains=@jstsBlockContains extend fold
hi def link jstsBraces Noise
syn region jstsParen matchgroup=jstsParens start=/(/ end=/)/ contains=@jstsExpression extend fold
hi def link jstsParens Noise
syn region jstsBracket matchgroup=jstsBrackets start=/\[/ end=/\]/ contains=@jstsExpression,jstsSpread extend
hi def link jstsBrackets Noise
syn keyword jstsThis this
hi def link jstsThis Keyword

syn match jstsApply /\<\%(async\|await\)\@![a-z_\$]\k*\ze\s*(/ skipwhite skipempty nextgroup=jstsAppliedContents
hi def link jstsApply Function
syn region jstsAppliedContents contained matchgroup=jstsParens start=/(/ end=/)/ contains=@jstsExpression extend

syn match jstsUpper /\<\u\k*/
hi def link jstsUpper Type

" Primitives

syn cluster jstsLiterals contains=jstsBoolean,jstsString,jstsTemplateLiteral,jstsNumber,jstsFloat,jstsNull
syn keyword jstsBoolean true false
hi def link jstsBoolean Boolean
syn match jstsEscaped contained /\v\\%(x\x\x|u%(\x{4}|\{\x{4,5}})|c\u|.)/
hi def link jstsEscaped Special
syn region jstsString start=`\z(["']\)` skip=`\\\%(\z1\|$\)` end=`\z1\|$` contains=jstsEscaped extend
hi def link jstsString String
syn region jstsTemplateLiteral start=/`/ skip=/\\`/ end=/`/ contains=jstsEscaped,jstsTemplateExpression extend
hi def link jstsTemplateLiteral String
syn region jstsTemplateExpression contained matchgroup=jstsBraces start=/${/ end=/}/ contains=@jstsExpression
syn match jstsTag /\<\K\k*\ze`/
hi def link jstsTag Keyword
syn match jstsNumber /\c\<\%(\d\+\%(e[+-]\=\d\+\)\=\|0b[01]\+\|0o\o\+\|0x\x\+\)\>/
syn keyword jstsNumber Infinity
hi def link jstsNumber Number
syn match jstsFloat /\c\<\%(\d\+\.\d\+\|\d\+\.\|\.\d\+\)\%(e[+-]\=\d\+\)\=\>/
hi def link jstsFloat Number
syn keyword jstsNull null undefined NaN
hi def link jstsNull Boolean

" Operators

syn region jstsTernary matchgroup=jstsTernaries start=/?\ze[^?:.]/ end=/:/ contains=@jstsExpression extend skipwhite skipempty nextgroup=@jstsExpression
hi def link jstsTernaries Operator
syn keyword jstsOperator instanceof typeof in of new skipwhite skipempty nextgroup=@jstsExpression
syn match jstsOperator /new\.target/
syn match jstsOperator "[-!|&+<>=%/*~^]" skipwhite skipempty nextgroup=@jstsExpression
syn match jstsOperator /?\.\ze\D/
syn match jstsOperator /??/ skipwhite skipempty nextgroup=@jstsExpression
hi def link jstsOperator Operator
syn match jstsSpread /\.\.\./ skipwhite skipempty nextgroup=@jstsExpression
hi def link jstsSpread Operator
syn match jstsDelete /[^.]\s*\zsdelete /
hi def link jstsDelete Operator

" RegExp

syn region jstsRegExp start=`\%(\%(\<return\|\<typeof\|\_[^)\]'"[:blank:][:alnum:]_$]\)\s*\)\@<=/\ze[^*/]` skip=`\\.\|\[[^]]\{1,}\]` end=`/` contains=@jstsRegExpStuff,jstsRegExpGroup oneline keepend extend skipwhite skipempty nextgroup=jstsRegExpMods
hi def link jstsRegExp String
syn match jstsRegExpMods contained /[gimyus]\{,6}/
hi def link jstsRegExpMods jstsEscaped
syn cluster jstsRegExpStuff contains=jstsEscaped,jstsRegExpGroup,jstsRegExpBoundary,jstsRegExpBackref,jstsRegExpQuantifier,jstsRegExpOr,jstsRegExpMod,jstsRegExpCharClass
syn region jstsRegExpGroup contained matchgroup=SpecialChar start=/[^\\](/lc=1 skip=/\\.\|\[\(\\.\|[^]]\+\)\]/ end=/)/ contains=@jstsRegExpStuff
syn region jstsRegExpCharClass contained matchgroup=SpecialChar start=/\[/ skip=/\\./ end=/\]/ contains=jstsEscaped extend
hi def link jstsRegExpCharClass Character
syn match jstsRegExpBoundary contained /\v\c[$^]|\\b/
hi def link jstsRegExpBoundary SpecialChar
syn match jstsRegExpBackref contained /\v\\[1-9]\d*/
hi def link jstsRegExpBackref SpecialChar
syn match jstsRegExpQuantifier contained /\v[^\\]%([?*+]|\{\d+%(,\d*)?})\??/lc=1
hi def link jstsRegExpQuantifier Operator
syn match jstsRegExpOr contained /|/
hi def link jstsRegExpOr Conditional
syn match jstsRegExpMod contained /\v\(\?[:=!>]/lc=1
hi def link jstsRegExpMod Operator

" STatements

syn match jstsLabel /\<\K\k*\s*\ze:/
hi def link jstsLabel Keyword
syn match jstsLabelKey contained /\<\K\k*\ze\s*\_[;]/
hi def link jstsLabelKey Keyword

syn keyword jstsStatement yield debugger
syn keyword jstsStatement return with skipwhite skipempty nextgroup=@jstsExpression
syn keyword jstsStatement break continue skipwhite skipempty nextgroup=jstsLabelKey
hi def link jstsStatement Statement
syn keyword jstsConditional if else switch
hi def link jstsConditional Statement
syn region jstsCase contained matchgroup=jstsConditional start=/\<\%(case\|default\)\>/ end=/:\@=/ contains=@jstsExpression keepend
hi def link jstsCase Statement
syn keyword jstsLoop while do
syn keyword jstsLoop for skipwhite skipempty nextgroup=jstsForStatement
hi def link jstsLoop Statement
syn region jstsForStatement contained matchgroup=jstsParens start=/(/ end=/)/ extend contains=@jstsExpression,jstsDefinition

syn keyword jstsTry try skipwhite skipempty nextgroup=jstsTryCatch
hi def link jstsTry Statement
syn keyword jstsThrow throw
hi def link jstsThrow Exception
syn region jstsTryCatch contained matchgroup=jstsBraces start=/{/ end=/}/ contains=@jstsBlockContains extend fold skipwhite skipempty nextgroup=jstsCatch,jstsFinally
syn keyword jstsCatch contained catch skipwhite skipempty nextgroup=jstsCatchArguments
hi def link jstsCatch Statement
syn region jstsCatchArguments contained matchgroup=jstsArgumentParens start=/(/ end=/)/ contains=@jstsArgumentsContains extend skipwhite skipempty nextgroup=jstsTryCatch
syn keyword jstsFinally contained finally
hi def link jstsFinally Statement

syn keyword jstsDeclare declare
hi def link jstsDeclare Keyword
syn keyword jstsAbstract contained abstract
hi def link jstsAbstract Keyword

" Definition

syn keyword jstsDefinition const var let skipwhite skipempty nextgroup=jstsDefinitionLower,jstsDefinitionUpper
hi def link jstsDefinition Statement
syn match jstsDefinitionLower contained /\<\K\k*/ skipwhite skipempty nextgroup=jstsDefinitionType
syn match jstsDefinitionUpper contained /\<\u\k*/ skipwhite skipempty nextgroup=jstsDefinitionType
hi def link jstsDefinitionUpper Type
syn match jstsDefinitionType contained /:/ skipwhite skipempty nextgroup=@jstsType
hi def link jstsDefinitionType Operator

" Functions

syn cluster jstsArgumentsContains contains=jstsArgument,jstsArgumentComma,jstsSpread

syn match jstsFunction /function\*\?/ skipwhite skipempty nextgroup=jstsFunctionIdentifierLower,jstsFunctionIdentifierUpper,jstsFunctionGenerics,jstsArguments
hi def link jstsFunction Statement
syn match jstsFunctionIdentifierLower contained /\<\K\k*/ skipwhite skipempty nextgroup=jstsFunctionGenerics,jstsArguments
hi def link jstsFunctionIdentifierLower Function
syn match jstsFunctionIdentifierUpper contained /\<\u\k*/ skipwhite skipempty nextgroup=jstsFunctionGenerics,jstsArguments
hi def link jstsFunctionIdentifierUpper Type

syn keyword jstsAsync async skipwhite skipempty nextgroup=jstsFunction,jstsArguments
hi def link jstsAsync Keyword
syn keyword jstsAwait await
hi def link jstsAwait Keyword

" syn region jstsArrowFunction matchgroup=jstsArgumentParens start=`(\ze\%(/\*.\{-}\*/\)\?\_s*\%(\%([^()]\+\>?\?:\)\|\%([^():?]*)\_s*\%(=>\|?\?:\)\)\)` end=/)/ extend contains=@jstsArgumentsContains skipwhite skipempty nextgroup=jstsReturnType,jstsArrow
syn match jstsArrow /=>/ skipwhite skipempty nextgroup=jstsBlock,@jstsNotObject
hi def link jstsArrow Operator
syn region jstsGenericArrowFunction matchgroup=jstsArgumentParens start=/<\ze\%(\k\|,\)\{-1,}>\s*(/ end=/>/ extend contains=@jstsGenericContains skipwhite skipempty nextgroup=jstsArrowFunction

syn match jstsReturnType contained /:/ skipwhite skipempty nextgroup=@tsTypeNoFn
hi def link jstsReturnType Operator
syn region jstsFunctionGenerics contained matchgroup=jstsArgumentParens start=/</ end=/>/ contains=@jstsGenericContains skipwhite skipempty nextgroup=jstsArguments

syn region jstsArguments contained matchgroup=jstsArgumentParens start=/(/ end=/)/ contains=@jstsArgumentsContains skipwhite skipempty nextgroup=jstsTypeObjectColon,jstsBlock
hi def link jstsArgumentParens Operator
syn match jstsArgument contained /\<\K\k*/ skipwhite skipempty nextgroup=jstsTypeObjectColon,jstsArgumentDefault
syn match jstsArgumentComma contained /,/
hi def link jstsArgumentComma Operator
syn match jstsArgumentDefault contained /=/ skipwhite skipempty nextgroup=@jstsExpression
hi def link jstsArgumentDefault Operator

" Objects

syn region jstsObject contained matchgroup=jstsBraces start=/{/ end=/}/ extend contains=jstsObjectKeyString,jstsObjectKey,jstsObjectExpression,jstsMethodKeyword,jstsMethod,jstsSpread,jstsComment
syn match jstsObjectKey contained /\<\K\k*\ze\s*:/ skipwhite skipempty nextgroup=jstsObjectValue
syn region jstsObjectValue contained start=/:/ end=/[,}]\&/ extend contains=@jstsExpression
syn region jstsObjectKeyString contained start=`\z(["']\)` skip=`\\\%(\z1\|$\)` end=`\z1\|$` contains=jstsEscaped extend skipempty skipwhite nextgroup=jstsObjectValue
hi def link jstsObjectKeyString String
syn region jstsObjectExpression contained matchgroup=jstsBrackets start=/\[/ end=/\]/ extend contains=@jstsExpression skipwhite skipempty nextgroup=jstsObjectValue
syn match jstsMethodKeyword contained /\%(get\|set\|async\)\ze\_s\+\%(\k\|\[\)/ skipwhite skipempty nextgroup=jstsFunctionIdentifierLower,jstsFunctionIdentifierUpper,jstsObjectExpression
hi def link jstsMethodKeyword Keyword
syn match jstsMethod contained /\<\K\k*\ze\_s*(/ skipwhite skipempty nextgroup=jstsArguments
hi def link jstsMethod Function

" Destructuring

syn region jstsObjectDestructure contained matchgroup=jstsBraces start=/{/ end=/}/ extend contains=jstsDestructureProp,jstsDestructureExpression
syn region jstsArrayDestructure contained matchgroup=jstsBrackets start=/\[/ end=/\]/ extend
syn match jstsDestructureValue contained /\k\+/
syn match jstsDestructureProp contained /\k\+\ze\s*=/ skipwhite skipempty nextgroup=jstsDestructureDefault
syn match jstsDestructureProp contained /\k\+\ze\s*:/ skipwhite skipempty nextgroup=jstsDestructureAssignment
syn region jstsDestructureExpression contained matchgroup=jstsBrackets start=/\[/ end=/\]/ contains=@jstsExpression skipwhite skipempty nextgroup=jstsDestructureAssignment,jstsDestructureDefault extend
syn region jstsDestructureAssignment contained start=/:/ end=/[,}=]\&/ contains=jstsDestructureValue extend skipwhite skipempty nextgroup=jstsDestructureDefault
syn region jstsDestructureDefault contained start=/=/ end=/[,}\]]\&/ contains=@jstsExpression extend

" Modules

syn keyword jstsModule import skipwhite skipempty nextgroup=jstsModuleStar,jstsModuleIdentifier,jstsModuleObject,jstsModuleImportType
syn keyword jstsModule export skipwhite skipempty nextgroup=jstsDefinition,jstsAsync,jstsFunction,jstsClass,jstsModuleDefault,jstsModuleStar,jstsModuleIdentifier,jstsModuleObject,jstsModuleExportType
hi def link jstsModule Statement
syn match jstsModuleIdentifier contained /\<\K\k*/ skipwhite skipempty nextgroup=jstsModuleAs,jstsModuleFrom
syn region jstsModuleObject contained matchgroup=jstsBraces start=/{/ end=/}/ extend fold contains=jstsModuleIdentifier,jstsModuleDefaultAs skipwhite skipempty nextgroup=jstsModuleFrom
syn match jstsModuleStar contained /\*/ skipwhite skipempty nextgroup=jstsModuleAs,jstsModuleFrom
hi def link jstsModuleStar Keyword

syn keyword jstsModuleAs contained as skipwhite skipempty nextgroup=jstsModuleIdentifier
hi def link jstsModuleAs Statement
syn keyword jstsModuleFrom contained from
hi def link jstsModuleFrom Statement
syn keyword jstsModuleDefault contained default skipwhite skipempty nextgroup=@jstsExpression,jstsObject
hi def link jstsModuleDefault Keyword
syn keyword jstsModuleDefaultAs contained default skipwhite skipempty nextgroup=jstsModuleAs
hi def link jstsModuleDefaultAs Keyword

syn keyword jstsModuleImportType contained type skipwhite skipempty nextgroup=jstsModuleStar,jstsModuleIdentifierType,jstsModuleObjectType
hi def link jstsModuleImportType Statement
syn keyword jstsModuleExportType contained type skipwhite skipempty nextgroup=jstsTypedefIdentifier,jstsModuleStar,jstsModuleObjectType
hi def link jstsModuleExportType Statement
syn match jstsModuleIdentifierType contained /\<\K\k*/ skipwhite skipempty nextgroup=jstsModuleAsType,jstsModuleFrom
hi def link jstsModuleIdentifierType Type
syn keyword jstsModuleAsType contained as skipwhite skipempty nextgroup=jstsModuleIdentifierType
hi def link jstsModuleAsType Statement
syn region jstsModuleObjectType contained matchgroup=jstsBraces start=/{/ end=/}/ extend fold contains=jstsModuleIdentifierType,jstsModuleDefaultAsType skipwhite skipempty nextgroup=jstsModuleFrom
syn keyword jstsModuleDefaultAsType contained default skipwhite skipempty nextgroup=jstsModuleAsType
hi def link jstsModuleDefaultAsType Keyword

" Types

syn keyword jstsTypedef type skipwhite skipempty nextgroup=jstsTypedefIdentifier
hi def link jstsTypedef Statement
syn match jstsTypedefIdentifier contained /\<\K\k*/ skipwhite skipempty nextgroup=jstsTypedefGenerics,jstsTypedefEquals
hi def link jstsTypedefIdentifier Type
syn region jstsTypedefGenerics contained matchgroup=jstsArgumentParens start=/</ end=/>/ contains=@jstsGenericContains skipwhite skipempty nextgroup=jstsTypedefEquals
syn match jstsTypedefEquals contained /=/ skipwhite skipempty nextgroup=@jstsType
hi def link jstsTypedefEquals Operator

syn cluster jstsTypeNoFn contains=@jstsTypeLiterals,jstsTypeIdentifier,jstsTypeObject,jstsTypeParen,jstsTypeImport
syn cluster jstsType contains=@jstsTypeNoFn,jstsTypeArgs,jstsTypeLeadingGeneric
syn cluster jstsTypeOperator contains=jstsTypeKeyword,jstsTypeOp,jstsTypeTernary
syn cluster jstsGenericContains contains=@jstsType,jstsTypeGenericDefault

syn keyword jstsTypeKeyword contained keyof typeof in is extends skipwhite skipempty nextgroup=@jstsType
hi def link jstsTypeKeyword jstsOperator
syn match jstsTypeOp contained /|\|&/ skipwhite skipempty nextgroup=@jstsTypeNoFn
hi def link jstsTypeOp jstsOperator
syn region jstsTypeTernary contained matchgroup=jstsTernaries start=/?\ze\s*[^?:.]/ end=/:/ extend contains=@jstsType skipwhite skipempty nextgroup=@jstsType
hi def link jstsTypeTernary jstsTernary
syn match jstsTypeDefault contained /=/ skipwhite skipempty nextgroup=@jstsExpression
hi def link jstsTypeDefault jstsOperator

syn cluster jstsTypeLiterals contains=jstsTypeLiteralBoolean,jstsTypeLiteralString,jstsTypeLiteralNumber,jstsTypeLiteralFloat,jstsTypeLiteralKeyword

syn keyword jstsTypeLiteralBoolean contained true false skipwhite skipempty nextgroup=@jstsTypeOperator
hi def link jstsTypeLiteralBoolean jstsBoolean
syn region jstsTypeLiteralString contained start=/\z(["']\)/ skip=/\\\%(\z1\|$\)/ end=/\z1\|$/ contains=jstsEscaped extend skipwhite skipempty nextgroup=@jstsTypeOperator
hi def link jstsTypeLiteralString jstsString
syn match jstsTypeLiteralNumber contained /\c\<\%(\d\+\%(e[+-]\=\d\+\)\=\|0b[01]\+\|0o\o\+\|0x\x\+\)\>/ skipwhite skipempty nextgroup=@jstsTypeOperator
syn keyword jstsTypeLiteralNumber contained Infinity skipwhite skipempty nextgroup=@jstsTypeOperator
hi def link jstsTypeLiteralNumber jstsNumber
syn match jstsTypeLiteralFloat contained /\c\<\%(\d\+\.\d\+\|\d\+\.\|\.\d\+\)\%(e[+-]\=\d\+\)\=\>/ skipwhite skipempty nextgroup=@jstsTypeOperator
hi def link jstsTypeLiteralFloat jstsFloat
syn keyword jstsTypeLiteralKeyword contained null undefined NaN any unknown never void skipwhite skipempty nextgroup=@jstsTypeOperator
hi def link jstsTypeLiteralKeyword jstsNull

syn match jstsTypeIdentifier contained /\<\K\k*/ skipwhite skipempty nextgroup=jstsTypeGenericApply,jstsTypePropAccess,@jstsTypeOperator
hi def link jstsTypeIdentifier Type

syn region jstsTypeGenericApply contained matchgroup=jstsArgumentParens start=/</ end=/>/ extend contains=@jstsType,jstsArgumentComma skipwhite skipempty nextgroup=@jstsTypeOperator

syn region jstsTypePropAccess contained matchgroup=jstsBrackejsts start=/\[/ end=/\]/ contains=jstsConstant,@jstsLiterals skipwhite skipempty nextgroup=jstsTypeGenericApply,jstsTypePropAccess,@jstsTypeOperator

syn region jstsTypeObject contained matchgroup=jstsBraces start=/{/ end=/}/ extend contains=jstsTypeObjectKey,jstsTypeObjectKeyString,jstsTypeObjectRO,jstsTypeObjectIndex,jstsTypeObjectApply,jstsTypeObjectNew,jstsTypeLeadingGeneric,jstsTypeObjectMethod skipwhite skipempty nextgroup=@jstsTypeOperator

syn match jstsTypeObjectKey contained /\<\K\k*\ze?\?:/ skipwhite skipempty nextgroup=jstsTypeObjectColon
syn region jstsTypeObjectKeyString contained start=`\z(["']\)` skip=`\\\%(\z1\|$\)` end=`\z1\|$` contains=jstsEscaped extend skipempty skipwhite nextgroup=jstsTypeObjectColon
hi def link jstsTypeObjectKeyString String
syn match jstsTypeObjectColon contained /?\?:/ skipwhite skipempty nextgroup=@jstsType
hi def link jstsTypeObjectColon jstsOperator

syn match jstsTypeObjectRO contained /readonly / skipwhite skipempty nextgroup=jstsTypeObjectKey,jstsTypeObjectIndex
hi def link jstsTypeObjectRO Keyword

syn region jstsTypeObjectIndex contained matchgroup=jstsBrackejsts start=/\[/ end=/\]/ extend contains=jstsTypeObjectKey,jstsTypeIdentifier skipwhite skipempty nextgroup=jstsTypeObjectColon

syn region jstsTypeObjectApply contained matchgroup=jstsArgumentParens start=/(/ end=/)/ extend contains=@jstsArgumentsContains skipwhite skipempty nextgroup=jstsTypeObjectColon
syn match jstsTypeObjectNew contained /new / skipwhite skipempty nextgroup=jstsTypeObjectApply
hi def link jstsTypeObjectNew jstsStatement

syn match jstsTypeObjectMethod contained /\<\%(async\|await\)\@![a-z_\$]\k*\ze\s*(/ skipwhite skipempty nextgroup=jstsTypeObjectApply

syn region jstsTypeParen contained matchgroup=jstsParens start=/(/ end=/)/ extend contains=@jstsType,jstsTypeOp skipwhite skipempty nextgroup=@jstsTypeOperator

syn region jstsTypeArgs contained matchgroup=jstsArgumentParens start=`(\ze\%(/\*.\{-}\*/\)\?\_s*\%(\%([^()]\+\>?\?:\)\|\%(\%(\k\|\_s\|,\)*)\_s*=>\)\)` end=/)/ extend contains=@jstsArgumentsContains skipwhite skipempty nextgroup=jstsTypeArrow
syn match jstsTypeArrow contained /=>/ skipwhite skipempty nextgroup=@jstsType
hi def link jstsTypeArrow jstsOperator
syn region jstsTypeLeadingGeneric contained matchgroup=jstsArgumentParens start=/</ end=/>/ extend contains=@jstsGenericContains skipwhite skipempty nextgroup=jstsTypeArgs
syn match jstsTypeGenericDefault contained /=/ skipwhite skipempty nextgroup=@jstsType
hi def link jstsTypeGenericDefault jstsOperator

syn keyword jstsCast as skipwhite skipempty nextgroup=@jstsTypeNoFn
hi def link jstsCast Keyword

syn keyword jstsTypeImport contained import skipwhite skipempty nextgroup=jstsTypeImportParens
hi def link jstsTypeImport Statement
syn region jstsTypeImportParens contained matchgroup=jstsParens start=/(/ end=/)/ extend contains=jstsString skipwhite skipempty nextgroup=jstsTypeImportDot
syn match jstsTypeImportDot contained /./ skipwhite skipempty nextgroup=jstsTypeIdentifier

" Globals

syn keyword jstsGlobals arguments console document fetch window module exports global process __dirname __filename decodeURI decodeURIComponent encodeURI encodeURIComponent eval isFinite isNaN parseFloat parseInt Error EvalError InternalError RangeError ReferenceError StopIteration SyntaxError TypeError URIError
hi def link jstsGlobals Constant

" Comments

syn region jstsComment start='//' end=/$/ contains=@Spell extend keepend containedin=ALLBUT,@jstsNoComment
syn region jstsComment start='/\*' end='\*/' contains=@Spell extend keepend fold containedin=ALLBUT,@jstsNoComment
syn region jstsComment start=/\%^#!/ end=/$/ display containedin=ALLBUT,@jstsNoComment
hi def link jstsComment Comment

" JSDOC

syn region jstsComment start='/\*\*' end='\*/' contains=@Spell,@jstsDocTags extend keepend fold containedin=ALLBUT,@jstsNoComment

syn cluster jstsDocTags contains=jstsDocType,jstsDocThis,jstsDocTypedef,jstsDocParam,jstsDocTemplate
syn match jstsDocType contained /@type/ skipwhite skipempty nextgroup=jstsDocTypeBrace,jstsTypeIdentifier,@jstsTypeLiterals
hi def link jstsDocType Special
syn region jstsDocTypeBrace contained matchgroup=Special start=/{/ end=/}/ extend contains=@jstsType
syn match jstsDocThis contained /@this/ skipwhite skipempty nextgroup=jstsDocTypeBrace,jstsTypedefIdentifier,@jstsTypeLiterals
hi def link jstsDocThis Special
syn match jstsDocTypedef contained /@typedef/ skipwhite skipempty nextgroup=jstsDocTypedefBrace
hi def link jstsDocTypedef Special
syn region jstsDocTypedefBrace contained matchgroup=Special start=/{/ end=/}/ extend contains=@jstsType skipwhite skipempty nextgroup=jstsTypedefIdentifier,@jstsTypeLiterals
syn match jstsDocParam contained /@param/ skipwhite skipempty nextgroup=jstsDocTypeBrace
hi def link jstsDocParam Special
syn match jstsDocTemplate contained /@template/ skipwhite skipempty nextgroup=jstsDocTemplateBracket,jstsUpper
hi def link jstsDocTemplate Special
syn region jstsDocTemplateBracket contained matchgroup=Special start=/\[/ end=/\]/ extend contains=jstsUpper,jstsTypedefEquals









" " Interfaces
" syntax keyword tsInterface interface skipwhite skipempty nextgroup=tsInterfaceIdentifier
" hi def link tsInterface jstsStatement
" syntax match tsInterfaceIdentifier contained /\<\K\k*/ skipwhite skipempty nextgroup=tsInterfaceGenerics,tsObjectType
" hi def link tsInterfaceIdentifier tsTypeIdentifier
" syntax region tsInterfaceGenerics contained matchgroup=tsArgumentParens start=/</ end=/>/ contains=@tsGenericContains skipwhite skipempty nextgroup=tsObjectType
"
" " Enums
" syntax keyword tsEnum enum skipwhite skipempty nextgroup=tsEnumIdentifier
" hi def link tsEnum jstsStatement
" syntax match tsEnumIdentifier contained /\<\K\k*/ skipwhite skipempty nextgroup=tsEnumBlock
" hi def link tsEnumIdentifier Constant
" syntax region tsEnumBlock contained matchgroup=tsBrackets start=/{/ end=/}/ contains=tsEnumKey,jstsComment
" syntax match tsEnumKey contained /\<\K\k*/ skipwhite skipempty nextgroup=jstsArgumentDefault
" hi def link tsEnumKey Constant
"
" " Classes
" syntax keyword jstsClass class skipwhite skipempty nextgroup=jstsClassBody,jstsClassName,jstsClassExtends,tsClassImplements
" syntax match jstsClassName contained /\<\K\k*/ skipwhite skipempty nextgroup=jstsClassExtends,tsClassImplements,jstsClassBody
" syntax keyword tsClassImplements contained implements skipwhite skipempty nextgroup=jstsExtendsName
" syntax region jstsClassBody contained matchgroup=jstsBraces start=/{/ end=/}/ contains=tsClassReadOnly,tsClassKey,tsClassVisibility,tsIndexSignature,jstsMethodKeyword,jstsMethod,tsClassInitialiser,tsAbstract,jstsComment
" syntax match tsClassReadOnly contained /readonly / skipwhite skipempty nextgroup=tsClassKey,tsIndexSignature
" hi def link tsClassReadOnly Keyword
" syntax match tsClassKey contained /\<\K\k*\ze\%(?\?:\|\s*=\)/ skipwhite skipempty nextgroup=tsTypeObjectColon,tsTypeDefault
" syntax keyword tsClassVisiblity contained static private protected public
" hi def link tsClassVisiblity Keyword
"
" " Namespaces
" syntax keyword tsNamespace namespace skipwhite skipempty nextgroup=tsNamespaceIdentifier
" hi def link tsNamespace jstsStatement
" syntax match tsNamespaceIdentifier contained /\<\K\k*/ skipwhite skipempty nextgroup=tsNamespaceBody
" hi def link tsNamespaceIdentifier Constant
" syntax region tsNamespaceBody contained matchgroup=jstsBraces start=/{/ end=/}/ contains=TOP
"
"
" Classes
" syntax keyword jstsClass class skipwhite skipempty nextgroup=jstsClassBody,jstsClassName,jstsClassExtends
" syntax match jstsClassName contained /\<\K\k*/ skipwhite skipempty nextgroup=jstsClassExtends,jstsClassBody
" syntax region jstsClassBody contained matchgroup=jstsBraces start=/{/ end=/}/ contains=@jstsExpression
"
" " Functions
" syntax keyword jstsFunction function skipwhite skipempty nextgroup=jstsFunctionGenerator,jstsFunctionIdentifier,jstsArguments
" syntax match jstsFunctionGenerator contained /\*/ skipwhite skipempty nextgroup=jstsFunctionIdentifier,jstsArguments
" syntax match jstsFunctionIdentifier contained /\<\K\k*/ skipwhite skipempty nextgroup=jstsArguments
" syntax region jstsArguments contained matchgroup=jstsArgumentParens start=/(/ end=/)/ extend contains=@jstsArgumentContains skipwhite skipempty nextgroup=jstsBlock
" syntax match jsArgument contained /\<\K\k*/ skipwhite skipempty nextgroup=jstsArgumentDefault
"
" syntax region jstsArrowFunction matchgroup=jstsArgumentParens start=`(\ze[^()]*)\_s*=>` end=/)/ extend contains=@jstsArgumentContains skipwhite skipempty nextgroup=jstsArrow
"
" " Modules
" syntax keyword jstsModule import skipwhite skipempty nextgroup=jstsModuleAny,jstsModuleIdentifier,jstsModuleObject
" syntax keyword jstsModule export skipwhite skipempty nextgroup=@jstsExportable,jstsModuleDefault,jstsModuleAny,jstsModuleIdentifier,jstsModuleObject

" Classes
" syntax keyword jsClass class skipwhite skipempty nextgroup=jsClassBody,jsClassName,jsClassExtends
" syntax match jsClassName contained /\<\K\k*/ skipwhite skipempty nextgroup=jsClassExtends,jsClassBody
" syntax keyword jsClassExtends contained extends skipwhite skipempty nextgroup=jsExtendsName
" syntax match jsExtendsName contained /\<\K\k*/ skipwhite skipempty nextgroup=jsClassBody
" syntax region jsClassBody contained matchgroup=jsBraces start=/{/ end=/}/ contains=jsPrivateField,jsClassKeyword,jsMethodKeyword,jsMethod,jsComputedMethod,@jsExpression
" syntax keyword jsClassKeyword contained static
" syntax match jsPrivateField contained /#\k*/ skipwhite skipempty nextgroup=jsArguments