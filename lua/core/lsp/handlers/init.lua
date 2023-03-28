local default_opts = {
    capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities()),
    on_attach = function(client, bufnr)
        require("core.lsp.keymaps").on_attach(client, bufnr)
        require("core.lsp.signature").on_attach(client, bufnr)
        if client.server_capabilities.documentSymbolProvider then
            require('nvim-navic').attach(client, bufnr)
        end
    end
}

local default_handler = function(server_name)
    require('lspconfig')[server_name].setup(default_opts)
end

local build_handler = function(server, opts)
    return { [server] = function()
        print("Loading " .. server)
        require('lspconfig')[server].setup(opts)
    end }
end

local get_custom_handlers = function()
    local handlers = {}
    local settings = vim.fn.stdpath('config') .. '/lua/core/lsp/handlers/'
    for file in vim.fs.dir(settings) do
        if not file:match("^init.lua$") then -- not load the init.lua
            local server = file:match("^(.+)%.lua$") -- filename without extension
            local ok, server_opts = pcall(require, "core.lsp.handlers." .. server)
            if ok then
                handlers = vim.tbl_extend("error", handlers, build_handler(server, server_opts) )
            end
        end
    end
    return handlers
end

local handlers = vim.tbl_extend("error", { default_handler }, get_custom_handlers())

return handlers
