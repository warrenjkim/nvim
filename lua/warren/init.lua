require("warren.set")
require("warren.remap")
require("warren.lazy_init")
require("warren.statusline")

local augroup = vim.api.nvim_create_augroup
local WarrenGroup = augroup("Warren", {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})

function R(name)
    require("plenary.reload").reload_module(name)
end

-- go templates
vim.filetype.add({
    extension = {
        templ = 'templ',
    }
})
vim.cmd([[au BufRead,BufNewFile *.tmpl set filetype=html]])

-- highlights selected text when yanked
autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

autocmd({"BufWritePre"}, {
    group = WarrenGroup,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

-- lsp
autocmd('LspAttach', {
    group = WarrenGroup,
    callback = function(e)
        local opts = { buffer = e.buf }
        -- go to definition (splits window)
        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
        -- floating description window
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)

        -- find symbol in project
        vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
        -- find references of a symbol
        vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
        -- rename a symbol
        vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
        -- signature help in insert mode
        vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)

        -- open diagnostics
        vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
        -- diagnostics scroll forward
        vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
        -- diagnostics scroll backward
        vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
        -- diagnostics code action
        vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
    end
})

-- Set up border for LSP diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = "single"
})

-- Set up border for LSP hover
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = "single"
})

-- Set up border for LSP signature help
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  -- Specify border style: single, double, rounded, solid, shadow
  border = "single"
})


vim.o.background = "dark"
vim.cmd([[colorscheme gruvbox]])
