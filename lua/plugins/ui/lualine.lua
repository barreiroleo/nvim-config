local lint_component = {
    function()
        local linters = require("lint").get_running()
        if #linters == 0 then return "" end
        return "[" .. table.concat(linters, ", ") .. "]"
    end,
    -- icon = "󱉶 "
}

local lsp_component = {
    function()
        local attached_clients = vim.lsp.get_clients({ bufnr = 0 })
        -- Map server names from clients and filter null-ls
        local client_names = vim.iter(attached_clients)
            :map(function(client)
                local name = client.name:gsub("language.server", "ls")
                return name
            end)
            :filter(function(name) return name ~= "null-ls" end):totable()

        if #client_names == 0 then return "[No active lsp]" end
        return "[" .. table.concat(client_names, ",") .. "]"
    end,
    -- icon = ' ',
}

return {
    "nvim-lualine/lualine.nvim",
    event = { "BufNewFile", "BufReadPre", "InsertEnter" },
    config = function()
        local def_opts = require("lualine").get_config()
        def_opts.options = {
            component_separators = '|',
            section_separators = { left = '', right = '' },
            disabled_filetypes = { 'neo-tree', 'TelescopePrompt', },
            -- always_divide_middle = false,
            -- globalstatus = false,
        }
        def_opts.sections.lualine_x = { lint_component, lsp_component }

        require("lualine").setup(def_opts)
    end,
}
