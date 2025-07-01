return {
    { import = "plugins.langs.ltex_extra" },
    -- { import = "plugins.langs.markdown" },
    -- { import = "plugins.langs.plantuml" },

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
}
