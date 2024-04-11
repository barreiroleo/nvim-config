local on_attach = function(_, bufnr)
    vim.keymap.set('n', 'gd',         vim.lsp.buf.definition,           { buffer = bufnr })
    vim.keymap.set('n', 'gD',         vim.lsp.buf.declaration,          { buffer = bufnr })
    vim.keymap.set('n', 'gi',         vim.lsp.buf.implementation,       { buffer = bufnr })
    vim.keymap.set('n', 'gr',         vim.lsp.buf.references,           { buffer = bufnr })
    vim.keymap.set('n', 'gt',         vim.lsp.buf.type_definition,      { buffer = bufnr })
    vim.keymap.set('n', '<C-k>',      vim.lsp.buf.signature_help,       { buffer = bufnr })
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename,               { buffer = bufnr })
    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, { buffer = bufnr })


    vim.keymap.set('n', 'gpd', require("core.lsp.utils.peek").PeekDefinition, { buffer = bufnr })
    vim.keymap.set('n', 'gpD', require("core.lsp.utils.peek").PeekDeclaration, { buffer = bufnr })
    vim.keymap.set('n', 'gpi', require("core.lsp.utils.peek").PeekImplementation, { buffer = bufnr })
end

return on_attach
