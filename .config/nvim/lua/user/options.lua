vim.g.mapleader = " "

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

local set = vim.opt

-- — undotree —
-- ———————————
set.undodir = os.getenv("HOME") .. "/.vim/undodir"
set.undofile = true

-- — General —
-- ———————————
set.termguicolors = true            -- true color enabled for nvim
set.autoread = true                 -- set to auto read when a file is changed from the outside
set.backspace = 'eol,start,indent'  -- backspace acts as it 'should' act
set.clipboard = 'unnamed'           -- yank to clipboard
set.ffs = 'unix,dos,mac'            -- use Unix as the standard file type
set.hidden = true                   -- switch buffers without saving
set.lazyredraw = true               -- don't redraw while executing macros
set.timeoutlen = 500                -- wait 500 ms to complete mapped sequence
set.wildignore:append('*/tmp/*,*.so,*.swp,*.zip,*.class')
set.mouse = 'a'
vim.opt.updatetime = 50

set.modelines = 0                   -- turn off modeline
set.modeline = false                -- turn off modeline

-- no annoying soundon errors
set.errorbells = false
set.visualbell = false

-- — text, tab, indent —
-- —————————————————————
set.autoindent = true        -- maintain indent of current line
set.expandtab = true         -- use spaces instead of tabs
set.smarttab = true          -- be smart when using tabs
set.smartindent = true
set.cindent = true
-- set indentexpr=

-- 1 tab == 2 spaces
set.shiftwidth = 2
set.tabstop = 2
set.softtabstop = 2

-- Linebreak on 500 characters
set.linebreak = true
set.textwidth = 500

set.whichwrap:append('<,>,h,l')       -- move to previous/next line
set.wrap = true                       -- wrap lines

-- — search —
-- ——————————
set.ignorecase = true   -- ignore case when searching
set.incsearch = true    -- make search act like search in modern browsers
set.hlsearch = true     -- highlight matched search pattern
set.magic = true        -- use regex during search
set.smartcase = true    -- when searching try to be smart about cases
set.gdefault = true     -- in :s operation /g is added automatically

-- — UI —
-- ——————
set.cmdheight = 1                -- height of the command bar
-- set.cursorline = true            -- highlight current line
-- set.foldcolumn = true         -- add a bit extra margin to the left
set.number = true                -- show line numbers in gutter
set.relativenumber = true        -- show relative line numbers
set.ruler = true                 -- always show current position

set.listchars = 'nbsp:⦸,eol:¬,tab:»-,trail:·,extends:»,precedes:«' -- possible solution for indent guides
set.list = true                  -- show problematic characters
set.conceallevel = 0             -- show double quotes in json

-- — pane splits to the right and below —
-- ——————————————————————————————————————
set.splitbelow = true
set.splitright = true

-- — folding —
-- ———————————
-- NOTE: checkout ~/.config/nvim/after/plugin/ufo.lua

-- — files, backups and undo —
-- ———————————————————————————
set.backup = false
set.wb = false
set.swapfile = false


