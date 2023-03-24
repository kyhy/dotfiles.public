-- local ensure_packer = function()
--   local fn = vim.fn
--   local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
--   if fn.empty(fn.glob(install_path)) > 0 then
--     fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
--     vim.cmd [[packadd packer.nvim]]
--     return true
--   end
--   return false
-- end
--
-- local packer_bootstrap = ensure_packer()
--
-- vim.cmd([[
--   augroup packer_user_config
--     autocmd!
--     autocmd BufWritePost plugins.lua source <afile> | PackerCompile
--   augroup end
-- ]])

vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.1',
    -- or                            , branch = '0.1.x',
    requires = { {'nvim-lua/plenary.nvim', 'nvim-telescope/telescope-live-grep-args.nvim' } },
    config = function()
      require("telescope").load_extension("live_grep_args")
    end
  }

  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use {'axkirillov/easypick.nvim', requires = 'nvim-telescope/telescope.nvim'}
  -- colors
  use({
    'rose-pine/neovim',
    as = 'rose-pine',
  })
  use 'sainnhe/gruvbox-material'
  use 'B4mbus/oxocarbon-lua.nvim'
  use 'savq/melange-nvim'
  use 'rebelot/kanagawa.nvim'
  use 'EdenEast/nightfox.nvim'
  use 'aktersnurra/no-clown-fiesta.nvim'
  use({
    'catppuccin/vim',
    -- as = 'catppuccin',
  })

  -- UI
  use 'nvim-tree/nvim-web-devicons'
  use "lukas-reineke/indent-blankline.nvim"
  use { 'akinsho/bufferline.nvim', tag = "v3.*", requires = 'nvim-tree/nvim-web-devicons' }
  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
  }
  use {'kevinhwang91/nvim-ufo', requires = 'kevinhwang91/promise-async'}

  use{ '~/src/dim-background.nvim' }

  -- Usability
  use {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end
  }
  use 'tpope/vim-surround'       -- surround object
  use 'tpope/vim-eunuch'         -- rename or move files
  use 'easymotion/vim-easymotion' -- easy motion
  use 'christoomey/vim-tmux-navigator'
  use 'echasnovski/mini.comment'
  use 'wincent/pinnacle'         -- highlight objects
  use {
    "folke/trouble.nvim",
    requires = "nvim-tree/nvim-web-devicons",
    -- config = function()
    --   require("trouble").setup {
    --     -- your configuration comes here
    --     -- or leave it empty to use the default settings
    --     -- refer to the configuration section below
    --   }
    -- end
  }
  use {
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }

  use {
    "windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {} end
  }
  use 'preservim/nerdtree'

  use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
  use('nvim-treesitter/playground')
  use('theprimeagen/harpoon')
  use('mbbill/undotree')
  use('tpope/vim-fugitive')

  -- LSP
  -- use("https://git.sr.ht/~whynothugo/lsp_lines.nvim")
  use("~/src/lsp_lines.nvim")
  use "folke/neodev.nvim"
  use {
	  'VonHeikemen/lsp-zero.nvim',
	  branch = 'v1.x',
	  requires = {
		  -- LSP Support
		  {'neovim/nvim-lspconfig'},             -- Required
		  {'williamboman/mason.nvim'},           -- Optional
		  {'williamboman/mason-lspconfig.nvim'}, -- Optional

		  -- Autocompletion
		  {'hrsh7th/nvim-cmp'},         -- Required
		  {'hrsh7th/cmp-nvim-lsp'},     -- Required
		  {'hrsh7th/cmp-buffer'},       -- Optional
		  {'hrsh7th/cmp-path'},         -- Optional
		  {'saadparwaiz1/cmp_luasnip'}, -- Optional
		  {'hrsh7th/cmp-nvim-lua'},     -- Optional

		  -- Snippets
		  {'L3MON4D3/LuaSnip'},             -- Required
		  {'rafamadriz/friendly-snippets'}, -- Optional
	  }
  }
  use {
    "SmiteshP/nvim-navic",
    requires = "neovim/nvim-lspconfig"
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  -- if packer_bootstrap then
  --   require('packer').sync()
  -- end

  -- vim.cmd.colorscheme("gruvbox-material")
  -- vim.cmd.background("dark")
  vim.cmd.colorscheme("duskfox")
  -- vim.cmd.colorscheme("no-clown-fiesta")
  -- vim.cmd.colorscheme("oxocarbon-lua")
  -- vim.cmd.colorscheme("catppuccin_mocha")
  -- vim.cmd.colorscheme("catppuccin_macchiato")
  -- vim.cmd.colorscheme("catppuccin_frappe")
  -- vim.cmd.colorscheme("catppuccin_latte")
end)


