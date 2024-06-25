return {
  "mhartington/formatter.nvim",
  config = function()
    require('formatter').setup({
      filetype = {
        html = {
          -- Use prettier for html files (and by extension, .tmpl files with HTML content)
          function()
            return {
              exe = "prettier",
              args = { "--stdin-filepath", vim.api.nvim_buf_get_name(0), "--parser", "html", "c", "go" },
              stdin = true
            }
          end
        },
        java = {
          -- Use google-java-format for Java files
          function()
            return {
              exe = "google-java-format",
              args = { "--replace", vim.api.nvim_buf_get_name(0) },
              stdin = false
            }
          end
        }
        -- You can add configurations for other filetypes here
      }
    })
  end
}
