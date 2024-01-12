local M = {}

--- @class TSContext_hl
--- @field TC table
--- @field TC_Bottom table
--- @field TC_LineNumber table

--- @param TSContext_hl TSContext_hl
local function set_tscontext_hl(TSContext_hl)
    vim.api.nvim_set_hl(0, 'TreesitterContext', { bg = TSContext_hl["TC"].bg })
    vim.api.nvim_set_hl(0, 'TreesitterContextBottom', { bg = TSContext_hl["TC_Bottom"].bg })
    vim.api.nvim_set_hl(0, 'TreesitterContextLineNumber', {
        bg = TSContext_hl['TC_LineNumber'].bg, fg = TSContext_hl['TC_LineNumber'].fg, underline = false }
    )
end

--- @param highlights TSContext_hl
function M.setup(highlights)
    vim.api.nvim_create_autocmd({ "UIEnter" }, {
        group = vim.api.nvim_create_augroup("TreesitterContextUserColors", { clear = true }),
        callback = function() set_tscontext_hl(highlights) end
    })
end

return M
