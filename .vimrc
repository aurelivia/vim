set nocompatible
filetype plugin on
filetype indent on
let s:vim_path = $HOME . '/.vim/'
execute pathogen#infect(s:vim_path . 'packages/{}')
let s:vimrc = s:vim_path . '.vimrc'

syntax enable
set number
set relativenumber
set enc=utf-8 fileencodings=utf-8
colorscheme onedark
let g:onedark_hide_endofbuffer = 1
let g:onedark_termcolors = 256
let g:onedark_terminal_italics = 1

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
set hidden noshowmode shortmess=F noshowcmd
set incsearch " hlsearch

let g:strip_white_space_on_save = 1
let g:workspace_session_directory = $HOME . s:vim_path . 'sessions/'
let g:workspace_undodir = $HOME . s:vim_path . 'sessions/.undodir'
let g:workspace_session_disable_on_args = 1
let g:workspace_autosave = 0

set backspace=indent,eol,start
set tabstop=2 shiftwidth=2 expandtab autoindent smartindent formatoptions-=t
augroup shiftybehaviour
  autocmd!
  autocmd InsertLeave * :normal `^
augroup END
set virtualedit=onemore
set clipboard=unnamedplus

autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let g:NERDSpaceDelims = 1
let g:NERDTreeWinSize = 40
let g:tagbar_left = 1

let g:vim_svelte_plugin_use_pug = 1

set mouse=a
let mapleader = ' '

nnoremap Q q
nnoremap qq :NERDTreeClose<CR>:Sayonara<CR>
nnoremap qr :NERDTreeClose<CR>:Sayonara<CR>:NERDTreeToggle<CR>
nnoremap qa :NERDTreeClose<CR>:q!<CR>
nnoremap Z :silent :w!<CR>

noremap H ^
noremap <S-Left> ^
" noremap <C-h> :bprevious<CR>
noremap <C-Left> :bprevious<CR>
nmap <BS> <NOP>

" noremap J 5j
noremap <S-Down> 5j
noremap <C-j> <C-d>
noremap <C-Down> <C-d>
noremap <A-j> :m+1<CR>
noremap <A-Down> :m+1<CR>
vnoremap <A-j> :m '>+1<CR>gv
vnoremap <A-Down> :m '>+1<CR>gv

noremap K 5k
noremap <S-Up> 5k
noremap <C-k> <C-u>
noremap <C-Up> <C-u>
noremap <A-k> :m-2<CR>
noremap <A-Up> :m-2<CR>
vnoremap <A-k> :m '<-2<CR>gv
vnoremap <A-Down> :m '<-2<CR>gv

noremap L $
noremap <S-Right> $
noremap <C-l> :bnext<CR>
noremap <C-Right> :bnext<CR>

nnoremap <C-\> :NERDTreeToggle<CR>
nnoremap <C-d> :NERDTreeToggle<CR>
nnoremap <C-f> :TagbarToggle<CR>

nnoremap <CR> i
nnoremap c<CR> ciw
nnoremap <Leader>c ciw
inoremap <CR> <ESC>
inoremap <F12> <CR>
nnoremap <Space><Space> :

" command! Evimrc :e '' . s:vimrc
command! Evimrc execute 'e ' . s:vimrc
command! Svimrc execute 'so ' . s:vimrc
command! Eawesome :e ~/.config/awesome/rc.lua | :e ~/.config/awesome/theme.lua

nnoremap c' ci'
nnoremap c" ci"
nnoremap c{ ci{
nnoremap c[ ci[
nnoremap c( ci(
nnoremap c<Space> F<Space>lct<Space>
nnoremap p P
nnoremap P p

nnoremap dd "_dd
nnoremap dy dd
nnoremap x "_x
nnoremap X "_X
vnoremap x "_x
vnoremap X "_X

nnoremap s vy
nnoremap sr vp

vnoremap / y/<C-R>"<CR>
nnoremap <Leader><CR> :let @/=''<CR>
nnoremap <Leader>\ :StripWhitespace<CR>
" nnoremap <Leader>s :ToggleWorkspace<CR>
nnoremap <Leader>s :mksession!<CR>
" nnoremap <Leader>rs :!rm ~/Dropbox/.vim/sessions/*<CR>
nnoremap <Leader>rs :silent !rm Session.vim<CR>:redraw!<CR>

inoremap <C-b> <Left><CR><CR><ESC>ki<Tab>

autocmd FileType javascript inoremap <buffer> <C-f> <ESC>F<Space>i<Space>=><Space>{<CR><CR>}<ESC>ki<Tab>

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

com! FormatJSON :call FormatJSON()
function! FormatJSON()
  %!python -c "import json, sys, collections;print(json.dumps(json.load(sys.stdin, object_pairs_hook=collections.OrderedDict), indent=2))"
  %s/\\u\(\x\{4\}\)/\=nr2char('0x'.submatch(1),1)/g
endfunction
