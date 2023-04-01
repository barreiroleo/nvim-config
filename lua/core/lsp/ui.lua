-- Diagnostic message display. Error lens
vim.diagnostic.config {
    virtual_text = {
        severity = {
            min = vim.diagnostic.severity.WARN,
            max = vim.diagnostic.severity.ERROR
        },
        source = "if_many",
        prefix = '■'
    },
    float = { source = "if_many" },
    signs = true,
    underline = true,
    update_in_insert = true,
    severity_sort = true,
}

-- Diagnostic symbols in sign column (gutter)
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
