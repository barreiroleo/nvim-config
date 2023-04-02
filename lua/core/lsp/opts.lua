local util_has = require("core.utils").has
local M = {}

-- Extends completion capabilities if has cpm_nvim_lsp
local get_capabilities = function()
    return require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
end

-- Show signature hint as you type
local on_attach_signature = function(_, bufnr)
    if util_has("lsp_signature") then
        require "lsp_signature".on_attach({
            -- Floating windows config
            handler_opts = {
                -- double, rounded, single, shadow, none
                border = "none"
            },
            auto_close_after = 5,
            transparency = 10,
            toggle_key = '<C-e>'
        }, bufnr)
    end
end

-- Show code context in statusline/winbar
local on_attach_navic = function(client, bufnr)
    if util_has("nvim-navic") and client.server_capabilities.documentSymbolProvider then
        require('nvim-navic').attach(client, bufnr)
    end
end

-- Export opts
M.capabilities = get_capabilities()

M.on_attach = function(client, bufnr)
    print("Default on_attach")
    require("core.lsp.keymaps")(client, bufnr)
    require("core.lsp.ui").float_diagnostic(client, bufnr)
    require("core.lsp.ui").highlight_symbol_cursor(client, bufnr)
    require("core.lsp.utils.peek").create_commands(client, bufnr)

    -- Plugs attach
    on_attach_signature(client, bufnr)
    on_attach_navic(client, bufnr)
end

return M
