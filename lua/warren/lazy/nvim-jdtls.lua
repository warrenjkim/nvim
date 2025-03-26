return {
  "mfussenegger/nvim-jdtls",
  ft = { "java" },
  config = function()
    local home = vim.fn.expand("~")
    local jdtls_home = "/opt/homebrew/Cellar/jdtls/1.44.0/libexec"
    local root_dir = require('jdtls.setup').find_root({ '.git', 'mvnw', 'gradlew' })
    local workspace = home .. "/work/workspace/platform"
    local proto_dir = home .. "/work/platform/shared/proto/"

    local cmd = {
      "java",
      "-Declipse.application=org.eclipse.jdt.ls.core.id1",
      "-Dosgi.bundles.defaultStartLevel=4",
      "-Declipse.product=org.eclipse.jdt.ls.core.product",
      "-Dlog.protocol=true",
      "-Dlog.level=ALL",
      "-Xmx1g",
      "--add-modules=ALL-SYSTEM",
      "-jar", jdtls_home .. "/plugins/org.eclipse.equinox.launcher_1.6.900.v20240613-2009.jar",
      "-configuration", jdtls_home .. "/config_mac_arm",
      "-data", workspace,
    }

    local config = {
      cmd = cmd,
      root_dir = root_dir,
      settings = {
        java = {
          project = {
            referencedLibraries = {
              proto_dir .. "/**"
            },
            resourceFilters = {
              "client", "server", "test", "!node_modules", "!**/.metadata", "!**/node_modules", "!**/*.log"
            }
          }
        }
      }
    }

    local function GoogleJavaFormat()
      local view = vim.fn.winsaveview()
      vim.cmd('%!google-java-format -')
      vim.fn.winrestview(view)
    end

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "java",
      callback = function()
        require("jdtls").start_or_attach(config)
        pcall(vim.api.nvim_buf_del_keymap, 0, "n", "<leader>f")
        vim.keymap.set("n", "<leader>f", GoogleJavaFormat, { buffer = true, desc = "Format with Google Java Format" })
      end,
    })
  end,
}
