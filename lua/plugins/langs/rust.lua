return {
    'mrcjkb/rustaceanvim',
    -- version = '^4',
    lazy = false,
    config = function()
        vim.g.rustaceanvim = {
            tools = { code_actions = { ui_select_fallback = true } }
        }
    end
}
