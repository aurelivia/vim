no j h
no k gj
no l gk
no ; l
no h ;

no J <NOP>
no K 10gj
no L 10gk

no <silent> <C-j> :bprevious<CR>
no <C-k> zz<C-d>
no <C-l> zz<C-u>
no <silent> <C-;> :bnext<CR>

nn <CR> a
ino <CR> <ESC>
nm <BS> <NOP>
" map <S-CR> <NOP>

no <Space><Space> :
no <Space><CR> @:

nn <silent> Z :silent w<CR>
nn <silent> qq :Sayonara!<CR>
nn <silent> qr :Sayonara<CR>
nn qa :q!<CR>
nm q <NOP>
nn <C-m> q
nn s <C-w>
nn U <C-r>

nn c<CR> <NOP>
no d "_d
nn dd "_dd
no x d
no xx dd

nn p P
nn P p
vn p "_dP

map <silent> w <Plug>WordMotion_w
map <silent> b <Plug>WordMotion_b
map <silent> e <Plug>WordMotion_e
map <silent> ge <Plug>WordMotion_ge
omap <silent> iw <Plug>WordMotion_iw
xmap <silent> iw <Plug>WordMotion_iw
omap <silent> aw <Plug>WordMotion_aw
xmap <silent> aw <Plug>WordMotion_aw

nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)

nn <silent> <F11> :syntax sync fromstart<CR>

nn <silent> \ :set list!<CR>
nn <silent> <Leader>\ :StripWhitespace<CR>

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