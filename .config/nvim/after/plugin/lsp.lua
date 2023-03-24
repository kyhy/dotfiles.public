require("neodev").setup({
  -- add any options here, or leave empty to use the default settings
})-- Learn the keybindings, see :help lsp-zero-keybindings

-- Learn to configure LSP servers, see :help lsp-zero-api-showcase
local lsp = require('lsp-zero')
lsp.preset('recommended')

lsp.ensure_installed({
	'tsserver',
	'eslint',
	'rust_analyzer'
})

-- Fix Undefined global 'vim'
lsp.configure('sumneko_lua', {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            }
        }
    }
})
local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
  ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
  ['<C-y>'] = cmp.mapping.confirm({ select = true }),
  ["<C-Space>"] = cmp.mapping.complete(),
})

lsp.setup_nvim_cmp({
	mapping = cmp_mappings
})

lsp.on_attach(function(client, bufnr)
	local opts = {buffer = bufnr, remap = false}

	vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
	vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
	vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
	vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
	vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
	vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, opts)
	vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

-- (Optional) Configure lua language server for neovim
lsp.nvim_workspace()

lsp.setup()

-- vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false, scope="cursor"})]]
-- vim.cmd [[autocmd! CursorHold,CursorHoldI * lua function() end]]

vim.diagnostic.config({
  -- virtual_lines = { only_current_line = true },
  virtual_lines = false,
  -- virtual_text = false,
  -- virtual_lines = true,
})

local lsp_lines = require("lsp_lines")
lsp_lines.setup()
--
vim.keymap.set("n", "<C-S>", function()
  local current = vim.diagnostic.config().virtual_lines

  if current == false then
    vim.diagnostic.config({ virtual_lines = { only_current_line = true } })
    -- vim.diagnostic.config({ virtual_lines = true })
  else 
    vim.diagnostic.config({ virtual_lines = false })
  end
end, { desc = "Toggle lsp_lines" })
vim.keymap.set("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", { noremap = true })
vim.keymap.set('n', '<C-N>', '<cmd>lua vim.diagnostic.goto_next({ float = false })<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-P>', '<cmd>lua vim.diagnostic.goto_prev({ float = false })<CR>', { noremap = true, silent = true })

