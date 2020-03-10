set nocompatible
filetype plugin on
filetype indent on
let g:vim_path = $HOME . '/.vim/'
let g:vimrc = g:vim_path . '.vimrc'
execute pathogen#infect(g:vim_path . 'packages/{}')
Helptags

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
set listchars=eol:¬,trail:~,extends:>,precedes:<,space:·,tab:->
set nolist

let g:strip_white_space_on_save = 1
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
let g:ctrlp_use_caching = 0
let g:sayonara_confirm_quit = 1
let g:session_directory = g:vim_path . 'sessions'
let g:session_lock_enabled = 0
let g:session_autosave = 'yes'
let g:session_autoload = 'yes'

set backspace=indent,eol,start
set tabstop=2 shiftwidth=2 expandtab autoindent smartindent formatoptions-=t
augroup shiftybehaviour
  autocmd!
  autocmd InsertLeave * :normal `^
augroup END
set virtualedit=onemore
set clipboard=unnamedplus

set autoread
au FocusGained,BufEnter * :checktime

let g:tagbar_left = 1

let g:vim_svelte_plugin_use_pug = 1

set mouse=a
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
nnoremap <silent> qq :Sayonara<CR>
nnoremap <silent> qr :Sayonara<CR>
nnoremap <silent> qa :q!<CR>
nnoremap <silent> Z :w!<CR>

noremap H ^
noremap <S-Left> ^
" noremap <C-h> :bprevious<CR>
noremap <silent> <C-Left> :bprevious<CR>
nmap <BS> <NOP>

" noremap J 5j
noremap <S-Down> 5j
noremap <C-j> <C-d>
noremap <C-Down> <C-d>
noremap <silent> <A-j> :m+1<CR>
noremap <silent> <A-Down> :m+1<CR>
vnoremap <silent> <A-j> :m '>+1<CR>gv
vnoremap <silent> <A-Down> :m '>+1<CR>gv

noremap K 5k
noremap <S-Up> 5k
noremap <C-k> <C-u>
noremap <C-Up> <C-u>
noremap <silent> <A-k> :m-2<CR>
noremap <silent> <A-Up> :m-2<CR>
vnoremap <silent> <A-k> :m '<-2<CR>gv
vnoremap <silent> <A-Up> :m '<-2<CR>gv

noremap L $
noremap <S-Right> $
noremap <silent> <C-l> :bnext<CR>
noremap <silent> <C-Right> :bnext<CR>

nnoremap s <C-w>
nnoremap <silent> <C-f> :TagbarToggle<CR>
nmap <C-d> <Plug>(dirvish_up)
augroup dirvish_config
  autocmd!
  autocmd FileType dirvish nmap <buffer> <Left> <Plug>(dirvish_up)
  autocmd FileType dirvish nmap <buffer> <Right> <CR>
  autocmd FileType dirvish nmap <buffer> <C-d> <Plug>(dirvish_quit)
augroup END

nnoremap <CR> i
nnoremap U <C-r>
nnoremap c<CR> ciw
nnoremap <Leader>c ciw
inoremap <CR> <ESC>
inoremap <F12> <CR>
nnoremap <Space><Space> :

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

nnoremap dd "_dd
nnoremap dy dd
nnoremap x "_x
nnoremap X "_X
vnoremap x "_x
vnoremap X "_X

vnoremap / y/<C-R>"<CR>
nnoremap <silent> <Leader><CR> :let @/=''<CR>
nnoremap <silent> <Leader>\ :StripWhitespace<CR>
nnoremap <silent> \ :set list!<CR>
" nnoremap <Leader>s :ToggleWorkspace<CR>
" nnoremap <Leader>s :mksession!<CR>
" nnoremap <Leader>rs :!rm ~/Dropbox/.vim/sessions/*<CR>
" nnoremap <Leader>rs :silent !rm Session.vim | :redraw!<CR>

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
