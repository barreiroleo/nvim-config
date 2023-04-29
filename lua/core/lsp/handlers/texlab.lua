local def_opts = require("core.lsp.opts")

local M = {}

M.filetypes = { 'bib', 'plaintex', 'tex' }

M.settings = {
    texlab = {
        build = require('core.lsp.utils.texlab_cmd').build.latexmk,
        forwardSearch = require('core.lsp.utils.texlab_cmd').forwardSearch.sioyek,
        auxDirectory = '../build',
        chktex = {
            onOpenAndSave = true,
        },
        diagnosticsDelay = 300,
        formatterLineLength = 80, -- 0 disable
        bibtexFormatter = 'latexindent',
        latexFormatter = 'latexindent',
        latexindent = {
            modifyLineBreaks = true,
        },
    },
}

M.opts = {
    on_attach = function(client, bufnr)
        print("Loading texlab")
        def_opts.on_attach(client, bufnr)
    end,
    capabilities = def_opts.capabilities,
    filetypes = M.filetypes,
    settings = M.settings,
}

return M.opts
