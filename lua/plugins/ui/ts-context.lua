local get_colors = require("plugins.themes.colorhub").get_Context

local M = {}

function M.set_tscontext_hl()
    local colors = get_colors()

    vim.api.nvim_set_hl(0, 'TreesitterContext', { bg = colors['TC'].bg })

    vim.api.nvim_set_hl(0, 'TreesitterContextBottom', { bg = colors["TC_Bottom"].bg})

    vim.api.nvim_set_hl(0, 'TreesitterContextLineNumber', {
        bg = colors['TC_LineNumber'].bg, fg = colors['TC_LineNumber'].fg, underline = false }
    )
end

return M
