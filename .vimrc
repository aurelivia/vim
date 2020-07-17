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
set nolist

let g:strip_white_space_on_save = 1
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
let g:ctrlp_use_caching = 0
let g:sayonara_confirm_quit = 1
let g:session_directory = g:vim_path . 'sessions'
let g:session_lock_enabled = 0
let g:session_autosave = 'no'
let g:session_autoload = 'no'

set backspace=indent,eol,start
set tabstop=2 softtabstop=2 shiftwidth=2 noexpandtab autoindent smartindent formatoptions-=t nostartofline
let g:tabmode = 0
let g:tabwidth = 2
let g:session_persist_globals = ['&tabstop', '&softtabstop', '&shiftwidth', '&expandtab']
au Filetype yaml setlocal noai nocin nosi expandtab inde=
command! -nargs=1 Tabs call <SID>SizeTabs(<args>)
command! -nargs=1 Tabspaces let g:tabspaces=<args>
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
function! <SID>ExTabs()
	let g:tabmode = 1
	set expandtab
	execute 'silent! %s/\t/' . repeat(' ', g:tabwidth) . '/g'
	execute 'silent! set tabstop=' . g:tabwidth . ' softtabstop=' . g:tabwidth . ' shiftwidth=' . g:tabwidth
	execute 'silent! setlocal tabstop< softabstop< shiftwidth<'
	echo 'Spaces'
	execute "''"
endfunction
function! <SID>NoExTabs()
	let g:tabmode = 0
	set noexpandtab
	execute 'silent! %s/' . repeat(' ', g:tabwidth) . '/\t/g'
	execute 'silent! set tabstop=' . g:tabwidth . ' softtabstop=' . g:tabwidth . ' shiftwidth=' . g:tabwidth
	execute 'silent! setlocal tabstop< softabstop< shiftwidth<'
	echo 'Tabs'
	execute "''"
endfunction
nnoremap <F5> :call <SID>NoExTabs()<CR>
nnoremap <F6> :call <SID>ExTabs()<CR>

