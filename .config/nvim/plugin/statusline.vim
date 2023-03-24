" StatusLineHighlight.vim: Change statusline color depending on buffer state.
"
" DEPENDENCIES:
"
" Copyright: (C) 2010-2022 Ingo Karkat
"   The VIM LICENSE applies to this script; see ':help copyright'.
"
" Maintainer:	Ingo Karkat <ingo@karkat.de>

" Avoid installing twice, when in unsupported Vim version, or there are no
" colors.
" if exists('g:loaded_StatusLineHighlight') || (v:version < 700) || (! has('gui_running') && &t_Co <= 2)
"     finish
" endif
" let g:loaded_StatusLineHighlight = 1
"
" "- default highlightings ------------------------------------------------------
"
" " You may define your own colors in your vimrc file, in the form as below:
" "
" " Note: Some terminals (the Windows console) cannot mix cterm=reverse with
" " coloring (cp. :help highlight-cterm). Override the default settings if this
" " doesn't work for you; e.g. you could emulate the inversion by specifying the
" " background color as the foreground color. The Windows console also doesn't
" " support cterm=bold, so you may already have a special case for it, anyway.
" function! s:DefaultHighlightings()
"     highlight def StatusLineModified           term=bold,reverse cterm=bold,reverse ctermfg=DarkRed  gui=bold,reverse guifg=DarkRed
"     highlight def StatusLineModifiedNC         term=reverse      cterm=reverse      ctermfg=DarkRed  gui=reverse      guifg=DarkRed
"     highlight def StatusLinePreview            term=bold,reverse cterm=bold,reverse ctermfg=Blue     gui=bold,reverse guifg=Blue
"     highlight def StatusLinePreviewNC          term=reverse      cterm=reverse      ctermfg=Blue     gui=reverse      guifg=Blue
"     highlight def StatusLinePrompt             term=bold,reverse cterm=bold,reverse ctermfg=Green    gui=bold,reverse guifg=SeaGreen
"     highlight def StatusLinePromptNC           term=reverse      cterm=reverse      ctermfg=Green    gui=reverse      guifg=SeaGreen
"     highlight def StatusLineReadonly           term=bold,reverse cterm=bold,reverse ctermfg=Grey     gui=bold,reverse guifg=DarkGrey
"     highlight def StatusLineReadonlyNC         term=reverse      cterm=reverse      ctermfg=Grey     gui=reverse      guifg=DarkGrey
"     highlight def StatusLineSpecial            term=bold,reverse cterm=bold,reverse ctermfg=DarkBlue gui=bold,reverse guifg=DarkBlue
"     highlight def StatusLineSpecialNC          term=reverse      cterm=reverse      ctermfg=DarkBlue gui=reverse      guifg=DarkBlue
"     highlight def StatusLineUnmodifiable       term=bold,reverse cterm=bold,reverse ctermfg=Grey     gui=bold,reverse guifg=Grey
"     highlight def StatusLineUnmodifiableNC     term=reverse      cterm=reverse      ctermfg=Grey     gui=reverse      guifg=Grey
" endfunction
" call s:DefaultHighlightings()
"
"
" "- functions ------------------------------------------------------------------
"
" function! s:DefaultStatusline()
"     " With the prepended highlight group, an empty 'statusline' setting has a
"     " different meaning: the status line would be colored, but completely empty.
"     " Thus, we have to emulate Vim's default status line here.
"     return '%<%f %h%m%r' . (&ruler ? '%=%-14.(%l,%c%V%) %P' : '')
" endfunction
" function! s:SubstituteDefaultHighlight( statusline, highlightName )
"     return substitute(a:statusline, '%0\?\*', a:highlightName, 'g')
" endfunction
" function! s:SetHighlight( name )
"     let l:highlightName = '%#StatusLine' . a:name . '#'
"     let l:statuslineWithHighlight = l:highlightName . (empty(&g:stl) ? s:DefaultStatusline() : s:SubstituteDefaultHighlight(&g:stl, l:highlightName))
"
"     if &l:stl ==# l:statuslineWithHighlight
" 	" The highlight is already set; nothing to do.
" 	return
"     endif
"
"     if empty(&l:stl)
" 	" There's no local setting so far; simply customize the global setting
" 	" with the passed highlight group.
" 	let &l:stl = l:statuslineWithHighlight
"     else
" 	" There exists a local setting; this may be one of our highlight
" 	" customizations with a different highlight group, or an actual
" 	" window-local statusline set by either the user or a filetype plugin.
" "****D echomsg '*** old: ' . strpart(&l:stl, 0, 25) . ' new: ' strpart(l:statuslineWithHighlight, 0, 25)
" 	if strpart(&l:stl, 0, 2) ==# '%!'
" 	    " Prevent "E539: Illegal character <!>" when expression evaluation
" 	    " is used.
" 	    return
" 	endif
"
" 	let l:statuslineWithoutHighlight = substitute(&l:stl, '\C%#StatusLine\w\+#', '%*', 'g')
" 	if &l:stl ==# l:statuslineWithoutHighlight
" 	    " There actually was an actual window-local statusline. Save it so
" 	    " that it can be restored instead of overwriting it with the global
" 	    " statusline.
" 	    let w:save_statusline = l:statuslineWithoutHighlight
" 	    let &l:stl = l:highlightName .  s:SubstituteDefaultHighlight(l:statuslineWithoutHighlight, l:highlightName)
" 	else
" 	    let &l:stl = s:SubstituteDefaultHighlight(l:statuslineWithoutHighlight, l:highlightName)
" 	endif
"     endif
" endfunction
" function! s:ClearHighlight()
"     if &l:stl !~# '^%#StatusLine\w\+#'
" 	" There was none of our highlight customizations.
" 	return
"     endif
"
"     if exists('w:save_statusline')
" 	" Restore the saved window-local setting.
" 	let &l:stl = w:save_statusline
" 	unlet w:save_statusline
"     else
" 	" Restore the global setting.
" 	setlocal stl&
"     endif
" endfunction
" function! s:StatusLineHighlight( isEnter )
"   let l:notCurrent = (a:isEnter ? '' : 'NC')
"   if &l:previewwindow
"     call s:SetHighlight('Preview' . l:notCurrent)
"   elseif &l:buftype ==# 'terminal'
"     call s:ClearHighlight()
"   elseif &l:buftype ==# 'prompt'
"     call s:SetHighlight('Prompt' . l:notCurrent)
"   elseif &l:modified
"     call s:SetHighlight('Modified' . l:notCurrent)
"   elseif ! (&l:buftype ==# '' || &l:buftype ==# 'acwrite')
"     call s:SetHighlight('Special' . l:notCurrent)
"   elseif ! &l:modifiable
"     call s:SetHighlight('Unmodifiable' . l:notCurrent)
"   elseif &l:readonly
"     call s:SetHighlight('Readonly' . l:notCurrent)
"   else
"     call s:ClearHighlight()
"   endif
"   return ''
" endfunction
"
"
" "- autocmds -------------------------------------------------------------------
"
" function! s:StatusLineGetModification()
"   augroup StatusLineHighlightModification
"     autocmd!
"     autocmd CursorMovedI * if &l:modified | call <SID>StatusLineHighlight(1) | execute 'autocmd! StatusLineHighlightModification' | endif
"   augroup END
" endfunction
"
" augroup StatusLineHighlight
"   autocmd!
"   autocmd BufWinEnter,WinEnter,CmdwinEnter,CursorHold,CursorHoldI,BufWritePost * call <SID>StatusLineHighlight(1)
"   autocmd WinLeave * call <SID>StatusLineHighlight(0)
"   autocmd InsertEnter * if ! &l:modified | call <SID>StatusLineGetModification() | endif
"   autocmd ColorScheme * call <SID>DefaultHighlightings()
"
"   if exists('##OptionSet')
"     autocmd OptionSet previewwindow,modified,modifiable,readonly call <SID>StatusLineHighlight(1)
"   endif
" augroup END

