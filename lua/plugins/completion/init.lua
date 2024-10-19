return {
    -- Engine
    { 'iguanacucumber/magazine.nvim',
        enabled = true,
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
        enabled = true,
        dependencies = { 'rafamadriz/friendly-snippets' },
        config = function()
            require("plugins.completion.luasnip")
        end,
    },

    {
        'saghen/blink.cmp', lazy = false, enabled = false,
        dependencies = 'rafamadriz/friendly-snippets',
        build = 'cargo build --release',

        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            trigger = { signature_help = { enabled = true } },
            windows = {
                autocomplete = {
                    border = 'rounded',
                    draw = 'reversed',
                },
                documentation = { border = 'rounded', auto_show = true, },
                signature_help = { border = 'rounded' },
            },
            highlight = { use_nvim_cmp_as_default = true, },
            nerd_font_variant = 'mono',
        }
    }
}
