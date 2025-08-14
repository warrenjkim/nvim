require("telescope").setup({})
require("telescope").load_extension("git_file_history")

local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>pf", builtin.find_files, {})
vim.keymap.set("n", "<leader>pF", builtin.live_grep, {})
vim.keymap.set("n", "<leader>pb", builtin.buffers, {})

vim.keymap.set("n", "<C-p>", function()
  local ok, _ = pcall(builtin.git_files)
  if not ok then
    vim.notify("Not a git repository", vim.log.levels.WARN)
  end
end, {})
vim.keymap.set("n", "<leader>pg", function()
  local ok, _ = pcall(require("telescope").extensions.git_file_history.git_file_history)
  if not ok then
    vim.notify("Not a git repository", vim.log.levels.WARN)
  end
end, {})

vim.keymap.set("n", "<leader>pws", function()
  local word = vim.fn.expand("<cword>")
  builtin.grep_string({ search = word })
end)
