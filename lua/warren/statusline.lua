function StatusLine()
    local filetype = vim.bo.filetype
    local filename = vim.fn.expand('%:t')
    local cursorpos = "Row " .. vim.fn.line('.') .. ", Col " .. vim .fn.col('.')
    return filetype .. ' | ' .. filename .. ' | ' .. cursorpos
end
