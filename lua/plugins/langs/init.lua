return {
    { import = "plugins.langs.ltex_extra" },
    -- { import = "plugins.langs.markdown" },
    -- { import = "plugins.langs.plantuml" },

    {
        'brianhuster/live-preview.nvim',
        cmd = "LivePreview",
        opts = {},
    },

    {
        'mrcjkb/rustaceanvim',
        ft = { "rust" },
        -- version = '^4',
        config = function()
            vim.g.rustaceanvim = {
                tools = { code_actions = { ui_select_fallback = true } }
            }
        end
    },

    {
        'MeanderingProgrammer/render-markdown.nvim',
        ft= { "markdown" },
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim' },
        ---@module 'render-markdown'
        ---@type render.md.UserConfig
        opts = {
            -- FIX: broken on nightly?
            -- completions = { lsp = { enabled = true } },
        },
    }
}
