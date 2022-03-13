source <sfile>:h/jstsShared.vim

syntax cluster tsExpression contains=@jstsNotObject,tsConstant,tsGenericArrow,jstsObject,tsAppliedType,tsCast
syntax cluster tsBlockContains contains=@jstsDefaultBlockContains,tsConstant,tsAppliedType,tsNamespace,tsAbstract,tsCast
syntax cluster jstsArgumentContains contains=tsArgument,jstsArgumentComma,jstsSpread,jstsComment
syntax cluster jstsExportable contains=@jstsDefaultExportable,tsTypedef,tsInterface,tsNamespace,tsDeclare,tsAbstract

syntax keyword tsDeclare declare
hi def link tsDeclare Keyword
syntax keyword tsAbstract contained abstract
hi def link tsAbstract Keyword
syntax match tsConstant /\<\u\k*/
hi def link tsConstant Constant

" syntax match tsAppliedType /\<\u\k*\ze\s*([^;]\{-})\s*\%(=>\)\@!/ skipwhite nextgroup=jstsAppliedContents
" hi def link tsAppliedType jstsType

" Types

syn cluster tsTypeNoFn contains=@tsTypeLiterals,tsTypeIdentifier,tsTypeObject,tsTypeParen
syn cluster tsType contains=@tsTypeNoFn,tsTypeArgs,tsTypeLeadingGeneric
syn cluster tsTypeOperator contains=tsTypeKeyword,tsTypeOp,tsTypeTernary

syn keyword tsTypeKeyword contained keyof typeof in is extends skipwhite skipempty nextgroup=@tsType
hi def link tsTypeKeyword jstsOperator
syn match tsTypeOp contained /|\|&/ skipwhite skipempty nextgroup=@tsTypeNoFn
hi def link tsTypeOp jstsOperator
syn region tsTypeTernary contained matchgroup=jstsTernaries start=/?\ze\s*[^?:.]/ end=/:/ extend contains=@tsType skipwhite skipempty nextgroup=@tsType
hi def link tsTypeTernary jstsTernary
syn match tsTypeDefault contained /=/ skipwhite skipempty nextgroup=@jstsExpression
hi def link tsTypeDefault jstsOperator

syn cluster tsTypeLiterals contains=tsTypeLiteralBoolean,tsTypeLiteralString,tsTypeLiteralNumber,tsTypeLiteralFloat,tsTypeLiteralKeyword

