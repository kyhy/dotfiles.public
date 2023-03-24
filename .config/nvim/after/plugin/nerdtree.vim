let NERDTreeShowLineNumbers=1 " enable line numbers
let NERDTreeShowHidden=1      " show hidden files
let g:NERDTreeWinSize=40      " The default of 31 is just a little too narrow.
let g:NERDTreeMinimalUI=1     " Disable display of '?' text and 'Bookmarks' label.
" Let <Leader><Leader> (^#) return from NERDTree window.
let g:NERDTreeCreatePrefix='silent keepalt keepjumps'

" Single-click to toggle directory nodes, double-click to open non-directory nodes.
let g:NERDTreeMouseMode=2

" close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" open containing folder in nerdtree
nnoremap <silent> - :silent edit <C-R>=empty(expand('%')) ? '.' : expand('%:p:h')<CR><CR>

" when nerdtree opens via -, selet current file
if has('autocmd')
  augroup KyhyNERDTree
    autocmd!
    autocmd User NERDTreeInit call s:attempt_select_last_file()
  augroup END
endif

function! s:attempt_select_last_file() abort
  let l:previous=expand('#:t')
  if l:previous != ''
    call search('\v<' . l:previous . '>')
  endif
endfunction

hi default UfoFoldedFg guifg=Normal.foreground
hi default UfoFoldedBg guibg=Folded.background
hi default link UfoPreviewSbar Comment
hi default link UfoPreviewThumb Comment
hi default link UfoPreviewWinBar Comment
hi default link UfoPreviewCursorLine Comment
hi default link UfoFoldedEllipsis Comment
hi default link UfoCursorFoldedLine Comment