" vim: set ts=8 sts=4 sw=4 noexpandtab ff=unix fdm=syntax :

" set laststatus=2
" highlight User1 guibg=Black guifg=DarkYellow
" highlight mid guibg=DarkRed guifg=Yellow
"
" let s:default = '%1* %n: %f %y %=%6v%6l%6L %*'
" let s:changed =  '%1* %n: %f %y %#mid#%m%=%1*%6v%6l%6L %*'
"
" fun IsModified()
"     if &modified
"         return s:changed
"     endif
"     return s:default
" endfun
" autocmd BufEnter * set statusline=%!IsModified()
" autocmd BufLeave * let &l:statusline = IsModified()

" set statusline+=%#IsModified#%{&mod?'[THIS BUFFER IS MODIFIED!!!]':''}%*
" set statusline+=%#IsNotModified#%{&mod?'':'[THIS BUFFER IS PRISTINE!!!]'}%*
" " scriptencoding utf-8
"
" " cf the default statusline: %<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P
"
" if has('statusline')
"   let s:gb = {}
"   " gruvbox
" "  let s:gb.left_bg   = '#CC241D'
" "  let s:gb.left_fg   = '#FBF1C7'
" "  let s:gb.center_bg = '#3C3836'
" "  let s:gb.center_fg = '#A89984'
" "  let s:gb.right_bg  = '#A89984'
" "  let s:gb.right_fg  = '#282828'
"
"   " duskfox
"   let s:gb.left_fg   = '#65b1cd'
"   let s:gb.left_bg   = '#393552'
"   let s:gb.center_bg = '#393552'
"   let s:gb.center_fg = '#c6c2ef'
"   let s:gb.right_bg  = '#f6f2ee'
"   let s:gb.right_fg  = '#534c45'
"   let s:gb.filetype_fg = '#f6c177'
"
"   " ===== Left =====
"   " Buffer number
"   execute 'hi User7 guibg='.s:gb.left_fg.' guifg='.s:gb.left_fg
"   " Arrow bit
"   execute 'hi User4 guibg='.s:gb.center_bg.' guifg='.s:gb.left_bg
"
"   " ===== Center =====
"   " Pathname
"   execute 'hi User1 guibg='.s:gb.center_bg.' guifg='.s:gb.center_fg
"   " Filename
"   execute 'hi User3 guibg='.s:gb.center_bg.' guifg='.s:gb.center_fg.' gui=bold'
"   " Filetype
"   execute 'hi User2 guibg='.s:gb.center_bg.' guifg='.s:gb.filetype_fg
"
"   " ===== Right =====
"   " Arrow bit
"   execute 'hi User5 guibg='.s:gb.center_bg.' guifg='.s:gb.right_bg
"   " Fileinfo
"   execute 'hi User6 guibg='.s:gb.right_bg.' guifg='.s:gb.right_fg.' gui=bold'
"
"   " ===== Left =====
"   set statusline=%7*                         " Switch to User7 highlight group
"   set statusline+=%{statusline#lhs()}
"   set statusline+=%*                         " Reset highlight group.
"   "set statusline+=%4*                        " Switch to User4 highlight group (Powerline arrow).
"   "set statusline+=                          " Powerline arrow.
"   "set statusline+=%*                         " Reset highlight group.
"
"   " ===== Center =====
"   set statusline+=%1*                        " Switch to User3 highlight group (bold).
"   set statusline+=\                          " Space.
"   set statusline+=%<                         " Truncation point, if not enough width available.
"   set statusline+=%{statusline#fileprefix()} " Relative path to file's directory.
"   set statusline+=%*                         " Reset highlight group.
"   set statusline+=%3*                         " Reset highlight group.
"   set statusline+=%t                         " Filename.
"   set statusline+=\                          " Space.
"   set statusline+=%*                         " Reset highlight group.
"   set statusline+=%2*                        " Switch to User2 highlight group (italics).
"   " Needs to be all on one line:
"   "   %(                   Start item group.
"   "   [                    Left bracket (literal).
"   "   %M                   Modified flag: ,+/,- (modified/unmodifiable) or nothing.
"   "   %R                   Read-only flag: ,RO or nothing.
"   "   %{statusline#ft()}   Filetype (not using %Y because I don't want caps).
"   "   %{statusline#fenc()} File-encoding if not UTF-8.
"   "   ]                    Right bracket (literal).
"   "   %)                   End item group.
"   set statusline+=%([%M%R%{statusline#ft()}%{statusline#fenc()}]%)
"
"   "set statusline+=%*   " Reset highlight group.
"   set statusline+=%=   " Split point for left and right groups.
"
"   set statusline+=\    " Space.
"   set statusline+=%*   " Reset highlight group.
"
"   " ===== Right =====
"   "set statusline+=%5*  " Switch to User5 highlight group.
"   "set statusline+=    " Powerline arrow.
"   "set statusline+=%*   " Reset highlight group.
"   set statusline+=%6*  " Switch to User6 highlight group.
"   "set statusline+=\    " Space.
"   set statusline+=%{statusline#rhs()}
"   "set statusline+=\    " Space.
"   set statusline+=%*   " Reset highlight group.
"
"   " these don't get triggered for some reason
" "  if has('autocmd')
" "    augroup WincentStatusline
" "      autocmd!
" "      autocmd ColorScheme * call statusline#update_highlight()
" "    augroup END
" "  endif
" endif
