hi ActiveWindow guibg=#232136
hi InactiveWindow guibg=#2d2a45

augroup WindowManagement
  autocmd!
  autocmd WinEnter * call OnWinEnter()
  autocmd FocusLost * call OnFocusLost()
  autocmd FocusGained * call OnFocusGained()
augroup END

function! OnWinEnter()
  setlocal winhighlight=Normal:ActiveWindow,NormalNC:InactiveWindow,MsgArea:ActiveWindow
  hi MsgArea guibg=#232136
  " hi LineNr guifg=#FF1493
endfunction

function! OnFocusLost()
  setlocal winhighlight=Normal:InactiveWindow,NormalNC:InactiveWindow,MsgArea:InactiveWindow
  hi MsgArea guibg=#2d2a45
  " hi LineNr guifg=#6e6a86
endfunction

function! OnFocusGained()
  setlocal winhighlight=Normal:ActiveWindow,NormalNC:InactiveWindow,MsgArea:ActiveWindow
  hi MsgArea guibg=#232136
  " hi LineNr guifg=#FF1493
endfunction
