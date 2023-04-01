local def_opts = require("core.lsp.opts")

-- evinceSync.py pdffile lnum col %:p
-- cursorpos = getcurpos() = get[0, lnum, col, off, curswant]

-- Path to PDF: echo expand("%:h:h") .. "/build/" .. expand("%:t:r") .. ".pdf"
local M = {}

M.filetypes = { 'bib', 'plaintex', 'tex' }

M.settings = {
    texlab = {
        build = require('core.lsp.utils.texlab_cmd').build,
        forwardSearch = require('core.lsp.utils.texlab_cmd').forwardSearch,
        rootDirecotry = '.',
        auxDirectory = 'build',
        chktex = {
            onOpenAndSave = true,
            onEdit = true,
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

-- Evince forward search (inverse already configured with evince-synctex)
-- {
--   "texlab.forwardSearch.executable": "evince-synctex",
--   "texlab.forwardSearch.args": ["-f", "%l", "%p", "\"code -g %f:%l\""]
-- }

-- Zathura forwardSearch
-- {
--   "texlab.forwardSearch.executable": "zathura",
--   "texlab.forwardSearch.args": ["--synctex-forward", "%l:1:%f", "%p"]
-- }
-- Zathura inverseSearch
-- Add the following lines to your ~/.config/zathura/zathurarc file:
-- set synctex true
-- set synctex-editor-command "code -g %{input}:%{line}"
