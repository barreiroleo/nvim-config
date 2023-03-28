return {
    { "neovim/nvim-lspconfig",
        -- event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            { "williamboman/mason.nvim" },
            { "williamboman/mason-lspconfig.nvim" },
            { "WhoIsSethDaniel/mason-tool-installer.nvim" },
            { "jose-elias-alvarez/null-ls.nvim" },
            { "j-hui/fidget.nvim",
                opts = {
                    window = { blend = 0 },
                    sources = { ["null-ls"] = { ignore = true } },
                }
            },

            { "folke/neoconf.nvim", cmd = "Neoconf", config = true },
            { "folke/neodev.nvim", opts = { experimental = { pathStrict = true } } },
            { "hrsh7th/cmp-nvim-lsp",
                cond = function() return require("core.utils").has("nvim-cmp") end
            },
        },
        event = "VeryLazy",
        config = function() require "core.lsp" end,
    },
    { 'VonHeikemen/lsp-zero.nvim',
        branch = 'v1.x',
        dependencies = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},             -- Required
            {'williamboman/mason.nvim'},           -- Optional
            {'williamboman/mason-lspconfig.nvim'}, -- Optional

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},         -- Required
            {'hrsh7th/cmp-nvim-lsp'},     -- Required
            {'hrsh7th/cmp-buffer'},       -- Optional
            {'hrsh7th/cmp-path'},         -- Optional
            {'saadparwaiz1/cmp_luasnip'}, -- Optional
            {'hrsh7th/cmp-nvim-lua'},     -- Optional

            -- Snippets
            {'L3MON4D3/LuaSnip'},             -- Required
            {'rafamadriz/friendly-snippets'}, -- Optional
        },
        config = function()
            -- local lsp = require('lsp-zero').preset({
            --     name = 'minimal',
            --     set_lsp_keymaps = true,
            --     manage_nvim_cmp = true,
            --     suggest_lsp_servers = false,
            -- })
            -- -- (Optional) Configure lua language server for neovim
            -- lsp.nvim_workspace()
            -- lsp.setup()
        end
    }
}
