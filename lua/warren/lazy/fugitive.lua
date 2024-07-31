return {
  'tpope/vim-fugitive',

  config = function()
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
          remap = false
        }

        vim.keymap.set('n', '<leader>P', function() vim.cmd.Git('push') end, opts)

        -- rebase always
        vim.keymap.set('n', '<leader>p', function()
          vim.cmd.Git({'pull',  '--rebase'})
        end, opts)
      end,
    })

    vim.keymap.set('n', '<leader>gk', function() vim.cmd('Gdiffsplit') end)
    vim.keymap.set('n', '<leader>gl', function() vim.cmd.Git('log') end)
    vim.keymap.set('n', '<leader>gB', function() vim.cmd.Git('checkout') end)
  end
}
