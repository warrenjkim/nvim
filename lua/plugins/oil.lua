require("oil").setup({
  default_file_explorer = true,
  delete_to_trash = false,
  view_options = {
    show_hidden = true,
  },
})

vim.keymap.set("n", "<leader>pv", "<CMD>Oil<CR>", { desc = "Open parent directory in Oil" })
vim.keymap.set("n", "<leader>pe", "<CMD>Oil --float<CR>", { desc = "Oil file explorer (float)" })
