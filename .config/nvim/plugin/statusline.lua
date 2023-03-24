local augroup = user.vim.augroup
local autocmd = user.vim.autocmd

augroup('userStatusline', function()
  autocmd(
    'BufWinEnter,BufWritePost,FileWritePost,TextChanged,TextChangedI,WinEnter,VimEnter',
    '*',
    user.statusline.check_modified
  )
  autocmd('ColorScheme', '*', user.statusline.update_highlight)
  autocmd('User', 'FerretAsyncStart', user.statusline.async_start)
  autocmd('User', 'FerretAsyncFinish', user.statusline.async_finish)
end)


  -- autocmd BufWinEnter,WinEnter,CmdwinEnter,CursorHold,CursorHoldI,BufWritePost * call <SID>StatusLineHighlight(1)
  -- autocmd WinLeave * call <SID>StatusLineHighlight(0)
  -- autocmd InsertEnter * if ! &l:modified | call <SID>StatusLineGetModification() | endif

user.statusline.set()
user.statusline.update_highlight()
