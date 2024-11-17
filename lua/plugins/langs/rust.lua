return {
    'mrcjkb/rustaceanvim',
    ft = { "rust" },
    -- version = '^4',
    config = function()
        vim.g.rustaceanvim = {
            tools = { code_actions = { ui_select_fallback = true } }
        }
    end
}
