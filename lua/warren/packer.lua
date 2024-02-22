-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd.packadd('packer.nvim')

return require('packer').startup(function(use)
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'

	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.4',
		-- or                            , branch = '0.1.x',
		requires = { {'nvim-lua/plenary.nvim'} }
	}

	use {
        'rose-pine/neovim',
        as = 'rose-pine'
	}

    use { "ellisonleao/gruvbox.nvim" }

	use({
		'folke/trouble.nvim',
		config = function()
			require('trouble').setup {
				icons = false,
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			}
		end
	})

	use {
		'nvim-treesitter/nvim-treesitter',
		run = function()
			local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
			ts_update()
		end,}
		use('nvim-treesitter/playground')
		use('theprimeagen/harpoon')
		use('theprimeagen/refactoring.nvim')
		use('mbbill/undotree')
		use('tpope/vim-fugitive')
		use('nvim-treesitter/nvim-treesitter-context');

		use {
			'VonHeikemen/lsp-zero.nvim',
			branch = 'v3.x',
			requires = {
				--- Uncomment these if you want to manage LSP servers from neovim
				{'williamboman/mason.nvim'},
				{'williamboman/mason-lspconfig.nvim'},

				-- LSP Support
				{'neovim/nvim-lspconfig'},

				-- Autocompletion
				{'hrsh7th/nvim-cmp'},
				{'hrsh7th/cmp-nvim-lsp'},
				{'L3MON4D3/LuaSnip'},
			}
		}

        use('folke/zen-mode.nvim')
        use('github/copilot.vim')
        use('eandrju/cellular-automaton.nvim')
        use {
            'lervag/vimtex',
            config = function()
                -- This is necessary for VimTeX to load properly. The "indent" is optional.
                vim.cmd[[ filetype plugin indent on ]]

                -- This enables Vim's and neovim's syntax-related features.
                vim.cmd[[ syntax enable ]]

                -- Viewer options: Configure the viewer
                vim.g.vimtex_view_method = 'zathura'

                -- Or with a generic interface:
                vim.g.vimtex_view_general_viewer = 'zathura'
                vim.g.vimtex_view_general_options = '--unique file:@pdf#src:@line@tex'

                -- Compiler options
                vim.g.vimtex_compiler_method = 'pdflatex'

                -- Set localleader for VimTeX mappings
                vim.g.maplocalleader = " "
            end
        }

        use('google/maktaba')
        use('google/glaive')
        use('tpope/vim-commentary')
	end)

