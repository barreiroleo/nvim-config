local M = {}

local function set_hl()
    local colors = require("plugins.themes.colorhub").get_Context()

    vim.api.nvim_set_hl(0, 'TreesitterContext', { bg = colors['TC'].bg })

    vim.api.nvim_set_hl(0, 'TreesitterContextBottom', { bg = colors["TC_Bottom"].bg})

    vim.api.nvim_set_hl(0, 'TreesitterContextLineNumber', {
        bg = colors['TC_LineNumber'].bg, fg = colors['TC_LineNumber'].fg, underline = false }
    )
end

function M.setup()
    vim.api.nvim_create_autocmd({ "UIEnter" }, {
        group = vim.api.nvim_create_augroup("TreesitterContextUserColors", { clear = true }),
        callback = set_hl
    })
end

return M
