local def_opts = require("core.lsp.opts")
local M = {}

M.filetypes = { 'bib', 'markdown', 'org', 'plaintex', 'rst', 'rnoweb', 'tex' } --gitcommit

M.settings = {
    settings = {
        checkFrequency = 'save',
        language = { "en-US", 'es-AR' },
        additionalRules = {
            enablePickyRules = true,
            motherTongue = 'es-AR',
        },
    }
}


M.opts = {
    autostart = true,
    on_attach = function(client, bufnr)
        vim.notify("Loading ltex from lspconfig")
        def_opts.on_attach(client, bufnr)
        require('ltex_extra').setup({
            init_check = true,
            load_langs = { 'es-AR', 'en-US' },
            log_level = "error",
            path = client.config.root_dir .. "/.ltex",
        })
    end,
    capabilities = def_opts.capabilities,
    filetypes = M.filetypes,
    settings = { ltex = M.settings },
    -- Look for existing `.ltex` directory first. If it doesn't exist,
    -- look for .git/.hg directories. If everything else fails, get absolute
    -- path to the file parent
    root_dir = function(file_path)
        return require("lspconfig").util.root_pattern('.ltex', '.hg', '.git')(file_path)
            or vim.fn.fnamemodify(file_path, ':p:h')
    end,
}

return M.opts
