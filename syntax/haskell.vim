" Vim syntax file
" Language: JavaScript
" Maintainer: Me

if !exists('main_syntax')
	if exists('b:current_syntax')
		syntax clear
	endif
	let main_syntax = 'haskell'
endif

let s:cpo_save = &cpo
set cpo&vim

syntax iskeyword @,48-57,_,39

syn match hsOperator /\%(\<\u\k*\.\)\=[-!#$%&\*\+/<=>\?@\\^|~][-!#$%&\*\+/<=>\?@\\^|~:.]*/
syn match hsOperator /\<\u\k*\.\.[-!#$%&\*\+/<=>\?@\\^|~:.]*/
syn match hsOperator /\s\.[-!#$%&\*\+/<=>\?@\\^|~:.]*/
syn match hsOperator /`\%(\<\u\k*\.\)\=\l\k*`/
hi def link hsOperator Operator

syn match hsConstructor /\%(\<\u\k*\.\)\=:[-!#$%&\*\+./<=>\?@\\^|~:]*/
syn match hsConstructor /`\%(\<\u\k*\.\)\=\u\k*`/
hi def link hsConstructor Operator

syn match hsLabel /#\l\k*\>/
hi def link hsLabel Special

syn match hsType /\<\u\k*\>/
hi def link hsType Type

syn match hsDelimiter /[()\[\],;{}]/

syn match hsEscape contained "\\\([0-9]\+\|o[0-7]\+\|x[0-9a-fA-F]\+\|[\"\\'&\\abfnrtv]\|^[A-Z^_\[\\\]]\)"
syn match hsEscape contained "\\\(NUL\|SOH\|STX\|ETX\|EOT\|ENQ\|ACK\|BEL\|BS\|HT\|LF\|VT\|FF\|CR\|SO\|SI\|DLE\|DC1\|DC2\|DC3\|DC4\|NAK\|SYN\|ETB\|CAN\|EM\|SUB\|ESC\|FS\|GS\|RS\|US\|SP\|DEL\)"
hi def link hsEscape Special
syn match hsEscapeError contained "\\&\|'''\+"
hi def link hsEscapeError Error
syn region hsString start=/"/ skip=/\\\\\|\\"/ end=/"/ contains=hsEscape
hi def link hsString String
syn match hsCharacter /[^a-zA-Z0-9_']'\([^\\]\|\\[^']\+\|\\'\)'/lc=1 contains=hsEscape,hsEscapeError
syn match hsCharacter /^'\([^\\]\|\\[^']\+\|\\'\)'/ contains=hsEscape,hsEscapeError
hi def link hsCharacter Character
syn match hsNumber /\v<[0-9]%(_*[0-9])*>|<0[xX]_*[0-9a-fA-F]%(_*[0-9a-fA-F])*>|<0[oO]_*%(_*[0-7])*>|<0[bB]_*[01]%(_*[01])*>/
hi def link hsNumber Number
syn match hsFloat /\v<[0-9]%(_*[0-9])*\.[0-9]%(_*[0-9])*%(_*[eE][-+]?[0-9]%(_*[0-9])*)?>|<[0-9]%(_*[0-9])*_*[eE][-+]?[0-9]%(_*[0-9])*>|<0[xX]_*[0-9a-fA-F]%(_*[0-9a-fA-F])*\.[0-9a-fA-F]%(_*[0-9a-fA-F])*%(_*[pP][-+]?[0-9]%(_*[0-9])*)?>|<0[xX]_*[0-9a-fA-F]%(_*[0-9a-fA-F])*_*[pP][-+]?[0-9]%(_*[0-9])*>/
hi def link hsFloat Number

syn keyword hsModule module
" syn match hsKeyword /\<import\>.*/ contains=

syn keyword hsInfix infix infixl infixr
hi def link hsInfix Label

syn keyword hsWhere where
hi def link hsWhere Function

syn keyword hsTypedef type newtype class data family deriving instance default
hi def link hsTypedef Label

syn keyword hsStatement mdo do case of let in if then else
hi def link hsStatement Function

syn keyword hsBoolean True False
hi def link hsBoolean Boolean

syn match hsComment /---*\%([^-!#$%&\*\+./<=>\?@\\^|~].*\)\?$/ contains=@Spell
syn region hsComment start=/{-/ end=/-}/ contains=@Spell
hi def link hsComment Comment

let b:current_syntax = 'haskell'

if main_syntax == 'haskell'
	unlet main_syntax
endif

let &cpo = s:cpo_save
unlet s:cpo_save























" " (Qualified) identifiers (no default highlighting)
" syn match ConId "\(\<[A-Z][a-zA-Z0-9_']*\.\)*\<[A-Z][a-zA-Z0-9_']*\>" contains=@NoSpell
" syn match VarId "\(\<[A-Z][a-zA-Z0-9_']*\.\)*\<[a-z][a-zA-Z0-9_']*\>" contains=@NoSpell
"
" " Infix operators--most punctuation characters and any (qualified) identifier
" " enclosed in `backquotes`. An operator starting with : is a constructor,
" " others are variables (e.g. functions).
" syn match hsVarSym "\(\<[A-Z][a-zA-Z0-9_']*\.\)\=[-!#$%&\*\+/<=>\?@\\^|~.][-!#$%&\*\+/<=>\?@\\^|~:.]*"
" syn match hsConSym "\(\<[A-Z][a-zA-Z0-9_']*\.\)\=:[-!#$%&\*\+./<=>\?@\\^|~:]*"
" syn match hsVarSym "`\(\<[A-Z][a-zA-Z0-9_']*\.\)\=[a-z][a-zA-Z0-9_']*`"
" syn match hsConSym "`\(\<[A-Z][a-zA-Z0-9_']*\.\)\=[A-Z][a-zA-Z0-9_']*`"
"
" " (Non-qualified) identifiers which start with # are labels
" syn match hsLabel "#[a-z][a-zA-Z0-9_']*\>"
"
" syn match hsType "[A-Z][a-zA-Z0-9_']*\>"
"
" " Reserved symbols--cannot be overloaded.
" syn match hsDelimiter  "(\|)\|\[\|\]\|,\|;\|{\|}"
"
" " Strings and constants
" syn match   hsSpecialChar	contained "\\\([0-9]\+\|o[0-7]\+\|x[0-9a-fA-F]\+\|[\"\\'&\\abfnrtv]\|^[A-Z^_\[\\\]]\)"
" syn match   hsSpecialChar	contained "\\\(NUL\|SOH\|STX\|ETX\|EOT\|ENQ\|ACK\|BEL\|BS\|HT\|LF\|VT\|FF\|CR\|SO\|SI\|DLE\|DC1\|DC2\|DC3\|DC4\|NAK\|SYN\|ETB\|CAN\|EM\|SUB\|ESC\|FS\|GS\|RS\|US\|SP\|DEL\)"
" syn match   hsSpecialCharError	contained "\\&\|'''\+"
" syn region  hsString		start=+"+  skip=+\\\\\|\\"+  end=+"+  contains=hsSpecialChar,@NoSpell
" syn match   hsCharacter		"[^a-zA-Z0-9_']'\([^\\]\|\\[^']\+\|\\'\)'"lc=1 contains=hsSpecialChar,hsSpecialCharError
" syn match   hsCharacter		"^'\([^\\]\|\\[^']\+\|\\'\)'" contains=hsSpecialChar,hsSpecialCharError
" syn match   hsNumber		"\v<[0-9]%(_*[0-9])*>|<0[xX]_*[0-9a-fA-F]%(_*[0-9a-fA-F])*>|<0[oO]_*%(_*[0-7])*>|<0[bB]_*[01]%(_*[01])*>"
" syn match   hsFloat		"\v<[0-9]%(_*[0-9])*\.[0-9]%(_*[0-9])*%(_*[eE][-+]?[0-9]%(_*[0-9])*)?>|<[0-9]%(_*[0-9])*_*[eE][-+]?[0-9]%(_*[0-9])*>|<0[xX]_*[0-9a-fA-F]%(_*[0-9a-fA-F])*\.[0-9a-fA-F]%(_*[0-9a-fA-F])*%(_*[pP][-+]?[0-9]%(_*[0-9])*)?>|<0[xX]_*[0-9a-fA-F]%(_*[0-9a-fA-F])*_*[pP][-+]?[0-9]%(_*[0-9])*>"
"
" " Keyword definitions.
" syn keyword hsModule		module
" syn match   hsImportGroup	"\<import\>.*" contains=hsImport,hsImportModuleName,hsImportMod,hsLineComment,hsBlockComment,hsImportList,@NoSpell nextgroup=hsImport
" syn keyword hsImport import contained nextgroup=hsImportModuleName
" syn match   hsImportModuleName '\<[A-Z][A-Za-z.]*' contained
" syn region  hsImportList start='(' skip='([^)]\{-})' end=')' keepend contained contains=ConId,VarId,hsDelimiter,hsBlockComment,hsTypedef,@NoSpell
"
" syn keyword hsImportMod contained as qualified hiding
" syn keyword hsInfix infix infixl infixr
" syn keyword hsStructure class data deriving instance default where
" syn keyword hsTypedef type
" syn keyword hsNewtypedef newtype
" syn keyword hsTypeFam family
" syn keyword hsStatement mdo do case of let in
" syn keyword hsConditional if then else
"
" " Not real keywords, but close.
" if exists("hs_highlight_boolean")
"   " Boolean constants from the standard prelude.
"   syn keyword hsBoolean True False
" endif
" if exists("hs_highlight_types")
"   " Primitive types from the standard prelude and libraries.
"   syn keyword hsType Int Integer Char Bool Float Double IO Void Addr Array String
" endif
" if exists("hs_highlight_more_types")
"   " Types from the standard prelude libraries.
"   syn keyword hsType Maybe Either Ratio Complex Ordering IOError IOResult ExitCode
"   syn keyword hsMaybe Nothing
"   syn keyword hsExitCode ExitSuccess
"   syn keyword hsOrdering GT LT EQ
" endif
" if exists("hs_highlight_debug")
"   " Debugging functions from the standard prelude.
"   syn keyword hsDebug undefined error trace
" endif
"
"
" " Comments
" syn match   hsLineComment      "---*\([^-!#$%&\*\+./<=>\?@\\^|~].*\)\?$" contains=@Spell
" syn region  hsBlockComment     start="{-"  end="-}" contains=hsBlockComment,@Spell
" syn region  hsPragma	       start="{-#" end="#-}"
"
" " C Preprocessor directives. Shamelessly ripped from c.vim and trimmed
" " First, see whether to flag directive-like lines or not
" if (!exists("hs_allow_hash_operator"))
"     syn match	cError		display "^\s*\(%:\|#\).*$"
" endif
" " Accept %: for # (C99)
" syn region	cPreCondit	start="^\s*\(%:\|#\)\s*\(if\|ifdef\|ifndef\|elif\)\>" skip="\\$" end="$" end="//"me=s-1 contains=cComment,cCppString,cCommentError
" syn match	cPreCondit	display "^\s*\(%:\|#\)\s*\(else\|endif\)\>"
" syn region	cCppOut		start="^\s*\(%:\|#\)\s*if\s\+0\+\>" end=".\@=\|$" contains=cCppOut2
" syn region	cCppOut2	contained start="0" end="^\s*\(%:\|#\)\s*\(endif\>\|else\>\|elif\>\)" contains=cCppSkip
" syn region	cCppSkip	contained start="^\s*\(%:\|#\)\s*\(if\>\|ifdef\>\|ifndef\>\)" skip="\\$" end="^\s*\(%:\|#\)\s*endif\>" contains=cCppSkip
" syn region	cIncluded	display contained start=+"+ skip=+\\\\\|\\"+ end=+"+
" syn match	cIncluded	display contained "<[^>]*>"
" syn match	cInclude	display "^\s*\(%:\|#\)\s*include\>\s*["<]" contains=cIncluded
" syn cluster	cPreProcGroup	contains=cPreCondit,cIncluded,cInclude,cDefine,cCppOut,cCppOut2,cCppSkip,cCommentStartError
" syn region	cDefine		matchgroup=cPreCondit start="^\s*\(%:\|#\)\s*\(define\|undef\)\>" skip="\\$" end="$"
" syn region	cPreProc	matchgroup=cPreCondit start="^\s*\(%:\|#\)\s*\(pragma\>\|line\>\|warning\>\|warn\>\|error\>\)" skip="\\$" end="$" keepend
"
" syn region	cComment	matchgroup=cCommentStart start="/\*" end="\*/" contains=cCommentStartError,cSpaceError contained
" syntax match	cCommentError	display "\*/" contained
" syntax match	cCommentStartError display "/\*"me=e-1 contained
" syn region	cCppString	start=+L\="+ skip=+\\\\\|\\"\|\\$+ excludenl end=+"+ end='$' contains=cSpecial contained
"
" " Define the default highlighting.
" " Only when an item doesn't have highlighting yet
"
" hi def link hsModule			  hsStructure
" hi def link hsImport			  Include
" hi def link hsImportMod			  hsImport
" hi def link hsInfix			  PreProc
" hi def link hsStructure			  Structure
" hi def link hsStatement			  Statement
" hi def link hsConditional		  Conditional
" hi def link hsSpecialChar		  SpecialChar
" hi def link hsTypedef			  Typedef
" hi def link hsNewtypedef		  Typedef
" hi def link hsVarSym			  hsOperator
" hi def link hsConSym			  hsOperator
" hi def link hsOperator			  Operator
" hi def link hsTypeFam			  Structure
" if exists("hs_highlight_delimiters")
" " Some people find this highlighting distracting.
" hi def link hsDelimiter			  Delimiter
" endif
" hi def link hsSpecialCharError		  Error
" hi def link hsString			  String
" hi def link hsCharacter			  Character
" hi def link hsNumber			  Number
" hi def link hsFloat			  Float
" hi def link hsConditional			  Conditional
" hi def link hsLiterateComment		  hsComment
" hi def link hsBlockComment		  hsComment
" hi def link hsLineComment			  hsComment
" hi def link hsComment			  Comment
" hi def link hsPragma			  SpecialComment
" hi def link hsBoolean			  Boolean
" hi def link hsType			  Type
" hi def link hsMaybe			  hsEnumConst
" hi def link hsOrdering			  hsEnumConst
" hi def link hsEnumConst			  Constant
" hi def link hsDebug			  Debug
" hi def link hsLabel			  Special
"
" hi def link cCppString			  hsString
" hi def link cCommentStart		  hsComment
" hi def link cCommentError		  hsError
" hi def link cCommentStartError		  hsError
" hi def link cInclude			  Include
" hi def link cPreProc			  PreProc
" hi def link cDefine			  Macro
" hi def link cIncluded			  hsString
" hi def link cError			  Error
" hi def link cPreCondit			  PreCondit
" hi def link cComment			  Comment
" hi def link cCppSkip			  cCppOut
" hi def link cCppOut2			  cCppOut
" hi def link cCppOut			  Comment