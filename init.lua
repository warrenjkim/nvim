vim.g.mapleader = " "
require("config.options")
require("config.remap")
require("config.ui")

vim.pack.add({
  -- colors
  { src = "https://github.com/ellisonleao/gruvbox.nvim",                { load = true } },

  -- lsp
  { src = "https://github.com/neovim/nvim-lspconfig",                   { load = true } },

  -- telescope
  { src = "https://github.com/nvim-lua/plenary.nvim",                   { load = true } },
  { src = "https://github.com/nvim-telescope/telescope.nvim",           { load = true } },
  { src = "https://github.com/isak102/telescope-git-file-history.nvim", { load = true } },

  -- git
  { src = "https://github.com/tpope/vim-fugitive",                      { load = true } },
  { src = "https://github.com/tpope/vim-rhubarb",                       { load = true } },
  { src = "https://github.com/lewis6991/gitsigns.nvim",                 { load = true } },

  -- lualine
  { src = "https://github.com/nvim-lualine/lualine.nvim",               { load = true } },

  -- conform
  { src = "https://github.com/stevearc/conform.nvim",                   { load = true } },

  -- fidget
  { src = "https://github.com/j-hui/fidget.nvim",                       { load = true } },

  -- oil
  { src = "https://github.com/stevearc/oil.nvim",                       { load = true } },

  -- whitespace
  { src = "https://github.com/ntpeters/vim-better-whitespace",          { load = true } }
})

require("plugins.colors")
require("plugins.lsp")
require("plugins.telescope")
require("plugins.fugitive")
require("plugins.gitsigns")
require("plugins.lualine")
require("plugins.conform")
require("plugins.fidget")
require("plugins.oil")

require("config.cmp")
require("config.diagnostics")

vim.keymap.set('n', '<leader><leader>c', require("config.utils").clean_unused_plugins)
