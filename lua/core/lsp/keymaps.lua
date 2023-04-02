local map = require("core.utils").map

local on_attach = function(_, bufnr)
    map('n', 'gd',         ":lua vim.lsp.buf.definition()<CR>",        {buffer = bufnr})
    map('n', 'gD',         ":lua vim.lsp.buf.declaration()<CR>",       {buffer = bufnr})
    map('n', 'gi',         ":lua vim.lsp.buf.implementation()<CR>",    {buffer = bufnr})
    map('n', 'gr',         ":lua vim.lsp.buf.references()<CR>",        {buffer = bufnr})
    map('n', 'gt',         ":lua vim.lsp.buf.type_definition()<CR>",   {buffer = bufnr})
    map('n', 'K',          ":lua vim.lsp.buf.hover()<CR>",             {buffer = bufnr})
    map('n', '<C-k>',      ":lua vim.lsp.buf.signature_help()<CR>",    {buffer = bufnr})
    map('n', '<leader>rn', ":lua vim.lsp.buf.rename()<CR>",            {buffer = bufnr})
    map('n', '<leader>ca', ":lua vim.lsp.buf.code_action()<CR>",       {buffer = bufnr})
    -- map('n', '<F6>', function() require("core.functions.FormatNull").FormatNull() end,  {buffer = bufnr})
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<F6>',      ":lua vim.lsp.buf.format()<CR>",      opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'v', '<F6>',      ":'<,'>:lua vim.lsp.buf.range_formatting()<CR>",  opts)

    map('n', 'gpd', require("core.lsp.utils.peek").PeekDefinition, { buffer = bufnr })
    map('n', 'gpD', require("core.lsp.utils.peek").PeekDeclaration, { buffer = bufnr })
    map('n', 'gpi', require("core.lsp.utils.peek").PeekImplementation, { buffer = bufnr })

    map("n", "gsd", ":vsplit<CR>gd" , {buffer = bufnr})
    map("n", "gsD", ":vsplit<CR>gD" , {buffer = bufnr})
    map("n", "gsi", ":vsplit<CR>gi" , {buffer = bufnr})
end

return on_attach
