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
        lazy = true,
        branch = "dev",
        event = { 'CmdlineEnter' }
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
        opts = {
            options = {
                component_separators = '|',
                section_separators = { left = '', right = '' },
                disabled_filetypes = { 'neo-tree', 'TelescopePrompt', },
                always_divide_middle = false,
                globalstatus = false,
            }
        }
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
