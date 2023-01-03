local M = {}

function M.setup()
    -- Indicate first time installation
    local packer_bootstrap = false

    -- packer.nvim configuration
    local conf = {
        log = { level = "warn" },
        display = {
            open_fn = function()
                return require("packer.util").float({ border = "rounded" })
            end,
        },
    }

    -- Check if packer.nvim is installed
    -- Run PackerCompile if there are changes in this file
    local function packer_init()
        local fn = vim.fn
        local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
        if fn.empty(fn.glob(install_path)) > 0 then
            packer_bootstrap = fn.system({
                "git",
                "clone",
                "--depth",
                "1",
                "https://github.com/wbthomason/packer.nvim",
                install_path,
            })
            vim.cmd([[packadd packer.nvim]])
        end
        vim.cmd("autocmd BufWritePost plugins.lua source <afile> | PackerCompile")
    end

    -- Plugins
    local function plugins(use)
        use({ "wbthomason/packer.nvim" })
        
        use({
            "EdenEast/nightfox.nvim",
            config = "vim.cmd[[colorscheme nightfox]]",
        })

        -- Which-key for live documentation a la emacs which key
        use({
            "folke/which-key.nvim",
            config = "require('config/which-key-config')",
        })

        use {
            'VonHeikemen/lsp-zero.nvim',
            requires = {
                -- LSP Support
                {'neovim/nvim-lspconfig'},
                {'williamboman/mason.nvim'},
                {'williamboman/mason-lspconfig.nvim'},
                {'Hoffs/omnisharp-extended-lsp.nvim'},
                {'kosayoda/nvim-lightbulb'},
                {'simrat39/rust-tools.nvim'},
                {
                    'ray-x/lsp_signature.nvim',
                    config = function ()
                        require('lsp_signature').setup()
                    end
                },


                -- Autocompletion
                {'hrsh7th/nvim-cmp'},
                {'hrsh7th/cmp-buffer'},
                {'hrsh7th/cmp-path'},
                {'saadparwaiz1/cmp_luasnip'},
                {'hrsh7th/cmp-nvim-lsp'},
                {'hrsh7th/cmp-nvim-lua'},

                -- Snippets
                {'L3MON4D3/LuaSnip'},
                {'rafamadriz/friendly-snippets'},
            },
            config = function() require('config/lsp-zero-config') end
        }

        -- DAP
        use({
            "mfussenegger/nvim-dap",
            tag = "0.3.0"
        })

        use({
            "rcarriga/nvim-dap-ui",
            requires = { "mfussenegger/nvim-dap" },
            tag = "v2.6.0"
        })

        use({
            "jayp0521/mason-nvim-dap.nvim",
            config = function() require('config/dap-config') end,
        })

        -- Treesitter
        use({
            "nvim-treesitter/nvim-treesitter",
            run = ":TSUpdate",
            event = "BufWinEnter",
            config = "require('config/treesitter-config')",
        })

        use({"nvim-lua/plenary.nvim"})
        use({"antoinemadec/FixCursorHold.nvim"})
        use({"rouge8/neotest-rust"})

        use({
            "nvim-tree/nvim-tree.lua",
            requires = {
                "nvim-tree/nvim-web-devicons", -- optional, for file icons
            },
            config = "require('config/nvim-tree-config')",
        })

        if packer_bootstrap then
            require("packer").sync()
        end
    end

    packer_init()

    local packer = require("packer")
    packer.init(conf)
    packer.startup(plugins)
end

return M
