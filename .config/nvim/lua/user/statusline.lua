 local pinnacle = require('wincent.pinnacle')

local statusline = {}

local async = false
local async_lhs_color = 'Constant'
local default_lhs_color = 'Identifier'
-- local default_lhs_color = '#65b1cd'
 local modified_lhs_color = 'ModeMsg'
 local status_highlight = default_lhs_color

local update_statusline = function(default, action)
  local result
  local filetype = vim.bo.filetype

  if filetype == 'command-t' then
    -- Use Command-T-provided buffer name.
     --
    -- Note that we have to use `vim.fn.bufname()` here to
    -- produce the desired result (eg. "Command-T [Files]").
    -- `vim.api.nvim_buf_get_name(0)` isn't suitable because it prepends
    -- the current working directory (eg. "/Some/path/to/Command-T
    -- [Files]").
    result = '  ' .. vim.fn.bufname()
  elseif filetype == 'diff' then
    if vim.b.isUndotreeBuffer == 1 then
      -- Less ugly than, say, "diffpanel_3".
      result = 'Undotree preview'
    else
      result = 1
    end
  elseif filetype == 'undotree' then
    -- Don't override; undotree does its own thing.
    result = 0
  elseif filetype == 'qf' then
    if action == 'blur' then
      result = '%{v:lua.user.statusline.gutterpadding()}'
        .. ' '
        .. ' '
        .. ' '
        .. ' '
        .. '%<'
        .. '%q'
        .. ' '
        .. '%{get(w:,"quickfix_title","")}'
        .. '%='
    else
      result = vim.g.WincentQuickfixStatusline or ''
    end
  else
    result = 1
  end

  if result == 0 then
    -- Do nothing.
  elseif result == 1 then
    vim.wo.statusline = default
  else
    -- Apply custom statusline.
    vim.wo.statusline = result
  end
end

statusline.async_start = function()
  async = true
  statusline.check_modified()
end

statusline.async_finish = function()
  async = false
  statusline.check_modified()
end

statusline.blur_statusline = function()
  -- Default blurred statusline (buffer number: filename).
  local blurred = '%{v:lua.user.statusline.gutterpadding()}'
  blurred = blurred .. ' ' -- space
  blurred = blurred .. ' ' -- space
  blurred = blurred .. ' ' -- space
  blurred = blurred .. ' ' -- space
  blurred = blurred .. '%<' -- truncation point
  blurred = blurred .. '%f' -- filename
  blurred = blurred .. '%=' -- split left/right halves (makes background cover whole)
  update_statusline(blurred, 'blur')
end

statusline.check_modified = function()
  local bufnr = vim.fn.bufnr('')
  local modified = vim.api.nvim_buf_get_option(bufnr, 'modified')

  if modified then
    status_highlight = modified_lhs_color
    statusline.update_highlight()
  else
    status_highlight = default_lhs_color
    statusline.update_highlight()
  end
  -- Set the statusline color based on whether the buffer is modified or not
  -- local modified = vim.bo.modified
  -- if modified and status_highlight ~= modified_lhs_color then
  --   status_highlight = modified_lhs_color
  --   statusline.update_highlight()
  -- elseif not modified then
  --   if async and status_highlight ~= async_lhs_color then
  --     status_highlight = async_lhs_color
  --     statusline.update_highlight()
  --   elseif not async and status_highlight ~= default_lhs_color then
  --     status_highlight = default_lhs_color
  --     statusline.update_highlight()
  --   end
  -- end
end

-- Returns the 'fileencoding', if it's not UTF-8.
statusline.fileencoding = function()
  local fileencoding = vim.bo.fileencoding
  if #fileencoding > 0 and fileencoding ~= 'utf-8' then
    return ',' .. fileencoding
  else
    return ''
  end
end

-- Returns relative path to current file's directory.
statusline.fileprefix = function()
  local basename = vim.fn.fnamemodify(vim.fn.expand('%:h'), ':p:~:.')
  if basename == '' or basename == '.' then
    return ''
  else
    return basename:gsub('/$', '') .. '/'
  end
end

-- Returns the 'filetype' (not using the %Y format because I don't want caps).
statusline.filetype = function()
  local filetype = vim.bo.filetype
  if #filetype > 0 then
    return ',' .. filetype
  else
    return ''
  end
end

statusline.focus_statusline = function()
  -- `setlocal statusline=` will revert to global 'statusline' setting.
  update_statusline('', 'focus')
end

statusline.gutterpadding = function()
  local signcolumn = 0
  local option = vim.wo.signcolumn
  if option == 'yes' then
    signcolumn = 2
  elseif option == 'auto' then
    local signs = vim.fn.sign_getplaced('')
    if #signs[1].signs > 0 then
      signcolumn = 2
    end
  end

  local minwidth = 6
  local numberwidth = vim.wo.numberwidth
  local row = vim.api.nvim_buf_line_count(0)
  local gutterwidth = math.max((#tostring(row) + 1), minwidth, numberwidth) + signcolumn
  local padding = (' '):rep(gutterwidth - 1)
  return padding
end

statusline.rhs = function()
  local rhs = ' '

  -- if vim.fn.winwidth(0) > 80 then
    local column = vim.fn.virtcol('.')
    local width = vim.fn.virtcol('$')
    local line = vim.api.nvim_win_get_cursor(0)[1]
    local height = vim.api.nvim_buf_line_count(0)

    -- Add padding to stop RHS from changing too much as we move the cursor.
    local padding = #tostring(height) - #tostring(line)
    if padding > 0 then
      rhs = rhs .. (' '):rep(padding)
    end

    -- rhs = rhs .. 'ℓ ' -- (Literal, \u2113 "SCRIPT SMALL L").
    rhs = rhs .. 'l ' -- (Literal, \u2113 "SCRIPT SMALL L").
    rhs = rhs .. line
    rhs = rhs .. '/'
    rhs = rhs .. height
    -- rhs = rhs .. ' 𝚌 ' -- (Literal, \u1d68c "MATHEMATICAL MONOSPACE SMALL C").
    rhs = rhs .. ' c ' -- (Literal, \u1d68c "MATHEMATICAL MONOSPACE SMALL C").
    rhs = rhs .. column
    rhs = rhs .. '/'
    rhs = rhs .. width
    rhs = rhs .. ' '

    -- Add padding to stop rhs from changing too much as we move the cursor.
    if #tostring(column) < 2 then
      rhs = rhs .. ' '
    end
    if #tostring(width) < 2 then
      rhs = rhs .. ' '
    end
  -- end

  return rhs
end

statusline.clean = function()
  local is_modified = vim.api.nvim_buf_get_option(vim.fn.winbufnr(vim.g.statusline_winid), 'modified')
  local padding = statusline.gutterpadding()
  if is_modified == false then
    return padding
  end
  return ''
end

statusline.dirty = function()
  local is_modified = vim.api.nvim_buf_get_option(vim.fn.winbufnr(vim.g.statusline_winid), 'modified')
  local padding = statusline.gutterpadding()
  if is_modified == true then
    return padding
  end
  return ''
end

statusline.set = function()
  -- For comparison, the default statusline is:
  --
  --    %<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P
  --
  vim.opt.statusline = ''
    -- .. '%7*' -- Switch to User7 highlight group
    -- .. '%{&mod? \'dirty\' : \'clean\'}'
    .. '%7*'
    .. '%{v:lua.user.statusline.clean()}'
    .. '%*' -- Reset highlight group.
    .. '%8*'
    .. '%{v:lua.user.statusline.dirty()}'
    .. '%*' -- Reset highlight group.
    -- .. '%{v:lua.user.statusline.lhs()}' -- Red/green/orange modified/activity status.
    .. '%<' -- Truncation point, if not enough width available.
    .. '%3*' -- Switch to User3 highlight group (bold).
    .. ' ' -- Space.
    .. '%{v:lua.user.statusline.fileprefix()}' -- Relative path to file's directory.
    .. '%t' -- Filename.
    .. '%*' -- Reset highlight group.
    .. ' ' -- Space.
    .. '%1*' -- Switch to User1 highlight group (italics).
    .. '%(' -- Start item group.
    .. '[' -- Left bracket (literal).
    .. '%R' -- Read-only flag: ,RO or nothing.
    .. '%{v:lua.user.statusline.filetype()}' -- Filetype (not using %Y because I don't want caps).
    .. '%{v:lua.user.statusline.fileencoding()}' -- File-encoding if not UTF-8.
    .. ']' -- Right bracket (literal).
    .. '%)' -- End item group.
    .. '%*' -- Reset highlight group.
    .. '%=' -- Split point for left and right groups.
    .. ' ' -- Space.
    -- .. '' -- Powerline arrow.
    .. '%5*' -- Switch to User5 highlight group.
    .. '%{v:lua.user.statusline.rhs()}' -- Line/column info.
    .. '%*' -- Reset highlight group.
end

statusline.update_highlight = function()
  local fg = pinnacle.extract_fg(status_highlight)
  -- local bg = pinnacle.extract_bg('StatusLine')
  -- local fg = '#f083a2'
  local bg = '#191726'
  local yellow = '#f6c177'
  local red ='#FF0000'
  -- Update StatusLine to use italics (used for filetype).
  -- local highlight = pinnacle.italicize('StatusLine')
  -- vim.cmd('highlight User1 ' .. highlight)
  
  -- Set the statusline color based on whether the buffer is modified or not
  -- local modified = vim.bo.modified
  vim.cmd('highlight User1 ' .. pinnacle.highlight({
    fg = yellow,
    bg = bg,
    term = 'italic',
  }))
  --
  -- -- Update MatchParen to use italics (used for blurred statuslines).
  -- highlight = pinnacle.italicize('MatchParen')
  -- vim.cmd('highlight User2 ' .. highlight)

  -- StatusLine + bold (used for file names).
  -- local highlight = pinnacle.embolden('StatusLine')
  -- vim.cmd('highlight User3 ' .. highlight)
  vim.cmd('highlight User3 ' .. pinnacle.highlight({
    fg = '#eae8ff',
    bg = bg,
    term = 'bold',
  }))

  -- Inverted Error styling, for left-hand side "Powerline" triangle.
  -- local fg = pinnacle.extract_fg(status_highlight)
  -- local bg = pinnacle.extract_bg('StatusLine')
  vim.cmd('highlight User4 ' .. pinnacle.highlight({ bg = bg, fg = fg }))

  local blue = '#569fba'

  vim.cmd('highlight! User7 ' .. pinnacle.highlight({
    bg = blue,
    -- bg = '#7bb8c1',
    fg = pinnacle.extract_fg('Normal'),
    term = 'bold',
  }))
  -- if is_modified then
  --   vim.cmd('highlight! link User7 User8')
  -- else
  --   vim.cmd('highlight! link User7 User9')
  --   -- vim.cmd('highlight User7 ' .. pinnacle.highlight({
  --   --   bg = yellow,
  --   --   -- bg = '#7bb8c1',
  --   --   fg = pinnacle.extract_fg('Normal'),
  --   --   term = 'bold',
  --   -- }))
  -- end

  vim.cmd('highlight User8 ' .. pinnacle.highlight({
    bg = yellow,
    -- bg = '#7bb8c1',
    fg = pinnacle.extract_fg('Normal'),
    term = 'bold',
  }))

  vim.cmd('highlight User9 ' .. pinnacle.highlight({
    bg = red,
    -- bg = '#7bb8c1',
    fg = pinnacle.extract_fg('Normal'),
    term = 'bold',
  }))
  -- Right-hand side section.
  bg = pinnacle.extract_fg('Cursor')
  fg = pinnacle.extract_fg('User3')
  vim.cmd('highlight User5 ' .. pinnacle.highlight({
    bg = fg,
    fg = bg,
    term = 'bold',
  }))

  -- Right-hand side section + italic (used for %).
  vim.cmd('highlight User6 ' .. pinnacle.highlight({
    bg = fg,
    fg = bg,
    -- term = 'bold,italic',
    term = 'bold',
  }))

  -- vim.cmd('highlight clear StatusLineNC')
  -- vim.cmd('highlight! link StatusLineNC User1')
end

return statusline
