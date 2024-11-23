return {
    { import = 'plugins.ui.bufferline' },
    { import = 'plugins.ui.lualine' },
    { import = 'plugins.ui.outline' },
    {
        'folke/trouble.nvim',
        cmd = "Trouble",
        opts = {},
    },
    {
        'norcalli/nvim-colorizer.lua',
        event = { 'BufNewFile', 'BufReadPre' },
        opts = { 'md', 'tex', 'json', 'css', 'javascript', 'html', 'python', 'lua' },
        cmd = { "ColorizerAttachToBuffer" }
    },
    -- {
    --     'lukas-reineke/indent-blankline.nvim',
    --     main = 'ibl',
    --     event = { 'BufNewFile', 'BufReadPre' },
    --     opts = {
    --         indent = { char = "┆" },
    --     },
    -- },
}
