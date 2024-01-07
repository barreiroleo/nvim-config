-- Export settings called from another modules
local M = {}

-- Diagnostic message display. Error lens
vim.diagnostic.config {
    virtual_text = {
        spacing = 4,
        severity = {
            min = vim.diagnostic.severity.WARN,
            max = vim.diagnostic.severity.ERROR
        },
        source = "if_many",
        prefix = '■' -- Could be '●', '▎', 'x', '⯀'
    },
    float = { source = "if_many" },
    signs = true,
    underline = true,
    update_in_insert = true,
    severity_sort = true,
}

-- Diagnostic symbols in sign column (gutter)
local signs = { Error = "", Warn = "", Hint = "", Info = "" }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Highlight symbol under cursor
-- https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization#highlight-symbol-under-cursor
M.highlight_symbol_cursor = function(client, bufnr)
    if client.server_capabilities.documentHighlightProvider then
        vim.cmd "hi! LspReferenceRead  cterm=bold ctermbg=red guibg=#45475A"
        vim.cmd "hi! LspReferenceText  cterm=bold ctermbg=red guibg=#45475A"
        vim.cmd "hi! LspReferenceWrite cterm=bold ctermbg=red guibg=#45475A"
        vim.api.nvim_create_augroup('lsp_document_highlight', {
            clear = false
        })
        vim.api.nvim_clear_autocmds({
            buffer = bufnr,
            group = 'lsp_document_highlight',
        })
        vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            group = 'lsp_document_highlight',
            buffer = bufnr,
            callback = vim.lsp.buf.document_highlight,
        })
        vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            group = 'lsp_document_highlight',
            buffer = bufnr,
            callback = vim.lsp.buf.clear_references,
        })
    end
end

-- Show line diagnostics automatically in hover window
-- https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization#show-line-diagnostics-automatically-in-hover-window
M.float_diagnostic = function(_, bufnr)
    -- Modify time to show hover diagnostic window
    vim.api.nvim_create_autocmd("CursorHold", {
        buffer = bufnr,
        callback = function()
            local opts = {
                focusable = false,
                close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
                border = 'rounded',
                source = 'always',
                prefix = ' ',
                scope = 'cursor',
            }
            vim.diagnostic.open_float(nil, opts)
        end
    })
end

return M
