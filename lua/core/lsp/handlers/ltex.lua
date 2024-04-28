local def_opts = require("core.lsp.opts")

return {
    autostart = true,
    on_attach = function(client, bufnr)
        vim.notify("Loading ltex from lspconfig")
        def_opts.on_attach(client, bufnr)
    end,
    capabilities = def_opts.capabilities,
    filetypes = { 'bib', 'markdown', 'org', 'plaintex', 'rst', 'rnoweb', 'tex' },
    settings = {
        ltex = {
            checkFrequency = 'save',
            language = { "en-US", 'es-AR' },
            additionalRules = {
                enablePickyRules = true,
                motherTongue = 'es-AR',
            },
        },
    },
}
