local M = {}

local function set_hl(hl_colors)
    vim.api.nvim_set_hl(0, 'TreesitterContext', { bg = hl_colors["TC"].bg })

    vim.api.nvim_set_hl(0, 'TreesitterContextBottom', { bg = hl_colors["TC_Bottom"].bg })

    vim.api.nvim_set_hl(0, 'TreesitterContextLineNumber', {
        bg = hl_colors['TC_LineNumber'].bg, fg = hl_colors['TC_LineNumber'].fg, underline = false }
    )
end

function M.setup(hl_colors)
    vim.api.nvim_create_autocmd({ "UIEnter" }, {
        group = vim.api.nvim_create_augroup("TreesitterContextUserColors", { clear = true }),
        callback = function() set_hl(hl_colors) end
    })
end

return M
