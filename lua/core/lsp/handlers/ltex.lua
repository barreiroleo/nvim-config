local def_opts = require("core.lsp.opts")
local util_has = require("core.utils").has

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
    load_langs = { 'es-AR', 'en-US' },
    init_check = true,
    path = '.ltex',
    log_level = 'error',
}

M.opts = {
    on_attach = function(client, bufnr)
        print("Loading ltex")
        def_opts.on_attach(client, bufnr)
        if util_has("ltex_extra") then
            require('ltex_extra').setup(M.extra_settings)
        end
    end,
    capabilities = def_opts.capabilities,
    filetypes = M.filetypes,
    settings = { ltex = M.settings },
}

return M.opts
