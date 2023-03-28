local M = {}

M.settings = {
    Lua = {
        diagnostics = {
            -- Recognize `vim` global
            globals = { 'vim' },
        },
        workspace = {
            -- Make the server aware of Neovim runtime files.
            library = {
                    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                    [vim.fn.stdpath("config") .. "/lua"] = true,
            },
            checkThirdParty = false, -- Disable luv questions
        },
        completion = {
            keywordSnippet = 'Replace',
            callSnippet = 'Replace',
        },
        telemetry = {
            enable = false,
        },
    },
}

M.opts = {
    settings = M.settings,
}


return M.opts