syn keyword tsTypeLiteralBoolean contained true false skipwhite skipempty nextgroup=@tsTypeOperator
hi def link tsTypeLiteralBoolean jstsBoolean
syn region tsTypeLiteralString contained start=/\z(["']\)/ skip=/\\\%(\z1\|$\)/ end=/\z1\|$/ contains=jstsEscaped extend skipwhite skipempty nextgroup=@tsTypeOperator
hi def link tsTypeLiteralString jstsString
syn match tsTypeLiteralNumber contained /\c\<\%(\d\+\%(e[+-]\=\d\+\)\=\|0b[01]\+\|0o\o\+\|0x\x\+\)\>/ skipwhite skipempty nextgroup=@tsTypeOperator
syn keyword tsTypeLiteralNumber contained Infinity skipwhite skipempty nextgroup=@tsTypeOperator
hi def link tsTypeLiteralNumber jstsNumber
syn match tsTypeLiteralFloat contained /\c\<\%(\d\+\.\d\+\|\d\+\.\|\.\d\+\)\%(e[+-]\=\d\+\)\=\>/ skipwhite skipempty nextgroup=@tsTypeOperator
hi def link tsTypeLiteralFloat jstsFloat
syn keyword tsTypeLiteralKeyword contained null undefined NaN any unknown never void skipwhite skipempty nextgroup=@tsTypeOperator
hi def link tsTypeLiteralKeyword jstsNull

syn match tsTypeIdentifier contained /\<\K\k*/ skipwhite skipempty nextgroup=tsTypeGenericApply,tsTypePropAccess,@tsTypeOperator
hi def link tsTypeIdentifier jstsType

syn region tsTypeGenericApply contained matchgroup=jstsArgumentParens start=/</ end=/>/ extend contains=@tsType,tsArgumentComma skipwhite skipempty nextgroup=@tsTypeOperator

syn region tsTypePropAccess contained matchgroup=jstsBrackets start=/\[/ end=/\]/ contains=tsConstant,@jstsLiterals skipwhite skipempty nextgroup=tsTypeGenericApply,tsTypePropAccess,@tsTypeOperator

syn region tsTypeObject contained matchgroup=jstsBraces start=/{/ end=/}/ extend contains=tsTypeObjectKey,tsTypeObjectRO,tsTypeObjectIndex,tsTypeObjectApply,tsTypeObjectNew,tsTypeLeadingGeneric,tsTypeObjectMethod skipwhite skipempty nextgroup=@tsTypeOperator

syn match tsTypeObjectKey contained /\<\K\k*\ze?\?:/ skipwhite skipempty nextgroup=tsTypeObjectColon
syn match tsTypeObjectColon contained /?\?:/ skipwhite skipempty nextgroup=@tsType
hi def link tsTypeObjectColon jstsOperator

syn match tsTypeObjectRO contained /readonly / skipwhite skipempty nextgroup=tsTypeObjectKey,tsTypeObjectIndex
hi def link tsTypeObjectRO Keyword

syn region tsTypeObjectIndex contained matchgroup=jstsBrackets start=/\[/ end=/\]/ extend contains=tsTypeObjectKey,tsTypeIdentifier skipwhite skipempty nextgroup=tsTypeObjectColon

syn region tsTypeObjectApply contained matchgroup=jstsArgumentParens start=/(/ end=/)/ extend contains=@jstsArgumentContains skipwhite skipempty nextgroup=tsTypeObjectColon
syn match tsTypeObjectNew contained /new / skipwhite skipempty nextgroup=tsTypeObjectApply
hi def link tsTypeObjectNew jstsStatement

syn match tsTypeObjectMethod contained /\<\%(async\|await\)\@![a-z_\$]\k*\ze\s*(/ skipwhite skipempty nextgroup=tsTypeObjectApply

syn region tsTypeParen contained matchgroup=jstsParens start=/(/ end=/)/ extend contains=@tsType,tsTypeOp skipwhite skipempty nextgroup=@tsTypeOperator

syn region tsTypeArgs contained matchgroup=jstsArgumentParens start=`(\ze\%(/\*.\{-}\*/\)\?\_s*\%(\%([^()]\+\>:\)\|\%(\%(\k\|\_s\|,\)*)\_s*=>\)\)` end=/)/ extend contains=@jstsArgumentContains skipwhite skipempty nextgroup=tsTypeArrow
syn match tsTypeArrow contained /=>/ skipwhite skipempty nextgroup=@tsType
hi def link tsTypeArrow jstsOperator
syn region tsTypeLeadingGeneric contained matchgroup=jstsArgumentParens start=/</ end=/>/ extend contains=@tsType,tsTypeGenericDefault skipwhite skipempty nextgroup=tsTypeArgs
syn match tsTypeGenericDefault contained /=/ skipwhite skipempty nextgroup=@tsType
hi def link tsTypeGenericDefault jstsOperator

syntax keyword tsCast as skipwhite skipempty nextgroup=@tsTypeNoFn
hi def link tsCast Keyword

" Definition
syntax keyword jstsDefinition const var let skipwhite skipempty nextgroup=tsDefinitionConstant,tsDefinitionIdentifier
syntax match tsDefinitionIdentifier contained /\<\K\k*/ skipwhite skipempty nextgroup=tsDefinitionType
syntax match tsDefinitionConstant contained /\<\u\k*/ skipwhite skipempty nextgroup=tsDefinitionType
hi def link tsDefinitionConstant tsConstant
syntax match tsDefinitionType contained /:/ skipwhite skipempty nextgroup=@tsType
hi def link tsDefinitionType jstsOperator

" Type Keyword
syntax keyword tsTypedef type skipwhite skipempty nextgroup=tsTypedefIdentifier
hi def link tsTypedef jstsStatement
syntax match tsTypedefIdentifier contained /\<\K\k*/ skipwhite skipempty nextgroup=tsTypedefGenerics,tsTypedefEquals
hi def link tsTypedefIdentifier tsTypeIdentifier
syntax region tsTypedefGenerics contained matchgroup=jstsArgumentParens start=/</ end=/>/ contains=@tsGenericContains skipwhite skipempty nextgroup=tsTypedefEquals
syntax match tsTypedefEquals contained /=/ skipwhite skipempty nextgroup=@tsType
hi def link tsTypedefEquals jstsOperator

" Functions
syntax keyword jstsFunction function skipwhite skipempty nextgroup=jstsFunctionGenerator,tsFunctionConstant,jstsFunctionIdentifier,tsFunctionGenerics,jstsArguments
syntax match jstsFunctionGenerator /\*/ skipwhite skipempty nextgroup=tsFunctionConstant,jstsFunctionIdentifier,tsFunctionGenerics,jstsArguments
syntax region tsGenericArrow matchgroup=jstsArgumentParens start=/<\ze\%(\k\|,\)\{-1,}>\s*(/ end=/>/ extend contains=@tsGenericContains skipwhite skipempty nextgroup=jstsArrowFunction
syntax match jstsFunctionIdentifier contained /\<\K\k*/ skipwhite skipempty nextgroup=tsFunctionGenerics,jstsArguments
syntax match tsFunctionConstant contained /\<\u\k*/ skipwhite skipempty nextgroup=tsFunctionGenerics,jstsArguments
hi def link tsFunctionConstant tsConstant
syntax region tsFunctionGenerics contained matchgroup=jstsArgumentParens start=/</ end=/>/ contains=@tsGenericContains skipwhite skipempty nextgroup=jstsArguments
syntax region jstsArguments contained matchgroup=jstsArgumentParens start=/(/ end=/)/ contains=@jstsArgumentContains skipwhite skipempty nextgroup=tsTypeObjectColon,jstsBlock
syntax match tsArgument contained /\<\K\k*/ skipwhite skipempty nextgroup=tsTypeObjectColon,tsTypeDefault

syn region jstsArrowFunction matchgroup=jstsArgumentParens start=`(\ze\%(/\*.\{-}\*/\)\?\_s*\%(\%([^()]\+\>:\)\|\%([^():]*)\_s*\%(=>\|:\)\)\)` end=/)/ extend contains=@jstsArgumentContains skipwhite skipempty nextgroup=tsReturnType,jstsArrow
syn match tsReturnType contained /:/ skipwhite skipempty nextgroup=@tsTypeNoFn
hi def link tsReturnType jstsOperator

" Modules
syntax keyword jstsModule import skipwhite skipempty nextgroup=jstsModuleAny,jstsModuleIdentifier,jstsModuleObject,tsModuleImportType
syntax keyword jstsModule export skipwhite skipempty nextgroup=@jstsExportable,jstsModuleDefault,jstsModuleAny,jstsModuleIdentifier,jstsModuleObject,tsModuleExportType
syntax keyword tsModuleImportType contained type skipwhite skipempty nextgroup=jstsModuleAny,jstsModuleIdentifier,jstsModuleObject
hi def link tsModuleImportType jstsModule
syntax keyword tsModuleExportType contained skipwhite skipempty nextgroup=tsTypedefIdentifier,jstsModuleAny,jstsModuleObject
hi def link tsModuleExportType jstsModule

" Interfaces
syntax keyword tsInterface interface skipwhite skipempty nextgroup=tsInterfaceIdentifier
hi def link tsInterface jstsStatement
syntax match tsInterfaceIdentifier contained /\<\K\k*/ skipwhite skipempty nextgroup=tsInterfaceGenerics,tsObjectType
hi def link tsInterfaceIdentifier tsTypeIdentifier
syntax region tsInterfaceGenerics contained matchgroup=tsArgumentParens start=/</ end=/>/ contains=@tsGenericContains skipwhite skipempty nextgroup=tsObjectType

" Enums
syntax keyword tsEnum enum skipwhite skipempty nextgroup=tsEnumIdentifier
hi def link tsEnum jstsStatement
syntax match tsEnumIdentifier contained /\<\K\k*/ skipwhite skipempty nextgroup=tsEnumBlock
hi def link tsEnumIdentifier Constant
syntax region tsEnumBlock contained matchgroup=tsBrackets start=/{/ end=/}/ contains=tsEnumKey,jstsComment
syntax match tsEnumKey contained /\<\K\k*/ skipwhite skipempty nextgroup=jstsArgumentDefault
hi def link tsEnumKey Constant

" Classes
syntax keyword jstsClass class skipwhite skipempty nextgroup=jstsClassBody,jstsClassName,jstsClassExtends,tsClassImplements
syntax match jstsClassName contained /\<\K\k*/ skipwhite skipempty nextgroup=jstsClassExtends,tsClassImplements,jstsClassBody
syntax keyword tsClassImplements contained implements skipwhite skipempty nextgroup=jstsExtendsName
syntax region jstsClassBody contained matchgroup=jstsBraces start=/{/ end=/}/ contains=tsClassReadOnly,tsClassKey,tsClassVisibility,tsIndexSignature,jstsMethodKeyword,jstsMethod,tsClassInitialiser,tsAbstract,jstsComment
syntax match tsClassReadOnly contained /readonly / skipwhite skipempty nextgroup=tsClassKey,tsIndexSignature
hi def link tsClassReadOnly Keyword
syntax match tsClassKey contained /\<\K\k*\ze\%(?\?:\|\s*=\)/ skipwhite skipempty nextgroup=tsTypeObjectColon,tsTypeDefault
syntax keyword tsClassVisiblity contained static private protected public
hi def link tsClassVisiblity Keyword

" Namespaces
syntax keyword tsNamespace namespace skipwhite skipempty nextgroup=tsNamespaceIdentifier
hi def link tsNamespace jstsStatement
syntax match tsNamespaceIdentifier contained /\<\K\k*/ skipwhite skipempty nextgroup=tsNamespaceBody
hi def link tsNamespaceIdentifier Constant
syntax region tsNamespaceBody contained matchgroup=jstsBraces start=/{/ end=/}/ contains=TOP
