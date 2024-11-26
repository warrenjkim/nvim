return {
  "nvim-telescope/telescope.nvim",

  dependencies = {
    "nvim-lua/plenary.nvim",
    "BurntSushi/ripgrep",
    "sharkdp/fd",
    "isak102/telescope-git-file-history.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "tpope/vim-fugitive"
    }
  },

  config = function()
    require("telescope").setup({})
    require("telescope").load_extension("git_file_history")

    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
    vim.keymap.set('n', '<C-p>', builtin.git_files, {})
    vim.keymap.set('n', '<leader>pF', builtin.live_grep, {})
    vim.keymap.set('n', '<leader>pb', builtin.buffers, {})
    vim.keymap.set('n', '<leader>pg',

      function()
        require("telescope").extensions.git_file_history.git_file_history()
      end,
      {}
    )

    vim.keymap.set('n', '<leader>pws', function()
      local word = vim.fn.expand("<cword>")
      builtin.grep_string({ search = word })
    end)

    vim.keymap.set('n', '<leader>pWs', function()
      local word = vim.fn.expand("<cWORD>")
      builtin.grep_string({ search = word })
    end)

    vim.keymap.set('n', '<leader>ps', function()
      builtin.grep_string({ search = vim.fn.input("Grep > ") })
    end)

    vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})
  end
}
