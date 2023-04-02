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
            { 'saadparwaiz1/cmp_luasnip',
                dependencies = { 'L3MON4D3/LuaSnip' }
            },

            -- Icons
            { "onsails/lspkind.nvim" },
        },
        event = "VeryLazy",
        config = function ()
            require("plugins.completion.cmp")
        end
    },

    -- Snippets engine + snippet sources
    { 'L3MON4D3/LuaSnip',
        dependencies = { 'rafamadriz/friendly-snippets' },
        event = "VeryLazy",
        config = function ()
            require("plugins.completion.luasnip")
        end
    }
}
