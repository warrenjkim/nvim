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
  { src = "https://github.com/lewis6991/gitsigns.nvim",                 { load = true } },
})

require("config.diagnostics")
require("plugins.colors")
require("plugins.lsp")
require("plugins.telescope")
require("plugins.fugitive")
require("plugins.gitsigns")

vim.keymap.set('n', '<leader><leader>c', require("config.utils").clean_unused_plugins)
