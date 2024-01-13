return {
    'rebelot/kanagawa.nvim', lazy = false, priority = 1000, enabled = true,
    config = function()
        require('kanagawa').setup {
            compile = true,        -- enable compiling the colorscheme
            transparent = false,   -- do not set background color
            terminalColors = true, -- define vim.g.terminal_color_{0,17}
            background = {
                dark = 'dragon',
            },
        }

        vim.cmd 'colorscheme kanagawa'
    end,
}
