return {
    -- Engine
    { 'hrsh7th/nvim-cmp',
        -- Sources
        dependencies = {
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'hrsh7th/cmp-cmdline' },
            { 'rcarriga/cmp-dap' },
            { 'saadparwaiz1/cmp_luasnip',
                dependencies = { 'L3MON4D3/LuaSnip' }
            },
        },
        event = { "InsertEnter", "CmdlineEnter" },
        config = function ()
            require("plugins.completion.cmp")
            -- require("plugins.completion.native")
        end
    },

    -- Snippets engine + snippet sources
    { 'L3MON4D3/LuaSnip', lazy = true,
        dependencies = { 'rafamadriz/friendly-snippets' },
        config = function()
            require("plugins.completion.luasnip")
        end,
    }
}
