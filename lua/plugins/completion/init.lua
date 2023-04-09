return {
    -- Engine
    { 'hrsh7th/nvim-cmp',
        -- Sources
        dependencies = {
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'hrsh7th/cmp-nvim-lua' },
            { 'hrsh7th/cmp-cmdline' },
            { 'rcarriga/cmp-dap' },
            { 'saadparwaiz1/cmp_luasnip',
                dependencies = { 'L3MON4D3/LuaSnip' }
            },

            -- Icons
            { "onsails/lspkind.nvim" },
        },
        event = "InsertEnter",
        config = function ()
            require("plugins.completion.cmp")
        end
    },

    -- Snippets engine + snippet sources
    { 'L3MON4D3/LuaSnip',
        dependencies = { 'rafamadriz/friendly-snippets' },
        event = "InsertEnter",
        config = function ()
            require("plugins.completion.luasnip")
        end
    }
}
