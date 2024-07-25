return {
  'folke/zen-mode.nvim',
  config = function()
    local zen_mode = require('zen-mode')
    vim.keymap.set('n', '<leader>zz', function()
      zen_mode.setup({
        window = {
          width = 90,
          options = {}
        }
    })
      zen_mode.toggle()
      vim.wo.wrap = false
      vim.wo.number = true
      vim.wo.rnu = true
    end)

    vim.keymap.set('n', '<leader>zZ', function()
            zen_mode.setup({
                window = {
                    width = 80,
                    options = { }
                },
            })
            zen_mode.toggle()
            vim.wo.wrap = false
            vim.wo.number = false
            vim.wo.rnu = false
            vim.opt.colorcolumn = '0'
        end)
  end
}