au InsertLeave * :normal `^
set virtualedit=onemore
set clipboard=unnamedplus

set autoread
au FocusGained,BufEnter * :checktime
au BufEnter *.txt if &buftype == 'help' | wincmd L | endif

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

let g:tagbar_left = 1

let g:vue_pre_processors = []

set mouse=
let mapleader = ' '

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

nnoremap Q q
nnoremap <silent> qq :Sayonara!<CR>
nnoremap <silent> qr :Sayonara<CR>
nnoremap <silent> qa :q!<CR>
nnoremap <silent> Z :w!<CR>

nnoremap H ^
nnoremap <S-Left> ^
" noremap <C-h> :bprevious<CR>
nnoremap <silent> <C-Left> :bprevious<CR>
nmap <BS> <NOP>
nmap <S-CR> <NOP>
vmap <S-CR> <NOP>

" noremap K 5k
nnoremap - gj
vnoremap - gj
nnoremap <kPlus> gk
vnoremap <kPlus> gk
nnoremap <S-Up> 15<C-y>15k
nnoremap <C-k> <C-u>zz
nnoremap <C-Up> <C-u>zz
nnoremap <silent> <A-k> :m-2<CR>
nnoremap <silent> <A-Up> :m-2<CR>
vnoremap <silent> <A-k> :m '<-2<CR>gv
vnoremap <silent> <A-Up> :m '<-2<CR>gv

" noremap J 5j
nnoremap = gk
vnoremap = gk
nnoremap <k0> gj
vnoremap <k0> gj
nnoremap <S-Down> 15<C-e>15j
nnoremap <C-j> <C-d>zz
nnoremap <C-Down> <C-d>zz
nnoremap <silent> <A-j> :m+1<CR>
nnoremap <silent> <A-Down> :m+1<CR>
vnoremap <silent> <A-j> :m '>+1<CR>gv
vnoremap <silent> <A-Down> :m '>+1<CR>gv

nnoremap L $
nnoremap <S-Right> $
nnoremap <silent> <C-l> :bnext<CR>
nnoremap <silent> <C-Right> :bnext<CR>

nnoremap s <C-w>
nnoremap <silent> <C-f> :TagbarToggle<CR>
nmap <C-d> <Plug>(dirvish_up)
augroup dirvish_config
	autocmd!
	autocmd FileType dirvish nmap <buffer> <Left> <Plug>(dirvish_up)
	autocmd FileType dirvish nmap <buffer> <Right> <CR>
	autocmd FileType dirvish nmap <buffer> <C-d> <Plug>(dirvish_quit)
augroup END

command! -nargs=1 E execute 'e %:p:h/' . '<args>'

nnoremap <CR> i
nnoremap U <C-r>
nnoremap c<CR> ciw
nnoremap <Leader>c ciw
inoremap <CR> <ESC>
vnoremap <CR> <ESC>
inoremap <F12> <CR>
nnoremap <silent> <F11> :syntax sync fromstart<CR>
nnoremap <Space><Space> @:

command! Evimrc execute 'e ' . g:vimrc
command! Svimrc execute 'so ' . g:vimrc
command! Eawesome :e ~/.config/awesome/rc.lua | :e ~/.config/awesome/theme.lua

nnoremap c' ci'
nnoremap c" ci"
nnoremap c{ ci{
nnoremap c[ ci[
nnoremap c( ci(
nnoremap c<Space> F<Space>lct<Space>
nnoremap p P
nnoremap P p
nnoremap <Leader>o o<ESC>
nnoremap <Leader>O O<ESC>

noremap d "_d
nnoremap dd "_dd
noremap x d
noremap xx dd
vnoremap p "_dP

vnoremap / y/<C-R>"<CR>
nnoremap <silent> <Leader><CR> :let @/=''<CR>
nnoremap <silent> <Leader>\ :StripWhitespace<CR>
nnoremap <silent> \ :set list!<CR>
nnoremap <Leader>s :SaveSession<CR>
nnoremap <Leader>o :OpenSession<CR>
" nnoremap <Leader>s :ToggleWorkspace<CR>
" nnoremap <Leader>s :mksession!<CR>
" nnoremap <Leader>rs :!rm ~/Dropbox/.vim/sessions/*<CR>
" nnoremap <Leader>rs :silent !rm Session.vim | :redraw!<CR>

inoremap <C-b> <Left><CR><CR><ESC>ki<Tab>

autocmd FileType javascript inoremap <buffer> <C-f> <Space>=><Space>{<CR><CR>}<ESC>ki<Tab>

" CamelCaseMotion Bindings
map <silent> w <Plug>CamelCaseMotion_w
map <silent> b <Plug>CamelCaseMotion_b
map <silent> e <Plug>CamelCaseMotion_e
map <silent> ge <Plug>CamelCaseMotion_ge
sunmap w
sunmap b
sunmap e
sunmap ge

omap <silent> iw <Plug>CamelCaseMotion_iw
xmap <silent> iw <Plug>CamelCaseMotion_iw
omap <silent> ib <Plug>CamelCaseMotion_ib
xmap <silent> ib <Plug>CamelCaseMotion_ib
omap <silent> ie <Plug>CamelCaseMotion_ie
xmap <silent> ie <Plug>CamelCaseMotion_ie
xmap <silent> iw <Plug>CamelCaseMotion_iw
xmap <silent> iw <Plug>CamelCaseMotion_iw
xmap <silent> iw <Plug>CamelCaseMotion_iw
xmap <silent> iw <Plug>CamelCaseMotion_iw

let g:ctrlsf_mapping = {
	\ 'openb': ['<CR>', 'o'],
	\ 'open': ['O', '<2-LeftMouse>'],
	\ 'next': 'n',
	\ 'prev': 'N',
\ }
" {'chgmode': 'M', 'popenf': 'P', 'open': ['<CR>', 'o', '<2-LeftMouse>'], 'pquit': 'q', 'vsplit': '', 'openb': 'O', 'stop': '<C-C>', 'quit': 'q', 'next': '<C-J>', 'split': '<C-O>', 'prev': '<C-K>', 'tabb': 'T', 'loclist': '', 'popen': 'p', 'tab': 't'}


com! FormatJSON :call FormatJSON()
function! FormatJSON()
	%!python -c "import json, sys, collections;print(json.dumps(json.load(sys.stdin, object_pairs_hook=collections.OrderedDict), indent=2))"
	%s/\\u\(\x\{4\}\)/\=nr2char('0x'.submatch(1),1)/g
endfunction