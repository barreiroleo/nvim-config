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

-- Open the target of a textDocument/definition and textDocument/declaration
-- request in a floating window
local preview_location_callback = function(_, result)
    if result == nil or vim.tbl_isempty(result) then
        return nil
    end
    vim.lsp.util.preview_location(result[1])
end
function PeekDefinition()
    local params = vim.lsp.util.make_position_params()
    return vim.lsp.buf_request(0, 'textDocument/definition', params, preview_location_callback)
end
function PeekDeclaration()
    local params = vim.lsp.util.make_position_params()
    return vim.lsp.buf_request(0, 'textDocument/declaration', params, preview_location_callback)
end

-- Export opts
M.capabilities = get_capabilities()

M.on_attach = function(client, bufnr)
    print("Default on_attach")
    require("core.lsp.keymaps")(client, bufnr)
    require("core.lsp.ui").float_diagnostic(client, bufnr)
    require("core.lsp.ui").highlight_symbol_cursor(client, bufnr)

    -- Plugs attach
    on_attach_signature(client, bufnr)
    on_attach_navic(client, bufnr)
end

return M
