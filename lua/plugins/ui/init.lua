return {
    { 'folke/trouble.nvim', lazy = true,
        branch = "dev",
        cmd = { 'Trouble', 'TodoTrouble' },
        dependencies = 'kyazdani42/nvim-web-devicons',
    },
    { 'norcalli/nvim-colorizer.lua', lazy = true,
        event = { 'BufNewFile', 'BufReadPre' },
        opts = { 'md', 'tex', 'json', 'css', 'javascript', 'html', 'python', 'lua' },
        cmd = {"ColorizerAttachToBuffer"}
    },
    { "RRethy/vim-illuminate", lazy = true,
        event = "VeryLazy"
    },
    { 'Bekaboo/dropbar.nvim' },
    { import = 'plugins.ui.blankline' },
    { import = 'plugins.ui.bufferline' },
    { import = 'plugins.ui.lualine' },
    { import = 'plugins.ui.outline' },
}
