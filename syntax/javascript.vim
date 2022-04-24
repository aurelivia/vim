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

source <sfile>:h/jsts.vim

syntax region jstsArrowFunction matchgroup=jstsArgumentParens start=`(\ze[^()]*)\_s*=>` end=/)/ extend contains=@jstsArgumentsContains skipwhite skipempty nextgroup=jstsArrow

let b:current_syntax = 'javascript'

if main_syntax == 'javascript'
	unlet main_syntax
endif

let &cpo = s:cpo_save
unlet s:cpo_save
