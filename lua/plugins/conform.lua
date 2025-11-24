require("conform").setup({
  formatters_by_ft = {
    c     = { "clang-format" },
    cpp   = { "clang-format" },
    proto = { "clang-format" },
    bzl   = { "buildifier" },
    bazel = { "buildifier" },
  },
  formatters = {
    ["clang-format"] = {
      prepend_args = { "--style=file", "--fallback-style=Google" },
    },
  },
})

vim.keymap.set("n", "<leader>f",
  function()
    require("conform").format({ async = true, lsp_fallback = true, })
  end, { desc = "format" })
