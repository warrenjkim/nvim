if vim.lsp.inlay_hint then
  vim.keymap.set("n", "<leader>ih", function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
  end, { buffer = 0, desc = "toggle inlay hints" })
else
  vim.keymap.set("n", "<leader>ih", function()
    vim.notify("lsp does not have inlay hints", vim.log.levels.WARN)
  end, { buffer = 0, desc = "toggle inlay hints" })
end

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("Lsp", { clear = true }),
  callback = function(args)
    vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, { buffer = args.buf, desc = "format" })

    -- goto
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = args.buf, desc = "go to definition" })
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = args.buf, desc = "go to declaration" })
    vim.keymap.set("n", "gr", require('telescope.builtin').lsp_references,
      { buffer = args.buf, desc = "show references" })
    vim.keymap.set("n", "gi", require('telescope.builtin').lsp_implementations,
      { buffer = args.buf, desc = "go to implementation(s)" })
    vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, { buffer = args.buf, desc = "go to type definition" })
    if vim.lsp.get_client_by_id(args.data.client_id).server_capabilities.callHierarchyProvider then
      vim.keymap.set("n", "gci", require("telescope.builtin").lsp_incoming_calls,
        { buffer = args.buf, desc = "incoming calls" })
      vim.keymap.set("n", "gco", require("telescope.builtin").lsp_outgoing_calls,
        { buffer = args.buf, desc = "outgoing calls" })
    end

    -- help
    vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = args.buf, desc = "hover documentation" })
    vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, { buffer = args.buf, desc = "signature help" })

    -- symbols
    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { buffer = args.buf, desc = "code action" })
    vim.keymap.set("n", "<leader>bs", require('telescope.builtin').lsp_document_symbols,
      { buffer = args.buf, desc = "document symbols" })
    vim.keymap.set("n", "<leader>ws", require('telescope.builtin').lsp_dynamic_workspace_symbols,
      { buffer = args.buf, desc = "workspace symbols" })
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = args.buf, desc = "rename symbol" })
  end
})

require("lspconfig").lua_ls.setup({
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      telemetry = { enable = false },
    },
  }
})

require("lspconfig").clangd.setup({})
