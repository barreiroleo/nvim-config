local def_opts = require("core.lsp.opts")
local M = {}

M.filetypes = { 'bib', 'markdown', 'org', 'plaintex', 'rst', 'rnoweb', 'tex' } --gitcommit

M.settings = {
    settings = {
        checkFrequency = 'save',
        language = 'es-AR',
        additionalRules = {
            enablePickyRules = true,
            motherTongue = 'es-AR',
        },
    },
}

M.extra_settings = {
    init_check = true,                 -- boolean : whether to load dictionaries on startup
    load_langs = { 'es-AR', 'en-US' }, -- table <string> : language for witch dictionaries will be loaded
    log_level = "error",               -- string : "none", "trace", "debug", "info", "warn", "error", "fatal"
    path = ".ltex",                    -- string : path to store dictionaries. Relative path uses current working directory
}

M.opts = {
    on_attach = function(client, bufnr)
        print("Loading ltex from lspconfig")
        def_opts.on_attach(client, bufnr)
        require('ltex_extra').setup(M.extra_settings)
    end,
    capabilities = def_opts.capabilities,
    filetypes = M.filetypes,
    settings = { ltex = M.settings },
}

return M.opts
