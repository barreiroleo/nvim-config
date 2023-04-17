local def_opts = require("core.lsp.opts")

local M = {}

M.settings = {
    Lua = {
        diagnostics = {
            -- Recognize `vim` global
            globals = { 'vim', "LOG", "P" },
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
    on_attach = function(client, bufnr)
        print("Loading lua_ls")
        def_opts.on_attach(client, bufnr)
    end,
    capabilities = def_opts.capabilities,
    settings = M.settings,
}

return M.opts
