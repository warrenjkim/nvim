return {
  'tpope/vim-fugitive',
  config = function()
    -- Function to pull from specified branch
    local function pull_from_branch(branch)
      vim.cmd("Git fetch origin --all")
      vim.fn.system("git rev-parse --verify origin/" .. branch)
      if vim.v.shell_error == 0 then
        vim.cmd("Git rebase origin/" .. branch .. " --committer-date-is-author-date --autostash")
      else
        print("Branch origin/" .. branch .. " does not exist")
      end
    end

    -- open fugitive
    vim.keymap.set('n', '<leader>gs', vim.cmd.Git)
    local Warren_Fugitive = vim.api.nvim_create_augroup('Warren_Fugitive', {})
    local autocmd = vim.api.nvim_create_autocmd

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
          remap = true
        }

        -- ThePrimeagen's diff workflow
        -- Setup diffs for staging
        vim.keymap.set('n', 'gh', ':diffget //2<CR>', opts)    -- Get from target branch (left)
        vim.keymap.set('n', 'gl', ':diffget //3<CR>', opts)    -- Get from merge branch (right)
        vim.keymap.set('n', 'gu', '<cmd>diffupdate<CR>', opts) -- Update diff view

        -- Custom push with confirmation and force push option
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
        end, opts)

        -- Pull with rebase and conflict handling
        vim.keymap.set("n", "<leader>p", function()
          local branch = vim.fn.system("git branch --show-current"):gsub("\n", "")
          pull_from_branch(branch)

          -- Check if rebase is in progress
          local is_rebasing = vim.fn.system("git rev-parse --quiet --verify REBASE_HEAD"):gsub("\n", "") ~= ""

          if is_rebasing then
            vim.ui.input({
              prompt = "Rebase conflict detected. Options:\n" ..
                  "1: Abort rebase and stash changes\n" ..
                  "2: Open status to resolve conflicts\n" ..
                  "Choice (1/2): ",
            }, function(input)
              if input == "1" then
                -- Save any changes that were auto-stashed
                vim.cmd("Git stash")
                -- Abort the rebase
                vim.cmd("Git rebase --abort")
              elseif input == "2" then
                -- Open Git status to start resolving conflicts
                vim.cmd("Git")
              end
            end)
          end
        end, opts)
      end,
    })

    -- Global mappings for ThePrimeagen's workflow
    vim.keymap.set('n', '<leader>gj', ':diffget //3<CR>') -- Get changes from right side
    vim.keymap.set('n', '<leader>gf', ':diffget //2<CR>') -- Get changes from left side
    vim.keymap.set('n', '<leader>gk', function() vim.cmd('Gdiffsplit') end)
    vim.keymap.set('n', '<leader>gl', function() vim.cmd.Git('log') end)
    vim.keymap.set('n', '<leader>gm', function() pull_from_branch("main") end)
  end
}
