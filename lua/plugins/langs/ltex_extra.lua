local ltex_filetypes = { 'bib', 'markdown', 'org', 'plaintex', 'rst', 'rnoweb', 'tex' }

local ltex_opts = {
    settings = {
        checkFrequency = 'save',
        language = { "en-US", 'es-AR' },
        additionalRules = {
            enablePickyRules = true,
            motherTongue = 'es-AR',
        },
    }
}

return {
    "barreiroleo/ltex_extra.nvim",
    ft = { "markdown", "tex" },
    opts = {
        init_check = true,                 -- boolean : whether to load dictionaries on startup
        load_langs = { 'es-AR', 'en-US' }, -- table <string> : language for witch dictionaries will be loaded
        log_level = "info",                -- string : "none", "trace", "debug", "info", "warn", "error", "fatal"
        path = ".ltex",                    -- string : path to store dictionaries. Relative path uses current working directory
        -- path = vim.fn.expand("~") .. "/.local/share/ltex",
        server_start = false,              -- boolean : Enable the call to ltex. Usefull for migration and test
        -- server_opts = {
        --     on_attach = function(client, bufnr)
        --         print("Loading ltex from ltex_extra")
        --         require("core.lsp.opts").on_attach(client, bufnr)
        --     end,
        --     capabilities = require("core.lsp.opts").capabilities,
        --     filetypes = ltex_filetypes,
        --     settings = {
        --         ltex = ltex_opts
        --     }
        -- },
    },
}
