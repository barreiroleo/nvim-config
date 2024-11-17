return {
    "nvim-lualine/lualine.nvim",
    event = { "BufNewFile", "BufReadPre", "InsertEnter" },
    config = function()
        local lsp_component = {
            function()
                local attached_clients = vim.lsp.get_clients({ bufnr = 0 })
                if #attached_clients == 0 then
                    return "No Active Lsp"
                end
                local it = vim.iter(attached_clients)
                it:map(function(client)
                    local name = client.name:gsub("language.server", "ls")
                    return name
                end)
                local names = it:filter(function(name) return name ~= "null-ls" end):totable()
                if #names == 0 then names = { "No LSP" } end
                return "[" .. table.concat(names, ",") .. "]"
            end,
            -- icon = ' ',
        }

        local def_opts = require("lualine").get_config()
        def_opts.options = {
            component_separators = '|',
            section_separators = { left = '', right = '' },
            disabled_filetypes = { 'neo-tree', 'TelescopePrompt', },
            -- always_divide_middle = false,
            -- globalstatus = false,
        }
        def_opts.sections.lualine_x = lsp_component

        require("lualine").setup(def_opts)
    end,
}
