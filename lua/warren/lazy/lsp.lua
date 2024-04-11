return {
    'neovim/nvim-lspconfig',
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "j-hui/fidget.nvim",
    },

    config = function()
        local cmp = require('cmp')
        local cmp_lsp = require('cmp_nvim_lsp')
        local capabilities = vim.tbl_deep_extend(
            'force',
            { },
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities()
        )

        require('fidget').setup({
            progress = {
                display = { done_icon = ' ', }, -- Icon shown when all LSP progress tasks are complete
            },

            notification = {
                window = {
                    normal_hl = 'Comment',      -- Base highlight group in the notification window
                    winblend = 0,               -- Background color opacity in the notification window
                    border = 'single',          -- Border around the notification window
                },
            },
        })
        require('mason').setup()
        require('mason-lspconfig').setup({
            ensure_installed = {
                'clangd',
                'jdtls',
                'lua_ls',
            },
            handlers = {
                function(server_name)
                    require('lspconfig')[server_name].setup({
                        capabilities = capabilities
                    })
                end,
            }
        })

        local cmp_select = { behavior = cmp.SelectBehavior.Insert }

        cmp.setup({
            snippet = {
                expand = function(args)
                require('luasnip').lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                ['<Tab>'] = cmp.mapping.confirm({ select = true }),
                ['<C-Space>'] = cmp.mapping.complete(),
            }),

            sources = cmp.config.sources(
                {
                    { name = 'nvim_lsp'   },  -- default lsp
                    { name = 'luasnip'    },  -- snippets
                },
                {
                    { name = 'buffer' },  -- other buffers
                }
            )
        })

        vim.diagnostic.config({
            signs = true,
            float = {
                focusable = false,
                style = 'minimal',
                border = 'single',
                source = 'always',
                header = '',
                prefix = '',
            },
        })
    end
}
