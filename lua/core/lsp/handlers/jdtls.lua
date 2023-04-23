local def_opts = require("core.lsp.opts")

local M = {}

M.opts = {
    on_attach = function(client, bufnr)
        print("Loading jdtls from lspconfig")
        def_opts.on_attach(client, bufnr)
    end,
    capabilities = def_opts.capabilities,
}

return M.opts
