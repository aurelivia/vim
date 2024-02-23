set nocompatible

" Paths
let s:iswin = has('win32')
if s:iswin
	let g:dotvim = get(g:, 'dotvim', $HOME . '\.vim\')
else
	let g:dotvim = get(g:, 'dotvim', $HOME . '/.vim/')
endif
let g:vimrc = get(g:, 'vimrc', g:dotvim . '.vimrc')

exec 'source ' . g:dotvim . 'keys.vim'

" Options
set hidden noshowmode noshowcmd incsearch nohlsearch ignorecase smartcase nolist autoread noswapfile
set backspace=indent,eol,start wrap linebreak autoindent smartindent formatoptions-=t nostartofline
set guifont=Noto\ Sans\ Mono:h10
set laststatus=2
set enc=utf-8
set fileencodings=utf-8
set shortmess=F
set listchars=eol:¬,trail:~,extends:>,precedes:<,space:·,tab:->
set mouse=
set guioptions=
set dy=uhex,lastline
set gcr+=n-v-c:blinkon0
set belloff=all
set virtualedit=onemore
set clipboard=unnamedplus
set completeopt=menu,menuone,noselect
set conceallevel=1
set termguicolors
set updatetime=300
set scrolloff=10
set number
set relativenumber
set fileformats=unix

augroup FormatOptions
	au Filetype html setlocal formatoptions=tmM
augroup END

if &term =~ '^xterm\|rxvt'
	let &t_SI = "\<Esc>[5 q" " Insert Mode
	let &t_EI = "\<Esc>[2 q" " Non-Insert Mode
	" 0/1 -> Blinking Block
	" 2 -> Solid Block
	" 3 -> Blinking Underscore
	" 4 -> Solid Underscore
	" 5 -> Blinking Vertical Bar
	" 6 -> Solid Vertical Bar
endif

colorscheme onedark

au FocusGained,BufEnter * :checktime
au BufEnter *.txt if &buftype == 'help' | wincmd L | endif

let g:mapleader = ' '
let g:strip_white_space_on_save = 1
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
let g:ctrlp_use_caching = 0
let g:sayonara_confirm_quit = 1
let g:wordmotion_nomap = 1
" let g:session_directory = g:dotvim . 'sessions'
let g:session_lock_enabled = 0
let g:session_autosave = 'no'
let g:session_autoload = 'no'
let g:tagbar_left = 1
let g:vue_pre_processors = []
let g:rust_recommended_style = 0

let g:ctrlsf_mapping = {
\  'openb': ['<CR>', 'o'],
\  'open': ['O', '<2-LeftMouse>'],
\  'next': 'n',
\  'prev': 'N',
\ }
" {'chgmode': 'M', 'popenf': 'P', 'open': ['<CR>', 'o', '<2-LeftMouse>'], 'pquit': 'q', 'vsplit': '', 'openb': 'O', 'stop': '<C-C>', 'quit': 'q', 'next': '<C-J>', 'split': '<C-O>', 'prev': '<C-K>', 'tabb': 'T', 'loclist': '', 'popen': 'p', 'tab': 't'}

if exists('g:tabmode')
	execute 'silent! set tabstop='. g:tabwidth . ' softtabstop=' . g:tabwidth . ' shiftwidth=' . g:tabwidth
	if g:tabmode == 1
		set expandtab
	else
		set noexpandtab
	endif
else
	let g:tabmode = 1
	let g:tabwidth = 2
	set tabstop=2 softtabstop=2 shiftwidth=2
endif
function! <SID>FixTabs(...)
	if a:0
		let l:width = a:1
	else
		let l:width = g:tabwidth
	endif
	if g:tabmode == 1
		execute 'silent! %s/\t/' . repeat(' ', l:width) . '/g'
	else
		execute 'silent! %s/' . repeat(' ', l:width) . '/\t/g'
	end
	execute "''"
endfunction
command! -nargs=1 FixTabs call <SID>FixTabs(<args>)
function! <SID>SizeTabs(...)
	if a:0
		let l:width = a:1
	else
		let l:width = g:tabwidth
	endif
	if g:tabmode == 1
		execute 'silent! %s/' . repeat(' ', g:tabwidth) . '/' . repeat(' ', l:width) . '/g'
		execute "''"
	endif
	execute 'silent! set tabstop=' . l:width . ' softtabstop=' . l:width . ' shiftwidth=' . l:width
	execute 'silent! setlocal tabstop< softabstop< shiftwidth<'
	let g:tabwidth = l:width
endfunction
command! -nargs=1 SizeTabs call <SID>SizeTabs(<args>)
function! <SID>ExTabs(...)
	if a:0
		let l:width = a:1
	else
		let l:width = g:tabwidth
	endif
	let g:tabmode = 1
	set expandtab
	execute 'silent! set tabstop=' . l:width . ' softtabstop=' . l:width . ' shiftwidth=' . l:width
	execute 'silent! setlocal tabstop< softabstop< shiftwidth<'
	echo 'Spaces'
endfunction
command! -nargs=1 Spaces call <SID>ExTabs(<args>)
function! <SID>NoExTabs(...)
	if a:0
		let l:width = a:1
	else
		let l:width = g:tabwidth
	endif
	let g:tabmode = 0
	set noexpandtab
	execute 'silent! set tabstop=' . l:width . ' softtabstop=' . l:width . ' shiftwidth=' . l:width
	execute 'silent! setlocal tabstop< softabstop< shiftwidth<'
	echo 'Tabs'
endfunction
command! -nargs=1 Tabs call <SID>NoExTabs(<args>)

augroup NeedsSpaces
	au Filetype yaml setlocal noai nocin nosi expandtab inde=
	au Filetype markdown setlocal expandtab
	au Filetype haskell setlocal expandtab
	au Filetype cabal setlocal expandtab
	au Filetype purescript setlocal expandtab
	au Filetype gdscript setlocal expandtab
augroup END

augroup NoSpaces
	au Filetype rust setlocal noexpandtab
augroup END

augroup FoldRegions
	au Filetype cs setlocal foldmethod=marker foldmarker=#region,#endregion
	au Filetype javascript setlocal foldmethod=marker foldmarker=//#region,//#endregion
	au Filetype typescript setlocal foldmethod=marker foldmarker=//#region,//#endregion
augroup END

let g:nummode = 0
function! <SID>AutoNumbers(...)
	if g:nummode == 0
		if a:0
			set relativenumber
		else
			set norelativenumber
		endif
	endif
endfunction
function! <SID>ManualNumbers()
	if g:nummode == 0
		let g:nummode = 1
		set norelativenumber
	else
		let g:nummode = 0
		set relativenumber
	endif
endfunction
au BufEnter,FocusGained,InsertLeave * call <SID>AutoNumbers(1)
au BufLeave,FocusLost,InsertEnter * call <SID>AutoNumbers()
nnoremap <silent> <F8> :call <SID>ManualNumbers()<CR>
command! Nums call <SID>ManualNumbers()

function! GetRange()
	let [l:line_start, l:column_start] = getpos("'<")[1:2]
	let [l:line_end, l:column_end] = getpos("'>")[1:2]
	let l:lines = getline(l:line_start, l:line_end)
	if len(l:lines) == 0
		return ''
	endif
	let l:lines[-1] = l:lines[-1][: l:column_end - (&selection == 'inclusive' ? 1 : 2)]
	let l:lines[0] = l:lines[0][l:column_start - 1:]
	return join(l:lines, "\n")
endfunction

com! FormatJSON :call FormatJSON()
function! FormatJSON()
	%!python -c "import json, sys, collections;print(json.dumps(json.load(sys.stdin, object_pairs_hook=collections.OrderedDict), indent=2))"
	%s/\\u\(\x\{4\}\)/\=nr2char('0x'.submatch(1),1)/g
endfunction

command! Folds setlocal foldmethod=syntax

if !s:iswin
	command! Swrite execute 'silent w !sudo tee %' | :e! %
endif


function! <SID>RelPath(path)
	if a:path[0] == '/' || a:path[0] == '~'
		return resolve(a:path)
	else
		return resolve(expand('%:p:h') . '/' . a:path)
	endif
endfunction

command! -nargs=1 E execute 'edit ' . <SID>RelPath('<args>')

command! -nargs=1 Write execute 'write ' . <SID>RelPath('<args>')
command! -nargs=1 W execute 'write ' . <SID>RelPath('<args>')

command! Evimrc execute 'e ' . g:vimrc
command! Svimrc execute 'so ' . g:vimrc

function! <SID>SetKBD(kbd)
if a:kbd == 'qwerty'
	set langmap=
elseif a:kbd == 'lobby'
	set langmap=/q,lw,oe,br,yt,wy,fu,ii,ho,\\;p,ua,ts,ed,nf,cg,gh,dj,ak,rl,s\\;,kz,zx,\\,c,pv,jb,xn,mm,.\\,,q.,v/,?Q,LW,OE,BR,YT,WY,FU,II,HO,:P,UA,TS,ED,NF,CG,GH,DJ,AK,RL,S:,KZ,ZX,<C,PV,JB,XN,MM,><,Q>,V?
else
	echohl ErrorMsg
	echomsg 'Not a valid keyboard layout: ' . a:kbd
	echohl None
endif
endfunction

command! -nargs=1 SetKBD call <SID>SetKBD(<args>)

command! -bang Firefox execute "silent !firefox " . <SID>FFWinOrTab('<bang>') . " 'file://" . resolve(expand('%:p')) . "'"
function! <SID>FFWinOrTab(bang)
	if a:bang == '!'
		return '-new-window'
	endif
	return '-new-tab'
endfunction

function! <SID>MoveToCol(col)
	let l:count = a:col - virtcol('.')
	if l:count <= 0
		return
	endif
	execute 'normal!i' . repeat(' ', l:count)
endfunction
command! -nargs=1 MoveToCol call <SID>MoveToCol(<args>)
no <silent> ><Bar> :<C-u>MoveToCol v:count<CR>

command! -nargs=? Wrap if strlen(<q-args>) | set textwidth=<args> | else | set textwidth=70 | endif

command! Nowrap set textwidth=0

" " exchange word under cursor with the next word without moving the cursor
" nnoremap gw "_yiw:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR><C-o><C-l>
"
" " push word under cursor to the left
" nnoremap <silent> <Leader><Left> "_yiw?\w\+\_W\+\%#<CR>:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR><C-o><C-l>
"
" " push word under cursor to the right
" nnoremap <silent> <Leader><Right> "_yiw:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR><C-o>/\w\+\_W\+<CR><C-l>