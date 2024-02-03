local M = {}

-- Extends completion capabilities if has cpm_nvim_lsp
local get_capabilities = function()
    return require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
end

-- Export opts
M.capabilities = get_capabilities()

M.on_attach = function(client, bufnr)
    -- print("Default on_attach")
    require("core.lsp.keymaps")(client, bufnr)
    require("core.lsp.utils.peek").create_commands(client, bufnr)
end

return M
