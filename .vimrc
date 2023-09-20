set nocompatible

" Paths
let s:iswin = has('win32')
if s:iswin
	let g:dotvim = get(g:, 'dotvim', $HOME . '\.vim\')
else
	let g:dotvim = get(g:, 'dotvim', $HOME . '/.vim/')
endif
let g:vimrc = g:dotvim . '.vimrc'

silent! call system('curl -fLo "' . g:dotvim . 'autoload/plug.vim" --create-dirs "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim')

if !exists(':Plug')
	if filereadable(g:dotvim . 'autoload/plug.vim')
		exec 'source ' . g:dotvim . 'autoload/plug.vim'
	else
		echohl ErrorMsg
		echomsg 'plug.vim missing and could not be retrieved.'
		echohl None
		finish
	endif
endif

function! LSPCheck(info) abort
	if a:info.status == 'unchanged' && !a:info.force
		return
	endif

	if !executable('typescript-language-server')
		echohl ErrorMsg
		echomsg 'typescript-language-server not installed'
		echohl None
		return
	endif
endfunction

call plug#begin(g:dotvim . 'packages')

" Visuals
" Plug 'git@github.com:joshdick/onedark.vim' Using local fork
Plug g:dotvim . '/packages/onedark.vim'
Plug 'git@github.com:vim-airline/vim-airline'

" Presumably something is depending on this
Plug 'git@github.com:xolox/vim-misc'

" Quality of Life
Plug 'git@github.com:mhinz/vim-sayonara'
Plug 'git@github.com:justinmk/vim-dirvish'
Plug 'git@github.com:chaoren/vim-wordmotion'
Plug 'git@github.com:tomtom/tcomment_vim'
Plug 'git@github.com:ntpeters/vim-better-whitespace'
Plug 'git@github.com:tpope/vim-surround'
Plug 'git@github.com:tmux-plugins/vim-tmux-focus-events'
Plug 'git@github.com:tpope/vim-eunuch'
Plug 'git@github.com:godlygeek/tabular'
Plug 'git@github.com:gerw/vim-HiLinkTrace', { 'on': 'HLT' }
" Plug 'git@github.com:tpope/vim-fugitive'
" Plug 'git@github.com:ngemily/vim-vp4'

Plug 'git@github.com:neovim/nvim-lspconfig', { 'do': function('LSPCheck') }
Plug 'git@github.com:hrsh7th/vim-vsnip'
Plug 'git@github.com:hrsh7th/cmp-vsnip'
Plug 'git@github.com:hrsh7th/cmp-nvim-lsp'
Plug 'git@github.com:hrsh7th/cmp-buffer'
Plug 'git@github.com:hrsh7th/cmp-path'
Plug 'git@github.com:hrsh7th/cmp-cmdline'
Plug 'git@github.com:hrsh7th/nvim-cmp'

Plug 'git@github.com:felipec/notmuch-vim.git', { 'on': 'NotMuch' }

Plug 'git@github.com:chrisbra/unicode.vim'

call plug#end()
exec 'set runtimepath-=' . g:dotvim
" let &runtimepath = substitute(&runtimepath, g:dotvim, trim(g:dotvim, '/', 2), '')

set termguicolors
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

filetype plugin on
filetype indent on
syntax enable
set laststatus=2
set enc=utf-8 fileencodings=utf-8
" let g:onedark_hide_endofbuffer = 1
let g:onedark_termcolors = 256
let g:onedark_terminal_italics = 1
let g:onedark_color_overrides = {
	\'background': { 'gui': '#2C2C2C', 'cterm': 'NONE', 'cterm16': 'NONE' },
	\'black': { 'gui': '#2C2C2C', 'cterm': 'NONE', 'cterm16': 'NONE' },
	\'foreground': { 'gui': '#AFAFAF', 'cterm': 'NONE', 'cterm16': 'NONE' },
	\'white': { 'gui': '#AFAFAF', 'cterm': 'NONE', 'cterm16': 'NONE' },
	\'comment_grey': { 'gui': '#5F5F5F', 'cterm': '59', 'cterm16': '7' },
	\'gutter_fg_grey': { 'gui': '#444444', 'cterm': '238', 'cterm16': '8' },
	\'cursor_grey': { 'gui': '#303030', 'cterm': '236', 'cterm16': '0' },
	\'visual_grey': { 'gui': '#3A3A3A', 'cterm': '237', 'cterm16': '8' },
	\'menu_grey': { 'gui': '#3A3A3A', 'cterm': '237', 'cterm16': '7' },
	\'special_grey': { 'gui': '#444444', 'cterm': '238', 'cterm16': '7' },
	\'vertsplit': { 'gui': '#3A3A3A', 'cterm': '59', 'cterm16': '7' },
	\'yellow': { 'gui': '#D7AF87', 'cterm': '180', 'cterm16': '3' },
	\'dark_yellow': { 'gui': '#D7875F', 'cterm': '173', 'cterm16': '11' }
\}

colorscheme onedark
let g:airline_theme = 'onedark'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#whitespace#mixed_indent_algo = 2
let g:airline#extensions#whitespace#checks = [ 'indent', 'trailing', 'long', 'conflicts' ]

set hidden noshowmode shortmess=F noshowcmd
set incsearch nohlsearch " hlsearch
set listchars=eol:¬,trail:~,extends:>,precedes:<,space:·,tab:->
set ignorecase smartcase

set mouse=
let mapleader = ' '
set nolist

set guioptions=
set dy=uhex,lastline
set gcr+=n-v-c:blinkon0
set belloff=all

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
let g:session_directory = g:dotvim . 'sessions'
let g:session_lock_enabled = 0
let g:session_autosave = 'no'
let g:session_autoload = 'no'
let g:tagbar_left = 1
let g:vue_pre_processors = []
let g:rust_recommended_style = 0

let g:ctrlsf_mapping = {
	\ 'openb': ['<CR>', 'o'],
	\ 'open': ['O', '<2-LeftMouse>'],
	\ 'next': 'n',
	\ 'prev': 'N',
\ }
" {'chgmode': 'M', 'popenf': 'P', 'open': ['<CR>', 'o', '<2-LeftMouse>'], 'pquit': 'q', 'vsplit': '', 'openb': 'O', 'stop': '<C-C>', 'quit': 'q', 'next': '<C-J>', 'split': '<C-O>', 'prev': '<C-K>', 'tabb': 'T', 'loclist': '', 'popen': 'p', 'tab': 't'}

set backspace=indent,eol,start wrap linebreak autoindent smartindent formatoptions-=t nostartofline
if exists('g:tabmode')
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
augroup END

augroup NoSpaces
	au Filetype rust setlocal noexpandtab
augroup END

augroup FoldRegions
	au Filetype cs setlocal foldmethod=marker foldmarker=#region,#endregion
	au Filetype javascript setlocal foldmethod=marker foldmarker=//#region,//#endregion
	au Filetype typescript setlocal foldmethod=marker foldmarker=//#region,//#endregion
augroup END

set updatetime=300
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

command! Firefox execute '!firefox file://%:p'

" Editing
nn <CR> i
" nn i <Insert>
ino <CR> <ESC>
vn <CR> <ESC>
nm <BS> <NOP>
map <S-CR> <NOP>
" nn i <ESC>hr

nn <silent> Z :silent w<CR>
nn <silent> qq :Sayonara!<CR>
nn <silent> qr :Sayonara<CR>
nn qa :q!<CR>
nn q <NOP>
nn <C-@> q
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

nn <silent> <F11> :syntax sync fromstart<CR>

nn <silent> \ :set list!<CR>
nn <silent> <Leader>\ :StripWhitespace<CR>

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
no j h
no k gj
no l gk
no ; l
no h ;

no J <NOP>
no K 10gj
no L 10gk
no <Space><Space> :
no <Space><Return> @:

no <silent> <C-j> :bprevious<CR>
no <C-k> zz<C-d>
no <C-l> zz<C-u>
no <silent> <C-;> :bnext<CR>

nn <silent> <A-k> :m+1<CR>
vn <silent> <A-k> :m '<+1<CR>gv
nn <silent> <A-l> :m-2<CR>
vn <silent> <A-l> :m '>-2<CR>gv

nn sj <C-w>h
nn <C-w>j <C-w>h
nn sk <C-w>j
nn <C-w>k <C-w>j
nn sl <C-w>k
nn <C-w>l <C-w>k
nn s; <C-w>l
nn <C-w>; <C-w>l
nn <C-w>h <NOP>
nn sh <C-w>s
nn sq <C-w>q
nn sv <C-w>v

nm <C-d> <Plug>(dirvish_up)
augroup dirvishBindings
	autocmd!
	autocmd FileType dirvish nmap <nowait><buffer> j <Plug>(dirvish_up)
	autocmd FileType dirvish nmap <nowait><buffer> <Left> <Plug>(dirvish_up)
	autocmd FileType dirvish nmap <nowait><buffer> k gj
	autocmd FileType dirvish nmap <nowait><buffer> K 10gj
	autocmd FileType dirvish nmap <nowait><buffer> l gk
	autocmd FileType dirvish nmap <nowait><buffer> ; <CR>
	autocmd FileType dirvish nmap <nowait><buffer> <Right> <CR>
	autocmd FileType dirvish nmap <nowait><buffer> <C-d> <Plug>(dirvish_quit)

	autocmd FileType dirvish nmap <nowait><buffer> <kDivide> <Plug>(dirvish_up)
	autocmd FileType dirvish nmap <nowait><buffer> <kMultiply> <CR>
augroup END

" Arrow Motions
function! <SID>ToggleArrowsFn()
	if g:arrowsenabled == 0
		let g:arrowsenabled = 1
		no <Up> gk
		ino <Up> <C-\><C-o>gk
		no <Down> gj
		ino <Down> <C-\><C-o>gj
		no <Left> <NOP>
		unmap <Left>
		imap <Left> <NOP>
		iunmap <Left>
		no <Right> <NOP>
		unmap <Right>
		imap <Right> <NOP>
		iunmap <Right>
		no <S-Up> 10gk
		no <S-Down> 10gj
		no <silent> <S-Left> <Plug>WordMotion_b
		no <silent> <S-Right> <Plug>WordMotion_w
		no <C-Up> zz<C-u>
		no <C-Down> zz<C-d>
		no <silent> <C-Left> :bprevious<CR>
		no <silent> <C-Right> :bnext<CR>
		nn <silent> <A-Up> :m-2<CR>
		vn <silent> <A-Up> :m '<-2<CR>gv
		nn <silent> <A-Down> :m+1<CR>
		vn <silent> <A-Down> :m '>+1<CR>gv
	else
		let g:arrowsenabled = 0
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
		map <A-Up> <NOP>
		map <A-Down> <NOP>
	endif
endfunction
command! ToggleArrows call <SID>ToggleArrowsFn()

let g:arrowsenabled = get(g:, 'arrowsenabled', 1)
" Flip the toggle so the function sets it to the default
if g:arrowsenabled == 0
	let g:arrowsenabled = 1
else
	let g:arrowsenabled = 0
endif
call <SID>ToggleArrowsFn()

" no <silent> <C-Left> :bprevious<CR>
" no <silent> <C-Right> :bnext<CR>

" Numpad Motions
no <kPlus> gk
no <kEnter> gj
no <kMinus> gg
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

augroup FormatOptions
	au Filetype html setlocal formatoptions=tmM
augroup END



" " exchange word under cursor with the next word without moving the cursor
" nnoremap gw "_yiw:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR><C-o><C-l>
"
" " push word under cursor to the left
" nnoremap <silent> <Leader><Left> "_yiw?\w\+\_W\+\%#<CR>:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR><C-o><C-l>
"
" " push word under cursor to the right
" nnoremap <silent> <Leader><Right> "_yiw:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR><C-o>/\w\+\_W\+<CR><C-l>

set completeopt=menu,menuone,noselect

lua << EOF
local cmp = require('cmp')

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

cmp.setup({
	completion = {
		autocomplete = false
	},
	snippet = {
		expand = function (args)
			vim.fn['vsnip#anonymous'](args.body)
		end
	},
	mapping = {
		['<S-Tab>'] = cmp.mapping(function (fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif vim.fn['vsnip#available'](1) == 1 then
				feedkey('<Plug>(vsnip-expand-or-jump)', '')
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end, { 'i' }),
		['<Down>'] = { i = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }) },
		['<Up>'] = { i = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }) },
		['<ESC>'] = { i = cmp.mapping.abort() },
		['<Space>'] = cmp.mapping(function (fallback)
			if cmp.visible() then
				cmp.mapping.confirm({ select = false })
			else
				fallback()
			end
		end, { 'i' })
	},
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		{ name = 'vsnip' }
	}, {
		{ name = 'buffer' }
	})
})

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

