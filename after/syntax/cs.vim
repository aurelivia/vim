let s:colors = onedark#GetColors()
function! s:h(group, style)
  let l:highlight = a:style

  if g:onedark_terminal_italics == 0
    if has_key(l:highlight, "cterm") && l:highlight["cterm"] == "italic"
      unlet l:highlight.cterm
    endif
    if has_key(l:highlight, "gui") && l:highlight["gui"] == "italic"
      unlet l:highlight.gui
    endif
  endif

  if g:onedark_termcolors == 16
    let l:ctermfg = (has_key(l:highlight, "fg") ? l:highlight.fg.cterm16 : "NONE")
    let l:ctermbg = (has_key(l:highlight, "bg") ? l:highlight.bg.cterm16 : "NONE")
  else
    let l:ctermfg = (has_key(l:highlight, "fg") ? l:highlight.fg.cterm : "NONE")
    let l:ctermbg = (has_key(l:highlight, "bg") ? l:highlight.bg.cterm : "NONE")
  endif

  execute "highlight" a:group
    \ "guifg="   (has_key(l:highlight, "fg")    ? l:highlight.fg.gui   : "NONE")
    \ "guibg="   (has_key(l:highlight, "bg")    ? l:highlight.bg.gui   : "NONE")
    \ "guisp="   (has_key(l:highlight, "sp")    ? l:highlight.sp.gui   : "NONE")
    \ "gui="     (has_key(l:highlight, "gui")   ? l:highlight.gui      : "NONE")
    \ "ctermfg=" . l:ctermfg
    \ "ctermbg=" . l:ctermbg
    \ "cterm="   (has_key(l:highlight, "cterm") ? l:highlight.cterm    : "NONE")
endfunction

syn match csArrow "[()=>]" contained display
syn match csArrowStatement "(.\{-})\s\{-}=>" transparent contains=csArrow
hi def link csArrow Operator

syntax match csFuncCall /\<\K\k*\ze\s*(/
hi def link csFuncCall Function

syn keyword csType bool byte char decimal double float int long object sbyte short string T uint ulong ushort void dynamic
syn keyword csModifier abstract const extern internal override private protected public readonly sealed static var virtual volatile
hi! def link csConstant Boolean
hi! def link csGenericBraces Operator
call s:h('csModifier', { 'fg': s:colors.purple })