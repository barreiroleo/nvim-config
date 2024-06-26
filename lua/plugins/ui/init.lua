local function OpenOutline()
    local outline = require("outline")

    if not outline.is_open() then
        outline.open()
    else
        outline.focus_toggle()
    end
end

return {
    { import = 'plugins.ui.bufferline' },
    { 'Bekaboo/dropbar.nvim' },
    {
        'folke/trouble.nvim',
        cmd = "Trouble",
        opts = {},
    },
    {
        'norcalli/nvim-colorizer.lua',
        lazy = true,
        event = { 'BufNewFile', 'BufReadPre' },
        opts = { 'md', 'tex', 'json', 'css', 'javascript', 'html', 'python', 'lua' },
        cmd = { "ColorizerAttachToBuffer" }
    },
    {
        "RRethy/vim-illuminate",
        lazy = true,
        event = "VeryLazy"
    },
    {
        'lukas-reineke/indent-blankline.nvim',
        main = 'ibl',
        event = { 'BufNewFile', 'BufReadPre' },
        opts = {
            indent = { char = "┆" },
        },
    },
    {
        "nvim-lualine/lualine.nvim",
        enabled = true,
        event = "VeryLazy",
        dependencies = {
            { "kyazdani42/nvim-web-devicons" }
        },
        config = function()
            local def_opts = require("lualine").get_config()
            local options = {
                component_separators = '|',
                section_separators = { left = '', right = '' },
                disabled_filetypes = { 'neo-tree', 'TelescopePrompt', },
                always_divide_middle = false,
                globalstatus = false,
            }
            local lsp_component = {
                function()
                    local msg = 'No Active Lsp'
                    local clients = vim.lsp.get_clients({ bufnr = 0 })
                    if next(clients) == nil then
                        return msg
                    end
                    local buf_ft = vim.api.nvim_get_option_value("filetype", { buf = 0 })
                    for _, client in ipairs(clients) do
                        local filetypes = client.config.filetypes
                        if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                            return client.name
                        end
                    end
                    return msg
                end,
                icon = ' ',
            }
            def_opts.options = options
            table.insert(def_opts.sections.lualine_x, 1, lsp_component)
            table.insert(def_opts.sections.lualine_x, 1, "require'lsp-status'.status()")
            require("lualine").setup(def_opts)
        end,
    },
    {
        'hedyhli/outline.nvim',
        lazy = true,
        cmd = 'Outline',
        keys = { { '<leader>cs', OpenOutline, desc = 'Symbols LSP navigation' } },
        config = function()
            require('outline').setup {
                preview_window = { live = true },
            }
        end,
    }
}