local opts = { noremap = true, silent = true }
vim.keymap.set('n', 'ge', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', 'gE', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', '<C-e>', vim.diagnostic.open_float, opts)

local onAttach = function(client, bufno)
	local opts = { noremap = true, silent = true, buffer = bufno }
	vim.keymap.set('n', '<C-h>', vim.lsp.buf.hover, opts)
	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
end

local lspconfig = require('lspconfig')

lspconfig.tsserver.setup({
	on_attach = onAttach,
	capabilities = capabilities,
		root_dir = function (path)
			local denoPath = lspconfig.util.root_pattern('deno.json', 'deno.jsonc')(path)
			if denoPath then return end
			return lspconfig.util.root_pattern('tsconfig.json')(path)
				or lspconfig.util.root_pattern('package.json', 'jsconfig.json', '.git')(path)
		end,
	settings = {
		typescript = {
			format = {
				enable = false,
				trimTrailingWhitespace = false
			}
		},
		diagnostics = {
			ignoredCodes = {
				2350, -- Only void function can be called with new
				7043, 7044, 7045, 7056, 7047, 7048, 7049, 7050, -- Implicit any warnings
				2365 -- Operator can't be applied to types
			}
		}
	}
})

lspconfig.denols.setup({
	on_attach = onAttach,
	capabilities = capabilities,
	root_dir = lspconfig.util.root_pattern('deno.json', 'deno.jsonc'),
	init_options = {
		enable = true,
		unstable = false,
		lint = false
	}
})

vim.g.markdown_fenced_languages = {
	'ts=typescript'
}

lspconfig.pyright.setup({
	on_attach = onAttach,
	capabilities = capabilities
})

lspconfig.csharp_ls.setup({
	on_attach = onAttach,
	capabilities = capabilities
})

lspconfig.rust_analyzer.setup({
	on_attach = onAttach,
	capabilities = capabilities
})

lspconfig.clangd.setup({
	on_attach = onAttach,
	capabilities = capabilities
})

vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
	vim.lsp.diagnostic.on_publish_diagnostics, {
		-- delay update diagnostics
		update_in_insert = false,
	}
)
EOF