return {
    { 'folke/trouble.nvim', lazy = true,
        cmd = { 'Trouble', 'TodoTrouble' },
        dependencies = 'kyazdani42/nvim-web-devicons',
    },
    { 'norcalli/nvim-colorizer.lua', lazy = true,
        event = { 'BufNewFile', 'BufReadPre' },
        opts = { 'md', 'tex', 'json', 'css', 'javascript', 'html', 'python', 'lua' },
        cmd = {"ColorizerAttachToBuffer"}
    },
    { 'Bekaboo/dropbar.nvim' },
    { 'dstein64/nvim-scrollview', lazy = true,
        event = { 'BufNewFile', 'BufReadPre' }
    },
    { import = 'plugins.ui.blankline' },
    { import = 'plugins.ui.bufferline' },
    { import = 'plugins.ui.lualine' },
    { import = 'plugins.ui.outline' },
}
