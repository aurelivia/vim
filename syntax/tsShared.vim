source <sfile>:h/jstsShared.vim

syntax cluster tsExpression contains=@jstsNotObject,tsConstant,tsGenericArrow,jstsObject,tsAppliedType
syntax cluster tsBlockContains contains=@jstsDefaultBlockContains,tsConstant,tsAppliedType,tsNamespace,tsAbstract
syntax cluster jstsArgumentContains contains=tsArgument,jstsArgumentComma,jstsSpread,jstsComment
syntax cluster jstsExportable contains=@jstsDefaultExportable,tsTypedef,tsInterface,tsNamespace,tsDeclare,tsAbstract

syntax keyword jstsBoolean any
syntax keyword jstsNull void never unknown
syntax keyword tsDeclare declare
hi def link tsDeclare Keyword
syntax keyword tsAbstract contained abstract
hi def link tsAbstract Keyword
syntax match tsConstant /\<\u\k*/
hi def link tsConstant Constant

" syntax match jstsApply /\<[a-z_\$]\k*\ze\s*([^;]\{-})\s*\%(=>\)\@!/ skipwhite nextgroup=jstsAppliedContents
syntax match tsAppliedType /\<\u\k*\ze\s*([^;]\{-})\s*\%(=>\)\@!/ skipwhite nextgroup=jstsAppliedContents
hi def link tsAppliedType jstsType

" Generics
syntax cluster tsGenericContains contains=tsGenericName,jstsArgumentComma
syntax match tsGenericName contained /\<\K\k*/ skipwhite skipempty nextgroup=tsTypeExtends,tsGenericDefault
hi def link tsGenericName tsTypeName
syntax match tsGenericDefault contained /=/ skipwhite skipempty nextgroup=@tsType
hi def link tsGenericDefault jstsOperator

" Types
syntax cluster tsType contains=tsTypeName,tsObjectType,tsTypeParen,tsTypeUnion,tsLeadingGeneric,tsTypeKeyword,tsTypeExtends,@jstsLiterals,jstsArgumentDefault,tsTypeTernary
syntax cluster tsTypeOperator contains=tsTypeIntersection,tsTypeUnion,tsTypeTernary
syntax match tsTypeUnion contained /|/ skipwhite skipempty nextgroup=@tsType
hi def link tsTypeUnion jstsOperator
syntax match tsTypeIntersection contained /&/ skipwhite skipempty nextgroup=@tsType
hi def link tsTypeIntersection jstsOperator
syntax region tsLeadingGeneric contained matchgroup=jstsArgumentParens start=/</ end=/>/ extend contains=@tsGenericContains skipwhite skipempty nextgroup=tsTypeParen
syntax region tsTypeParen contained matchgroup=jstsArgumentParens start=/(/ end=/)/ extend contains=tsTypeParenArg,tsTypeParenSpread,@tsType skipwhite skipempty nextgroup=tsTypeArrow,tsObjectKeyColon,@tsTypeOperator
syntax match tsTypeName contained /\<\K\k*/ skipwhite skipempty nextgroup=tsTypeGenericApply,@tsTypeOperator,tsTypePropAccess,tsTypeExtends
syntax region tsTypeGenericApply contained matchgroup=jstsArgumentParens start=/</ end=/>/ extend contains=@tsType,tsArgumentComma skipwhite skipempty nextgroup=@tsTypeOperator
hi def link tsTypeName jstsType
syntax region tsTypePropAccess contained matchgroup=jstsBrackets start=/\[/ end=/\]/ contains=tsConstant,@jstsLiterals skipwhite skipempty nextgroup=@tsTypeOperator,tsTypePropAccess
syntax keyword tsTypeKeyword contained keyof typeof in skipwhite skipempty nextgroup=@tsType
hi def link tsTypeKeyword jstsOperator
syntax keyword tsTypeExtends contained extends skipwhite skipempty nextgroup=@tsType
hi def link tsTypeExtends tsTypeKeyword
syntax region tsObjectType contained matchgroup=jstsBraces start=/{/ end=/}/ extend contains=tsObjectTypeKey,tsObjectReadOnly,tsObjectTypeConstructor,tsIndexSignature,tsLeadingGeneric,tsTypeParen,jstsComment skipwhite skipempty nextgroup=@tsTypeOperator
syntax match tsObjectTypeKey contained /\<\K\k*\ze?\?:/ skipwhite skipempty nextgroup=tsObjectKeyColon
syntax match tsObjectKeyColon contained /?\?:/ skipwhite skipempty nextgroup=@tsType
hi def link tsObjectKeyColon jstsOperator
syntax match tsTypeDefault contained /=/ skipwhite skipempty nextgroup=@jstsExpression
hi def link tsTypeDefault jstsOperator
syntax match tsObjectReadOnly contained /readonly / skipwhite skipempty nextgroup=tsObjectTypeKey,tsIndexSignature
hi def link tsObjectReadOnly Keyword
syntax match tsObjectTypeConstructor contained /new / skipwhite skipempty nextgroup=tsCallSignature
hi def link tsObjectTypeConstructor jstsStatement
syntax region tsIndexSignature contained matchgroup=jstsBrackets start=/\[/ end=/\]/ contains=tsObjectTypeKey,tsTypeKeyword,tsConstant skipwhite skipempty nextgroup=tsObjectKeyColon
syntax region tsCallSignature contained matchgroup=jstsArgumentParens start=/(/ end=/)/ contains=@jstsArgumentContains skipwhite skipempty nextgroup=tsObjectKeyColon
syntax match tsTypeParenArg contained /\<\K\k*\ze\%(?\?:\|\s*=\)/ skipwhite skipempty nextgroup=tsObjectKeyColon
syntax match tsTypeParenSpread contained /\.\.\./
hi def link tsTypeParenSpread jstsSpread
syntax match tsTypeArrow contained /=>/ skipwhite skipempty nextgroup=@tsType
hi def link tsTypeArrow jstsArrowFunction
syntax region tsTypeTernary contained matchgroup=jstsTernaries start=/?\ze[^?:.]/ end=/:/ contains=@tsType extend skipwhite skipempty nextgroup=@tsType

syntax keyword tsCast as skipwhite skipempty nextgroup=@tsType
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
hi def link tsTypedefIdentifier tsTypeName
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
syntax region jstsArguments contained matchgroup=jstsArgumentParens start=/(/ end=/)/ contains=@jstsArgumentContains skipwhite skipempty nextgroup=tsObjectKeyColon,jstsBlock
syntax match tsArgument contained /\<\K\k*/ skipwhite skipempty nextgroup=tsObjectKeyColon,tsTypeDefault

" syntax match jstsArrowFunction /([^()]):.*=>/ contains=

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
hi def link tsInterfaceIdentifier tsTypeName
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
syntax match tsClassKey contained /\<\K\k*\ze\%(?\?:\|\s*=\)/ skipwhite skipempty nextgroup=tsObjectKeyColon,tsTypeDefault
syntax keyword tsClassVisiblity contained static private protected public
hi def link tsClassVisiblity Keyword

" Namespaces
syntax keyword tsNamespace namespace skipwhite skipempty nextgroup=tsNamespaceIdentifier
hi def link tsNamespace jstsStatement
syntax match tsNamespaceIdentifier contained /\<\K\k*/ skipwhite skipempty nextgroup=tsNamespaceBody
hi def link tsNamespaceIdentifier Constant
syntax region tsNamespaceBody contained matchgroup=jstsBraces start=/{/ end=/}/ contains=TOP