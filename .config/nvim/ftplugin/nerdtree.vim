setlocal colorcolumn=

if has('folding')
  setlocal nofoldenable
endif

setlocal nolist

nmap <buffer> <expr> - g:NERDTreeMapUpdir
