require("oil").setup({
  default_file_explorer = true,
  delete_to_trash = false,
  view_options = {
    show_hidden = true,
    is_hidden_file = function(name, _)
      local hide = {
        -- "^bazel%-",
        -- "^MODULE%.bazel%.lock$",
        -- "^compile_commands%.json$",
        -- "^%.bazel",
        -- "^%.clang%-format$",
        -- "^%.gitignore$",
        -- "^%.cache$",
        -- "^external$",
      }
      for _, pat in ipairs(hide) do
        if name:match(pat) then return true end
      end
      return false
    end,
  },
  keymaps = {
    ["<C-p>"] = false,
    ["<leader>h"] = "actions.toggle_hidden",
  },
})

vim.keymap.set("n", "<leader>pv", "<CMD>Oil<CR>", { desc = "Open parent directory in Oil" })
vim.keymap.set("n", "<leader>pe", "<CMD>Oil --float<CR>", { desc = "Oil file explorer (float)" })
