local M = {}

---@return lsp.ClientCapabilities
function M.extend_capabilities()
    local def_capabilities = vim.lsp.protocol.make_client_capabilities()
    local ok, module = nil, nil

    ok, module = pcall(require, "blink.cmp")
    if ok then
        vim.notify("Extending blink.cmp capabilities")
        return module.get_lsp_capabilities(def_capabilities)
    end

    ok, module = pcall(require, "cmp_nvim_lsp")
    if ok then
        vim.notify("Extending nvim-cmp capabilities")
        return module.default_capabilities(def_capabilities)
    end

    vim.notify("Failed to extend client capabilities. Using defaults.", vim.log.levels.WARN)
    return def_capabilities
end

return M
