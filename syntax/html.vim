" Vim syntax file
" Language: HTML
" Maintainer: Me

if !exists('main_syntax')
	if exists('b:current_syntax')
		finish
	endif
	let main_syntax = 'html'
endif

let s:cpo_save = &cpo
set cpo&vim

syn include @javascript syntax/javascript.vim
unlet b:current_syntax
syn include @css syntax/css.vim
unlet b:current_syntax

syn case match

syn region htmlComment start='<!--' end='--\s*>' contains=@Spell
syn region htmlComment start='<!DOCTYPE' end='>' keepend
hi def link htmlComment Comment

syn match htmlTag '<\ze[^/!]' skipwhite skipempty nextgroup=htmlComponent,htmlElem
hi clear htmlTag
hi def link htmlTag Comment

syn match htmlClosingTag '</' skipwhite skipempty nextgroup=htmlElem,htmlComponent
hi def link htmlClosingTag htmlTag

syn match htmlTagEnd />/
hi def link htmlTagEnd htmlTag
syn match htmlTagClose contained '/>'
hi def link htmlTagClose htmlTag

syn cluster htmlTagContents contains=htmlTagClose,htmlAttribute

syn match htmlComponent contained /[A-Z][a-zA-Z0-9]*/ skipwhite skipempty nextgroup=@htmlTagContents
hi clear htmlComponent
hi def link htmlComponent Constant
syn match htmlElem contained /[a-z0-9][a-zA-Z0-9]*/ skipwhite skipempty nextgroup=@htmlTagContents
hi clear htmlElem
hi def link htmlElem Identifier

syn match htmlAttribute contained /[-a-z]\+/ skipwhite skipempty nextgroup=htmlAttrEquals,@htmlTagContents
" hi def link htmlAttribute htmlArg

syn match htmlAttrEquals contained /=/ skipwhite skipempty nextgroup=@htmlAttrValue
hi def link htmlAttrEquals Operator

syn cluster htmlAttrValue contains=htmlString,htmlNumber,htmlBoolean,htmlJSXInterp

syn region htmlString contained start=/\z(["']\)/ end=/\z1/ contains=@Spell extend skipwhite skipempty nextgroup=@htmlTagContents
hi def link htmlString String
syn match htmlNumber contained /[0-9]\+/ skipwhite skipempty nextgroup=@htmlTagContents
hi def link htmlNumber String
syn keyword htmlBoolean contained true false skipwhite skipempty nextgroup=@htmlTagContents
hi def link htmlBoolean String
syn region htmlJSXInterp contained matchgroup=htmlJSXInterp start=/{/ end=/}/ extend contains=@javascript skipwhite skipempty nextgroup=@htmlTagContents
hi def link htmlJSXInterp Special

syn match htmlEscape /&#\=[a-zA-Z0-9]\{1,8};/
" hi def link htmlEscape htmlSpecialChar

" Special Tags

syn region htmlScriptTag matchgroup=htmlScriptTag start=/<\s*script/ end=/\ze>/ extend keepend contains=@htmlTagContents skipwhite skipempty nextgroup=htmlScriptJS
hi def link htmlScriptTag Statement

syn region htmlScriptJS contained matchgroup=htmlScriptTag start=/>/ end='</\s*script\s*>' extend contains=@javascript

syn region htmlStyleTag matchgroup=htmlStyleTag start=/<\s*style/ end=/\ze>/ extend keepend contains=@htmlTagContents skipwhite skipempty nextgroup=htmlStylesheet
hi def link htmlStyleTag Statement

syn region htmlStylesheet contained matchgroup=htmlStyleTag start=/>/ end='</\s*style\s*>' extend keepend contains=@css

syn region htmlHeader matchgroup=htmlTag start=/<\zeh[0-6]\>/ end=/>/ extend keepend contains=htmlElem skipwhite skipempty nextgroup=htmlHeaderText
syn region htmlHeaderText contained start='\%(</\)\@!' end='\ze</h[0-6]>' contains=@htmlTags
" hi def link htmlHeaderText Keyword

syn region htmlAnchor matchgroup=htmlTag start=/<\zea\>/ end=/>/ extend keepend contains=htmlElem skipwhite skipempty nextgroup=htmlAnchorText
syn region htmlAnchorText contained start='\%(</\)\@!' end='\ze</a>' contains=@htmlTags
hi def link htmlAnchorText Special

syn region htmlEmphasis matchgroup=htmlTag start=/<\zeem\>/ end=/>/ extend keepend contains=htmlElem skipwhite skipempty nextgroup=htmlEmphasisText
syn region htmlEmphasisText contained start='\%(</\)\@!' end='\ze</em>' contains=@htmlTags
hi def link htmlEmphasisText htmlItalic

syn region htmlBold matchgroup=htmlTag start=/<\zeb\>/ end=/>/ extend keepend contains=htmlElem skipwhite skipempty nextgroup=htmlBoldText
syn region htmlBoldText contained start='\%(</\)\@!' end='\ze</b>' contains=@htmlTags
" hi def link htmlBoldText htmlBold

syn region htmlMark matchgroup=htmlTag start=/<\zemark\>/ end=/>/ extend keepend contains=htmlElem skipwhite skipempty nextgroup=htmlMarkText
syn region htmlMarkText contained start='\%(</\)\@!' end='\ze</mark>' contains=@htmlTags
hi def link htmlMarkText htmlHeaderText

syn region htmlItalic matchgroup=htmlTag start=/<\zei\>/ end=/>/ extend keepend contains=htmlElem skipwhite skipempty nextgroup=htmlItalicText
syn region htmlItalicText contained start='\%(</\)\@!' end='\ze</i>' contains=@htmlTags
" hi def htmlItalicText term=italic cterm=italic gui=italic

syn region htmlTH matchgroup=htmlTag start=/<\zeth\>/ end=/>/ extend keepend contains=htmlElem skipwhite skipempty nextgroup=htmlTHText
syn region htmlTHText contained start='\%(</\)\@!' end='\ze</th>' contains=@htmlTags
hi def link htmlTHText htmlHeaderText

syn cluster htmlTags contains=htmlHeader,htmlAnchor,htmlEmphasis,htmlBold,htmlMark,htmlItalic,htmlTH,htmlScriptTag,htmlStyleTag,htmlTag,htmlTagEnd,htmlClosingTag

syn sync fromstart
" syn sync match html groupthere NONE "<[/a-zA-Z]"
" syn sync match html groupthere htmlScriptTag "<script"
" syn sync match html groupthere htmlStyleTag "<style"
" syn sync match htmlSkip "^.*['\"].*$"
" syn sync minlines=10

let b:current_syntax = 'html'

if main_syntax == 'html'
	unlet main_syntax
endif

let &cpo = s:cpo_save
unlet s:cpo_save
