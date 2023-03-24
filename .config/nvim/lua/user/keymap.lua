-- my shit
--
local opts = { noremap = true }
local function nnoremap(key, callback)
  vim.keymap.set('n', key, callback, { noremap = true })
end

--———————————————————
-- START: Undotree
--———————————————————

nnoremap('<leader>u', vim.cmd.UndotreeToggle)

--—————————————————
-- END: Undotree
--—————————————————
--———————————————————
-- START: Telescope
--———————————————————
local telescope = require('telescope.builtin')

nnoremap('<leader>f', telescope.find_files)
nnoremap('<leader>ev', function()
  telescope.find_files({
    search_dirs = {'~/.config/nvim'},
    prompt_title = "Neovim Configs",
  })
end)
nnoremap('<leader>ea', function()
  telescope.find_files({
    search_dirs = {'~/src/dotfiles/files'},
    prompt_title = "Dotfiles",
    hidden = true,
  })
end)
nnoremap('<leader>he', function()
  telescope.help_tags({
    previewer = false,
  })
end)

nnoremap('<leader>bf', function()
  telescope.buffers()
end)
--—————————————————
-- END: Telescope
--—————————————————

--——————————————————
-- START: Easypick
--——————————————————
nnoremap('<leader>p', vim.cmd.Easypick)
-- nnoremap('<leader>gf', function()
--   telescope.git_files({
--     show_untracked = true,
--     git_command = "git status --porcelain | sed s/^...//"
--   })
-- end)
nnoremap('<leader>gf', ':Easypick Git Changed Files<cr>')
--————————————————
-- END: Easypick
--————————————————

-- NOTE: Create a file ~/.zshenv and export variable ZDOTDIR=/path/to/dir.
vim.keymap.set('n', '<leader>ez', ":e ~/.zshrc<cr>", opts)
vim.keymap.set('n', '<leader>r', ':lua require("telescope").extensions.live_grep_args.live_grep_args()<CR>');

-- swap ; and : for better ergonomics
vim.keymap.set('n', ';', ':', opts)
vim.keymap.set('n', ':', ';', opts)

-- vim.keymap.set('n', '-', ':NvimTreeFindFile!<CR>', opts)
vim.keymap.set('n', '<leader>t', ':TroubleToggle<CR>', opts)
vim.keymap.set('n', '<leader>\\', '<C-w>v', opts)
vim.keymap.set('n', '<leader>-', '<C-w>s', opts)
vim.keymap.set('n', '<leader>w', ':write<CR>', opts)
vim.keymap.set('n', '<leader>q', ':Bdelete<CR> ', opts)
-- vim.keymap.set('n', '<leader>ps', ':PackerSync<CR>', opts)
-- select entire file
vim.keymap.set('n', '<leader>vef', 'ggVG', opts)

vim.keymap.set('n', '<leader>cx', ':!chmod +x %<CR>', opts)

-- create new file where current buffer is
vim.keymap.set('n', '<leader>cf', ':e <C-R>=expand("%:p:h") . "/" <CR>', opts)

-- unset last search pattern register by hitting return
vim.keymap.set('n', '<cr>', ':noh<CR><CR>:<backspace>', opts)

-- vim-tmux-navigator
vim.keymap.set('n', '<c-h>', ':TmuxNavigateLeft<cr>', opts)
vim.keymap.set('n', '<c-j>', ':TmuxNavigateDown<cr>', opts)
vim.keymap.set('n', '<c-k>', ':TmuxNavigateUp<cr>', opts)
vim.keymap.set('n', '<c-l>', ':TmuxNavigateRight<cr>', opts)
-- vim.keymap.set('n', '<c-->', ':BufferLineCyclePrev<cr>', opts)
-- vim.keymap.set('n', '<c-=>', ':BufferLineCycleNext<cr>', opts)
-- easymotion
vim.keymap.set('n', 's', '<Plug>(easymotion-s)')
vim.g.EasyMotion_keys = 'abcdefghijklmnopqrstuvwxyz'

-- move vertically by visual line
vim.keymap.set('n', 'j', 'gj', opts)
vim.keymap.set('n', 'k', 'gk', opts)

-- RIP esc key
vim.keymap.set('i', 'jj', '<ESC>')

-- from primeagen
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- vim.keymap.set("n", "J", "mzJ`z") -- keep cursor inplace while J

-- keep cursor in middle of page
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- keep search term in the middle
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- keep paste buffer text and send replaced text to void
-- vim.keymap.set("x", "<leader>p", "\"_dP")

-- keep copy buffer separate between vim and system
-- vim.keymap.set("v", "<leader>y", "\"+y")
-- vim.keymap.set("n", "<leader>y", "\"+y")
-- vim.keymap.set("n", "<leader>Y", "\"+Y")

-- send deleted text to void. Doesn't work?
vim.keymap.set("n", "<leader>d", "\"_d")
vim.keymap.set("v", "<leader>d", "\"_d")

-- prevent going to worst place in the universe
vim.keymap.set("n", "Q", "<nop>")

-- does not work
-- vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

-- vim.keymap.set("n", "<leader>f", function()
--     vim.lsp.buf.format()
-- en{ previewer = false { previewer = false })

-- lsp quick fix shit
-- vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
-- vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })
