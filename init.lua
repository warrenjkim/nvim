vim.g.mapleader = " "
require("config.options")
require("config.remap")
require("config.ui")

vim.pack.add({
  -- colors
  { src = "https://github.com/ellisonleao/gruvbox.nvim",      { load = true } },

  -- lsp
  { src = "https://github.com/neovim/nvim-lspconfig",         { load = true } },

  -- telescope
  { src = "https://github.com/nvim-lua/plenary.nvim",         { load = true } },
  { src = "https://github.com/nvim-telescope/telescope.nvim", { load = true } },

})

require("plugins.colors")
require("plugins.lsp")

-- Use it
vim.keymap.set('n', '<leader>pc', require("config.utils").clean_unused_plugins)
