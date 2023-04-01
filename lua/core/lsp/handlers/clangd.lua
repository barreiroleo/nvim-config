local def_opts = require("core.lsp.opts")
local M = {}

M.cmd = {
    'clangd',
    '--all-scopes-completion',
    '--suggest-missing-includes',
    '--background-index',
    -- '--pch-storage=disk',
    '--cross-file-rename',
    -- '--log=info',
    -- '--completion-style=detailed',
    '--enable-config', -- clangd 11+ supports reading from .clangd configuration file
    -- '--clang-tidy',
    '--offset-encoding=utf-16', --temporary fix for null-ls
    -- "--clang-tidy-checks=-*,llvm-*,clang-analyzer-*,modernize-*,-modernize-use-trailing-return-type",
    -- "--fallback-style=Google",
    -- "--header-insertion=never",
    -- "--query-driver=<list-of-white-listed-complers>"
 }

M.opts = {
    on_attach = function(client, bufnr)
        print("Loading clangd")
        def_opts.on_attach(client, bufnr)
        P('require("configs.dap.gdb")')
    end,
    capabilities = def_opts.capabilities,
    cmd = M.cmd,
}

return M.opts
