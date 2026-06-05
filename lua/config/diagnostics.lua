vim.diagnostic.config({ virtual_text = true })
vim.keymap.set("n", "<leader>dt", function()
  vim.diagnostic.config({ virtual_text = not vim.diagnostic.config().virtual_text })
end, { desc = "toggle diagnostic virtual text" })

vim.keymap.set("n", "[d", function()
  vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "previous diagnostic" })

vim.keymap.set("n", "]d", function()
  vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "next diagnostic" })

vim.keymap.set("n", "<leader>bd", function()
  require('telescope.builtin').diagnostics({ bufnr = 0 })
end, { desc = "buffer diagnostics" })

vim.keymap.set("n", "<leader>wd", function()
  require('telescope.builtin').diagnostics()
end, { desc = "workspace diagnostics" })

