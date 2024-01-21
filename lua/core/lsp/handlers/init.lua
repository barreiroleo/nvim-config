local default_opts = require("core.lsp.opts")

local EXCLUDED_FILES = { "init", "ltex", "clangd_flags" }

local default_handler = function(server)
    require('lspconfig')[server].setup(default_opts)
end

---@param file string
---@return boolean
local function is_excluded(file)
    for i, x in pairs(EXCLUDED_FILES) do
        if file == x then
            return true
        end
    end
    return false
end

local function get_custom_handlers()
    local handlers = {}
    local settings = vim.fn.stdpath('config') .. '/lua/core/lsp/handlers/'
    for file in vim.fs.dir(settings) do
        -- Check file extension and not init.lua
        local server = file:match '^(.+)%.lua$'
        if is_excluded(server) then
            goto continue
        end
        local opts = require('core.lsp.handlers.' .. server)
        -- LOG({file, server, opts})
        handlers[server] = function()
            require('lspconfig')[server].setup(opts)
        end
        ::continue::
    end
    return handlers
end

local handlers = vim.tbl_extend("error", { default_handler }, get_custom_handlers())

return handlers
