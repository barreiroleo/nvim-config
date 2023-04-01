local def_opts = require("core.lsp.opts")

local M = {}

M.root_files = {
    'main.py',
    'pyproject.toml',
    'setup.py',
    'setup.cfg',
    'requirements.txt',
    'Pipfile',
    'pyrightconfig.json',
}

M.opts = {
    on_attach = function(client, bufnr)
        print("Loading pyright")
        def_opts.on_attach(client, bufnr)
    end,
    capabilities = def_opts.capabilities,
    root_dir = require("lspconfig").util.root_pattern(unpack(M.root_files)),
}

return M.opts
