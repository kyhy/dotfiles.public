-- set.foldmethod = "expr"
-- set.foldexpr = "nvim_treesitter#foldexpr()"
-- set.foldlevel = 4
-- set.foldlevelstart = 4
-- -- set.foldmethod = 'indent' -- not as cool as syntax, but faster
-- set.foldtext = 'v:lua.user.foldtext()'

-- vim.o.foldcolumn = '1' -- '0' is not bad
vim.o.foldcolumn = '0'
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true
-- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
local ufo = require('ufo');

function Tab()
  local line = vim.fn.line('.')
  local fold_end = vim.fn.foldclosed(line)

  if fold_end ~= -1 then
    -- The current line is folded
    -- Do something here
    -- ufo.openAllFolds()
    -- vim.cmd('zA')
    vim.api.nvim_command('normal! zA')
    return
  end

  -- ufo.closeAllFolds()
  -- vim.cmd('za')
  vim.api.nvim_command('normal! za')
  -- The current line is not folded
  -- Do something else here
end

vim.keymap.set('n', '<Tab>', Tab, { silent = true })
-- vim.keymap.set('n', '<Tab>', 'za', { silent = true })

vim.keymap.set('n', 'zR', ufo.openAllFolds)
vim.keymap.set('n', 'zM', ufo.closeAllFolds)
vim.keymap.set('n', 'zr', ufo.openFoldsExceptKinds)
vim.keymap.set('n', 'zm', ufo.closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)
vim.keymap.set('n', 'K', function()
    local winid = ufo.peekFoldedLinesUnderCursor()
    if not winid then
        vim.lsp.buf.hover()
    end
end)

-- NOTE: Fix bug when file opened with telescope doesn't fold 
vim.api.nvim_create_autocmd('BufRead', {
   callback = function()
      vim.api.nvim_create_autocmd('BufWinEnter', {
         once = true,
         command = 'normal! zx'
      })
   end
})

-- local middot = '·'
-- local raquo = '»'
-- local small_l = 'ℓ'

-- vim.cmd('hi Folded guibg=#433c59')
-- vim.cmd('hi Folded guibg=#47407d')
vim.cmd('hi Folded guibg=#322e42')

local handler = function(virtText, lnum, endLnum, width, truncate)
  local newVirtText = {}
  local suffix = (' ℓ %d '):format(endLnum - lnum)
  local sufWidth = vim.fn.strdisplaywidth(suffix)
  local targetWidth = width - sufWidth
  local curWidth = 0
  for _, chunk in ipairs(virtText) do
    local chunkText = chunk[1]
    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
    if targetWidth > curWidth + chunkWidth then
      table.insert(newVirtText, chunk)
    else
      chunkText = truncate(chunkText, targetWidth - curWidth)
      local hlGroup = chunk[2]
      table.insert(newVirtText, {chunkText, hlGroup})
      chunkWidth = vim.fn.strdisplaywidth(chunkText)
      -- str width returned from truncate() may less than 2nd argument, need padding
      if curWidth + chunkWidth < targetWidth then
        suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
      end
      break
    end
    curWidth = curWidth + chunkWidth
  end
  table.insert(newVirtText, {suffix, 'Comment'})
  return newVirtText
end

require('ufo').setup({
  fold_virt_text_handler = handler,
  close_fold_kinds = {'imports', 'comment'},
  open_fold_hl_timeout = 0,
  provider_selector = function(bufnr, filetype, buftype)
    return {'treesitter', 'indent'}
  end
})
