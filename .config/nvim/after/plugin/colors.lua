require('nightfox').setup({
  options = {
    -- Compiled file's destination location
    compile_path = vim.fn.stdpath("cache") .. "/nightfox",
    compile_file_suffix = "_compiled", -- Compiled file suffix
    transparent = false,     -- Disable setting background
    terminal_colors = true,  -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
    dim_inactive = false,    -- Non focused panes set to alternative background
    module_default = true,   -- Default enable value for modules
    styles = {               -- Style to be applied to different syntax groups
      comments = "italic",     -- Value is any valid attr-list value `:help attr-list`
      conditionals = "NONE",
      constants = "NONE",
      functions = "NONE",
      keywords = "bold",
      numbers = "NONE",
      operators = "NONE",
      strings = "NONE",
      types = "italic,bold",
      variables = "NONE",
    },
    modules = {             -- List of various plugins and additional options
      -- ...
    },
  },
  palettes = {},
  specs = {},
  groups = {
    all = {
      TelescopePromptTitle = { fg = "palette.pink" },
      TelescopePromptPrefix = { fg = "palette.pink" },
      TelescopeBorder = { fg = "palette.magenta", bg = "palette.bg1" },
      TelescopeMatching = { fg = "palette.red" },
      LineNrAbove = { fg = "palette.fg3" },
      LineNrBelow = { fg = "palette.fg3" },
      LineNr = { fg = "palette.yellow" },
    }
  },
})
