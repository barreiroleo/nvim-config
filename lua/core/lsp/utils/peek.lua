-- Open the target of a textDocument/definition and textDocument/declaration
-- request in a floating window

local M = {}

local preview_location_callback = function(_, result)
    if result == nil or vim.tbl_isempty(result) then
        return nil
    end
    vim.lsp.util.preview_location(result[1])
end

M.PeekDefinition = function()
    local params = vim.lsp.util.make_position_params()
    return vim.lsp.buf_request(0, 'textDocument/definition', params, preview_location_callback)
end

M.PeekDeclaration = function()
    local params = vim.lsp.util.make_position_params()
    return vim.lsp.buf_request(0, 'textDocument/declaration', params, preview_location_callback)
end

M.PeekImplementation = function()
    local params = vim.lsp.util.make_position_params()
    return vim.lsp.buf_request(0, 'textDocument/declaration', params, preview_location_callback)
end

M.create_commands = function(bufnr)
    vim.api.nvim_buf_create_user_command(bufnr, "PeekDefinition", M.PeekDefinition, {})
    vim.api.nvim_buf_create_user_command(bufnr, "PeekDeclaration", M.PeekDeclaration, {})
    vim.api.nvim_buf_create_user_command(bufnr, "PeekImplementation", M.PeekImplementation, {})
end

return M
