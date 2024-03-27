return {
    'stevearc/conform.nvim',
    event = { 'VeryLazy' },
    cmd = { 'ConformInfo' },
    keys = {
        { 'gqf', function() require('conform').format { async = true, lsp_fallback = true } end,
            desc = 'Conform: Format buffer',
        },
    },

    opts = {
        log_level = vim.log.levels.DEBUG,
        formatters_by_ft = {
            lua = { 'stylua' },
        },
        -- format_on_save = { timeout_ms = 100, lsp_fallback = true },
        formatters = {
            -- Customize formatters
        },
    },

    init = function()
        vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
}
