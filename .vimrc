set nocompatible
filetype plugin on
filetype indent on
let g:vim_path = $HOME . '/.vim/'
let g:vimrc = g:vim_path . '.vimrc'
execute pathogen#infect(g:vim_path . 'packages/{}')
Helptags

syntax enable
set enc=utf-8 fileencodings=utf-8
colorscheme onedark
let g:onedark_hide_endofbuffer = 1
let g:onedark_termcolors = 256
let g:onedark_terminal_italics = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'

set hidden noshowmode shortmess=F noshowcmd
set incsearch " hlsearch
set listchars=eol:¬,trail:~,extends:>,precedes:<,space:·,tab:->

set mouse=
let mapleader = ' '
set nolist

au InsertLeave * :normal `^
set virtualedit=onemore
set clipboard=unnamedplus

set autoread noswapfile
au FocusGained,BufEnter * :checktime
au BufEnter *.txt if &buftype == 'help' | wincmd L | endif

let g:strip_white_space_on_save = 1
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
let g:ctrlp_use_caching = 0
let g:sayonara_confirm_quit = 1
let g:session_directory = g:vim_path . 'sessions'
let g:session_lock_enabled = 0
let g:session_autosave = 'no'
let g:session_autoload = 'no'
let g:tagbar_left = 1
let g:vue_pre_processors = []

let g:ctrlsf_mapping = {
	\ 'openb': ['<CR>', 'o'],
	\ 'open': ['O', '<2-LeftMouse>'],
	\ 'next': 'n',
	\ 'prev': 'N',
\ }
" {'chgmode': 'M', 'popenf': 'P', 'open': ['<CR>', 'o', '<2-LeftMouse>'], 'pquit': 'q', 'vsplit': '', 'openb': 'O', 'stop': '<C-C>', 'quit': 'q', 'next': '<C-J>', 'split': '<C-O>', 'prev': '<C-K>', 'tabb': 'T', 'loclist': '', 'popen': 'p', 'tab': 't'}

set backspace=indent,eol,start wrap linebreak autoindent smartindent formatoptions-=t nostartofline
if exists("g:tabmode")
	execute 'silent! set tabstop='. g:tabwidth . ' softtabstop=' . g:tabwidth . ' shiftwidth=' . g:tabwidth
	if g:tabmode == 1
		set expandtab
	else
		set noexpandtab
	endif
else
	let g:tabmode = 0
	let g:tabwidth = 2
	set tabstop=2 softtabstop=2 shiftwidth=2
endif
let g:session_persist_globals = ['&tabstop', '&softtabstop', '&shiftwidth', '&expandtab']
au Filetype yaml setlocal noai nocin nosi expandtab inde=
function! FixTabs(...)
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
command! -nargs=1 FixTabs call FixTabs(<args>)
function! SizeTabs(...)
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
command! -nargs=1 SizeTabs call SizeTabs(<args>)
function! ExTabs(...)
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
command! -nargs=1 Spaces call ExTabs(<args>)
function! NoExTabs(...)
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
command! -nargs=1 Tabs call NoExTabs(<args>)

set scrolloff=10
set number
set relativenumber
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

function! GetRange()
	let [line_start, column_start] = getpos("'<")[1:2]
	let [line_end, column_end] = getpos("'>")[1:2]
	let lines = getline(line_start, line_end)
	if len(lines) == 0
		return ''
	endif
	let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
	let lines[0] = lines[0][column_start - 1:]
	return join(lines, "\n")
endfunction

com! FormatJSON :call FormatJSON()
function! FormatJSON()
	%!python -c "import json, sys, collections;print(json.dumps(json.load(sys.stdin, object_pairs_hook=collections.OrderedDict), indent=2))"
	%s/\\u\(\x\{4\}\)/\=nr2char('0x'.submatch(1),1)/g
endfunction

command! Folds setlocal foldmethod=syntax

command! -nargs=1 E execute 'e %:p:h/' . '<args>'

command! Evimrc execute 'e ' . g:vimrc
command! Svimrc execute 'so ' . g:vimrc
command! Eawesome :e ~/.config/awesome/rc.lua | :e ~/.config/awesome/theme.lua

" Editing
nn <CR> i
" nn i <Insert>
ino <CR> <ESC>
vn <CR> <ESC>
nm <BS> <NOP>
map <S-CR> <NOP>

nn <silent> Z :w<CR>
nn <silent> qq :Sayonara!<CR>
nn <silent> qr :Sayonara<CR>
nn qa :q!<CR>
nn s <C-w>
nn U <C-r>

" nn c<CR> ciw
nn c<CR> <NOP>
no d "_d
nn dd "_dd
no x d
no xx dd
nn p P
nn P p
vn p "_dP

nm <C-d> <Plug>(dirvish_up)
augroup dirvish_config
	autocmd!
	autocmd FileType dirvish nmap <buffer> <Left> <Plug>(dirvish_up)
	autocmd FileType dirvish nmap <buffer> h <Plug>(dirvish_up)
	autocmd FileType dirvish nmap <buffer> <Right> <CR>
	autocmd FileType dirvish nmap <buffer> l <CR>
	autocmd FileType dirvish nmap <buffer> <C-d> <Plug>(dirvish_quit)
augroup END

nn <silent> <F11> :syntax sync fromstart<CR>

let g:wordmotion_nomap = 1
map <silent> w <Plug>WordMotion_w
map <silent> b <Plug>WordMotion_b
map <silent> e <Plug>WordMotion_e
map <silent> ge <Plug>WordMotion_ge
omap <silent> iw <Plug>WordMotion_iw
xmap <silent> iw <Plug>WordMotion_iw
omap <silent> aw <Plug>WordMotion_aw
xmap <silent> aw <Plug>WordMotion_aw

" Letter Motions
no k gk
no j gj
no <C-j> J
no J 10gj
no K 10gk
no H <Plug>WordMotion_b
no L <Plug>WordMotion_w

nn <silent> <A-k> :m-2<CR>
vn <silent> <A-k> :m '<-2<CR>gv
nn <silent> <A-j> :m+1<CR>
vn <silent> <A-j> :m '>+1<CR>gv

" Arrow Motions
" NYET
let s:arrowsenabled = 1
function! s:ToggleArrowsFn()
	if s:arrowsenabled == 0
		let s:arrowsenabled = 1
		map <Up> gk
		iunmap <Up>
		map <Down> gj
		iunmap <Down>
		unmap <Left>
		iunmap <Left>
		unmap <Right>
		iunmap <Right>
		map <S-Up> 10gk
		map <S-Down> 10gj
		" map <C-Up> zz<C-u>
		" map <C-Down> zz<C-d>
		map <silent> <S-Left> <Plug>WordMotion_b
		map <silent> <S-Right> <Plug>WordMotion_w
	else
		let s:arrowsenabled = 0
		map <Up> <NOP>
		imap <Up> <NOP>
		map <Down> <NOP>
		imap <Down> <NOP>
		map <Left> <NOP>
		imap <Left> <NOP>
		map <Right> <NOP>
		imap <Right> <NOP>
		map <S-Up> <NOP>
		map <S-Down> <NOP>
		map <S-Left> <NOP>
		map <S-Right> <NOP>
		map <C-Up> <NOP>
		map <C-Down> <NOP>
		map <C-Left> <NOP>
		map <C-Right> <NOP>
	endif
endfunction
command! ToggleArrows call s:ToggleArrowsFn()
call s:ToggleArrowsFn()

" no <silent> <C-Left> :bprevious<CR>
" no <silent> <C-Right> :bnext<CR>

" Numpad Motions
no <kPlus> gk
no <kEnter> gj
no = gk
no - gj
no <S-kPlus> 10gk
no <S-kEnter> 10gj
no + 10gk
no _ 10gj

no <PageUp> zz<C-u>
no <PageDown> zz<C-d>
no <silent> <kDivide> :bprevious<CR>
no <silent> <kMultiply> :bnext<CR>
no <silent> <Home> :bprevious<CR>
no <silent> <End> :bnext<CR>

nn <silent> \ :set list!<CR>
nn <silent> <Leader>\ :StripWhitespace<CR>
nnoremap <Space><Space> @:


" vnoremap / y/<C-R>"<CR>
" nnoremap <silent> <Leader><CR> :let @/=''<CR>
" nnoremap <silent> <Leader>\ :StripWhitespace<CR>
" nnoremap <silent> \ :set list!<CR>
" nnoremap <Leader>s :SaveSession<CR>
" nnoremap <Leader>o :OpenSession<CR>
" " nnoremap <Leader>s :ToggleWorkspace<CR>
" " nnoremap <Leader>s :mksession!<CR>
" " nnoremap <Leader>rs :!rm ~/Dropbox/.vim/sessions/*<CR>
" " nnoremap <Leader>rs :silent !rm Session.vim | :redraw!<CR>
"
" autocmd FileType javascript inoremap <buffer> <C-f> <Space>=><Space>{<CR><CR>}<ESC>ki<Tab>
"
" " CamelCaseMotion Bindings
" map <silent> w <Plug>CamelCaseMotion_w
" map <silent> b <Plug>CamelCaseMotion_b
" map <silent> e <Plug>CamelCaseMotion_e
" map <silent> ge <Plug>CamelCaseMotion_ge
" sunmap w
" sunmap b
" sunmap e
" sunmap ge
"
" " exchange word under cursor with the next word without moving the cursor
" nnoremap gw "_yiw:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR><C-o><C-l>
"
" " push word under cursor to the left
" nnoremap <silent> <Leader><Left> "_yiw?\w\+\_W\+\%#<CR>:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR><C-o><C-l>
"
" " push word under cursor to the right
" nnoremap <silent> <Leader><Right> "_yiw:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR><C-o>/\w\+\_W\+<CR><C-l>