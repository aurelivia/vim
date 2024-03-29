" [onedark.vim](https://github.com/joshdick/onedark.vim/)

" This is a [vim-airline](https://github.com/vim-airline/vim-airline) theme for use with
" the [onedark.vim](https://github.com/joshdick/onedark.vim) colorscheme.

" It is based on vim-airline's ["tomorrow" theme](https://github.com/vim-airline/vim-airline-themes/blob/master/autoload/airline/themes/tomorrow.vim).
function! airline#themes#onedark#refresh()
let s:colors = {
\  'background': { 'gui': '#2C2C2C', 'cterm': 'NONE', 'cterm16': 'NONE' },
\  'black': { 'gui': '#2C2C2C', 'cterm': 'NONE', 'cterm16': 'NONE' },
\  'foreground': { 'gui': '#AFAFAF', 'cterm': 'NONE', 'cterm16': 'NONE' },
\  'white': { 'gui': '#AFAFAF', 'cterm': 'NONE', 'cterm16': 'NONE' },
\  'comment_grey': { 'gui': '#5F5F5F', 'cterm': '59', 'cterm16': '7' },
\  'gutter_fg_grey': { 'gui': '#444444', 'cterm': '238', 'cterm16': '8' },
\  'cursor_grey': { 'gui': '#303030', 'cterm': '236', 'cterm16': '0' },
\  'visual_grey': { 'gui': '#3A3A3A', 'cterm': '237', 'cterm16': '8' },
\  'menu_grey': { 'gui': '#3A3A3A', 'cterm': '237', 'cterm16': '7' },
\  'special_grey': { 'gui': '#444444', 'cterm': '238', 'cterm16': '7' },
\  'vertsplit': { 'gui': '#3A3A3A', 'cterm': '59', 'cterm16': '7' },
\  'yellow': { 'gui': '#D7AF87', 'cterm': '180', 'cterm16': '3' },
\  'dark_yellow': { 'gui': '#D7875F', 'cterm': '173', 'cterm16': '11' },
\  'red': { 'gui': '#E06C75', 'cterm': '204', 'cterm16': '1' },
\  'dark_red': { 'gui': '#BE5046', 'cterm': '196', 'cterm16': '9' },
\  'green': { 'gui': '#98C379', 'cterm': '114', 'cterm16': '2' },
\  'blue': { 'gui': '#61AFEF', 'cterm': '39', 'cterm16': '4' },
\  'purple': { 'gui': '#C678DD', 'cterm': '170', 'cterm16': '5' },
\  'cyan': { 'gui': '#56B6C2', 'cterm': '38', 'cterm16': '6' }
\}

  if get(g:, 'onedark_termcolors', 256) == 16
    let s:term_red = s:colors.red.cterm16
    let s:term_green = s:colors.green.cterm16
    let s:term_yellow = s:colors.yellow.cterm16
    let s:term_blue = s:colors.blue.cterm16
    let s:term_purple = s:colors.purple.cterm16
    let s:term_white = s:colors.white.cterm16
    let s:term_cursor_grey = s:colors.cursor_grey.cterm16
    let s:term_visual_grey = s:colors.visual_grey.cterm16
  else
    let s:term_red = s:colors.red.cterm
    let s:term_green = s:colors.green.cterm
    let s:term_yellow = s:colors.yellow.cterm
    let s:term_blue = s:colors.blue.cterm
    let s:term_purple = s:colors.purple.cterm
    let s:term_white = s:colors.white.cterm
    let s:term_cursor_grey = s:colors.cursor_grey.cterm
    let s:term_visual_grey = s:colors.visual_grey.cterm
  endif

  let g:airline#themes#onedark#palette = {}

  let g:airline#themes#onedark#palette.accents = {
        \ 'red': [ s:colors.red.gui, '', s:term_red, 0 ]
        \ }

  let s:N1 = [ s:colors.cursor_grey.gui, s:colors.green.gui, s:term_cursor_grey, s:term_green ]
  let s:N2 = [ s:colors.white.gui, s:colors.visual_grey.gui, s:term_white, s:term_visual_grey ]
  let s:N3 = [ s:colors.green.gui, s:colors.cursor_grey.gui, s:term_green, s:term_cursor_grey ]
  let g:airline#themes#onedark#palette.normal = airline#themes#generate_color_map(s:N1, s:N2, s:N3)

  let group = airline#themes#get_highlight('vimCommand')
  let g:airline#themes#onedark#palette.normal_modified = {
        \ 'airline_c': [ group[0], '', group[2], '', '' ]
        \ }

  let s:I1 = [ s:colors.cursor_grey.gui, s:colors.blue.gui, s:term_cursor_grey, s:term_blue ]
  let s:I2 = s:N2
  let s:I3 = [ s:colors.blue.gui, s:colors.cursor_grey.gui, s:term_blue, '' ]
  let g:airline#themes#onedark#palette.insert = airline#themes#generate_color_map(s:I1, s:I2, s:I3)
  let g:airline#themes#onedark#palette.insert_modified = g:airline#themes#onedark#palette.normal_modified

  let s:R1 = [ s:colors.cursor_grey.gui, s:colors.red.gui, s:term_cursor_grey, s:term_red ]
  let s:R2 = s:N2
  let s:R3 = [ s:colors.red.gui, s:colors.cursor_grey.gui, s:term_red, '' ]
  let g:airline#themes#onedark#palette.replace = airline#themes#generate_color_map(s:R1, s:R2, s:R3)
  let g:airline#themes#onedark#palette.replace_modified = g:airline#themes#onedark#palette.normal_modified

  let s:V1 = [ s:colors.cursor_grey.gui, s:colors.purple.gui, s:term_cursor_grey, s:term_purple ]
  let s:V2 = s:N2
  let s:V3 = [ s:colors.purple.gui, s:colors.cursor_grey.gui, s:term_purple, '' ]
  let g:airline#themes#onedark#palette.visual = airline#themes#generate_color_map(s:V1, s:V2, s:V3)
  let g:airline#themes#onedark#palette.visual_modified = g:airline#themes#onedark#palette.normal_modified

  let s:IA1 = [ s:colors.cursor_grey.gui, s:colors.white.gui, s:term_cursor_grey, s:term_white ]
  let s:IA2 = [ s:colors.white.gui, s:colors.visual_grey.gui, s:term_white, s:term_visual_grey ]
  let s:IA3 = s:N2
  let g:airline#themes#onedark#palette.inactive = airline#themes#generate_color_map(s:IA1, s:IA2, s:IA3)
  let g:airline#themes#onedark#palette.inactive_modified = {
        \ 'airline_c': [ group[0], '', group[2], '', '' ]
        \ }

  " Warning/Error styling code from vim-airline's ["base16" theme](https://github.com/vim-airline/vim-airline-themes/blob/master/autoload/airline/themes/base16.vim)

  " Warnings
  let s:WI = [ s:colors.cursor_grey.gui, s:colors.yellow.gui, s:term_cursor_grey, s:term_yellow ]
  let g:airline#themes#onedark#palette.normal.airline_warning = [
       \ s:WI[0], s:WI[1], s:WI[2], s:WI[3]
       \ ]

  let g:airline#themes#onedark#palette.normal_modified.airline_warning =
      \ g:airline#themes#onedark#palette.normal.airline_warning

  let g:airline#themes#onedark#palette.insert.airline_warning =
      \ g:airline#themes#onedark#palette.normal.airline_warning

  let g:airline#themes#onedark#palette.insert_modified.airline_warning =
      \ g:airline#themes#onedark#palette.normal.airline_warning

  let g:airline#themes#onedark#palette.visual.airline_warning =
      \ g:airline#themes#onedark#palette.normal.airline_warning

  let g:airline#themes#onedark#palette.visual_modified.airline_warning =
      \ g:airline#themes#onedark#palette.normal.airline_warning

  let g:airline#themes#onedark#palette.replace.airline_warning =
      \ g:airline#themes#onedark#palette.normal.airline_warning

  let g:airline#themes#onedark#palette.replace_modified.airline_warning =
      \ g:airline#themes#onedark#palette.normal.airline_warning

  " Errors
  let s:ER = [ s:colors.cursor_grey.gui, s:colors.red.gui, s:term_cursor_grey, s:term_red ]
  let g:airline#themes#onedark#palette.normal.airline_error = [
       \ s:ER[0], s:ER[1], s:ER[2], s:ER[3]
       \ ]

  let g:airline#themes#onedark#palette.normal_modified.airline_error =
      \ g:airline#themes#onedark#palette.normal.airline_error

  let g:airline#themes#onedark#palette.insert.airline_error =
      \ g:airline#themes#onedark#palette.normal.airline_error

  let g:airline#themes#onedark#palette.insert_modified.airline_error =
      \ g:airline#themes#onedark#palette.normal.airline_error

  let g:airline#themes#onedark#palette.visual.airline_error =
      \ g:airline#themes#onedark#palette.normal.airline_error

  let g:airline#themes#onedark#palette.visual_modified.airline_error =
      \ g:airline#themes#onedark#palette.normal.airline_error

  let g:airline#themes#onedark#palette.replace.airline_error =
      \ g:airline#themes#onedark#palette.normal.airline_error

  let g:airline#themes#onedark#palette.replace_modified.airline_error =
      \ g:airline#themes#onedark#palette.normal.airline_error

endfunction

call airline#themes#onedark#refresh()