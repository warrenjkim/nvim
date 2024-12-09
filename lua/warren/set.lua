-- no gui cursor
vim.opt.guicursor = ""

-- absolute line numbers
vim.opt.nu = true
-- relative line numbers
vim.opt.relativenumber = true

-- tabs
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

-- no wrapping
vim.opt.wrap = false

-- no swapfiles
vim.opt.swapfile = false
-- no backups
vim.opt.backup = false
-- persistent undo
vim.opt.undodir = os.getenv("HOME") .. "/.local/nvim/undodir"
-- lets you undo changes even after closing a file
vim.opt.undofile = true

-- no highlighting searches
vim.opt.hlsearch = false
-- incremental search
vim.opt.incsearch = true

-- true color
vim.opt.termguicolors = true

-- at least 8 lines above/below cursor
vim.opt.scrolloff = 8
-- force signs to always be visible
vim.opt.signcolumn = "yes"
-- valid filenames
vim.opt.isfname:append("@-@")
-- 50ms updates
vim.opt.updatetime = 50

local Warren_ColorCol = vim.api.nvim_create_augroup('Warren_ColorCol', { clear = true })

vim.api.nvim_create_autocmd('BufWinEnter', {
  group = Warren_ColorCol,
  pattern = '*',
  callback = function()
    if vim.bo.ft == 'gitcommit' then
      vim.opt.colorcolumn = "72"
    elseif vim.bo.ft == 'java' then
      vim.opt.colorcolumn = "100"
    else
      vim.opt.colorcolumn = "80"
    end
  end
})
