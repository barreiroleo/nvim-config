local default_opts = require("core.lsp.opts")

local default_handler = function(server)
    require('lspconfig')[server].setup(default_opts)
end

local get_custom_handlers = function()
    local handlers = {}
    local settings = vim.fn.stdpath('config') .. '/lua/core/lsp/handlers/'
    for file in vim.fs.dir(settings) do
         -- Check file extension and not init.lua
         local server = file:match("^(.+)%.lua$")
         if server and not server:match("^init$") then
            local opts = require("core.lsp.handlers." .. server)
            -- LOG({file, server, opts})
            handlers[server] = function()
                require('lspconfig')[server].setup(opts)
            end
        end
    end
    -- handlers["jdtls"] = function() end
    handlers["ltex"] = function() end
    return handlers
end

local handlers = vim.tbl_extend("error", { default_handler }, get_custom_handlers())

return handlers
