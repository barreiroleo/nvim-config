local map = require("core.utils").map

local on_attach = function(_, bufnr)
    map('n', 'gd',         vim.lsp.buf.definition,           { buffer = bufnr })
    map('n', 'gD',         vim.lsp.buf.declaration,          { buffer = bufnr })
    map('n', 'gi',         vim.lsp.buf.implementation,       { buffer = bufnr })
    map('n', 'gr',         vim.lsp.buf.references,           { buffer = bufnr })
    map('n', 'gt',         vim.lsp.buf.type_definition,      { buffer = bufnr })
    map('n', 'K',          vim.lsp.buf.hover,                { buffer = bufnr })
    map('n', '<C-k>',      vim.lsp.buf.signature_help,       { buffer = bufnr })
    map('n', '<leader>rn', vim.lsp.buf.rename,               { buffer = bufnr })
    map({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, { buffer = bufnr })

    map('n', 'gpd', require("core.lsp.utils.peek").PeekDefinition, { buffer = bufnr })
    map('n', 'gpD', require("core.lsp.utils.peek").PeekDeclaration, { buffer = bufnr })
    map('n', 'gpi', require("core.lsp.utils.peek").PeekImplementation, { buffer = bufnr })

    map("n", "gsd", ":vsplit<CR>gd" , {buffer = bufnr})
    map("n", "gsD", ":vsplit<CR>gD" , {buffer = bufnr})
    map("n", "gsi", ":vsplit<CR>gi" , {buffer = bufnr})
end

return on_attach
