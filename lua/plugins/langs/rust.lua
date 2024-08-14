return {
    'mrcjkb/rustaceanvim',
    version = '^4', -- Recommended
    lazy = false,   -- This plugin is already lazy
    after = function ()
        vim.g.rustaceanvim.tools.code_actions.ui_select_fallback = true
    end
}
