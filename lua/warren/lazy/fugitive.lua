return {
  'tpope/vim-fugitive',
  config = function()
    -- Set default flags for rebase operations
    vim.g.fugitive_rebase_args = '--committer-date-is-author-date --autostash'

    -- open fugitive
    vim.keymap.set('n', '<leader>gs', vim.cmd.Git)

    local Warren_Fugitive = vim.api.nvim_create_augroup('Warren_Fugitive', {})
    local autocmd = vim.api.nvim_create_autocmd

    -- Function to pull from main/master with fetch + rebase
    local function pull_from_main()
      vim.cmd('Git fetch origin')
      vim.fn.system('git rev-parse --verify origin/main')
      if vim.v.shell_error == 0 then
        vim.cmd('Git rebase origin/main --committer-date-is-author-date --autostash')
      else
        vim.cmd('Git rebase origin/master --committer-date-is-author-date --autostash')
      end
    end

    autocmd('BufWinEnter', {
      group = Warren_Fugitive,
      pattern = '*',
      callback = function()
        if vim.bo.ft ~= 'fugitive' then
          return
        end

        local bufnr = vim.api.nvim_get_current_buf()
        local opts = {
          buffer = bufnr,
          remap = false
        }

        -- Existing mappings
        vim.keymap.set("n", "P", function()
          local current_branch = vim.fn.system("git branch --show-current"):gsub("\n", "")
          vim.ui.input({
            prompt = string.format("Push to (default origin/%s): ", current_branch),
          }, function(input)
            -- Use input branch or fallback to current branch if empty
            local branch = (input and input ~= "") and input or current_branch
            -- Try dry-run with selected branch
            vim.fn.system(string.format("git push -u origin %s --dry-run", branch))
            if vim.v.shell_error ~= 0 then
              vim.ui.input({
                prompt = "Push failed. Force push? (y/N): ",
              }, function(force_input)
                if force_input and force_input:lower() == "y" then
                  vim.cmd(string.format("Git push --force-with-lease origin %s", branch))
                else
                  vim.cmd(string.format("Git push -u origin %s", branch))
                end
              end)
            else
              vim.cmd(string.format("Git push -u origin %s", branch))
            end
          end)
        end, { buffer = bufnr, remap = true })


        vim.keymap.set('n', '<leader>p', function()
          vim.cmd('Git pull --rebase')
        end, opts)

        -- ThePrimeagen's diff workflow
        -- Setup diffs for staging
        vim.keymap.set('n', 'gh', ':diffget //2<CR>', opts)
        vim.keymap.set('n', 'gl', ':diffget //3<CR>', opts)
        vim.keymap.set('n', 'gu', '<cmd>diffupdate<CR>', opts)
      end
    })

    -- ThePrimeagen's workflow for viewing changes
    vim.keymap.set('n', '<leader>gj', ':diffget //3<CR>')
    vim.keymap.set('n', '<leader>gf', ':diffget //2<CR>')
    vim.keymap.set('n', '<leader>gs', vim.cmd.Git)

    -- New mapping for pulling from main/master
    vim.keymap.set('n', '<leader>gm', pull_from_main)
  end
}
