return {
    { "folke/trouble.nvim",
        event = { "BufNewFile", "BufReadPre" },
        dependencies = "kyazdani42/nvim-web-devicons",
    },
    {'SmiteshP/nvim-navic',
        opts = {
            highlight = true,
            separator = ' > ',
            depth_limit = 0,
            depth_limit_indicator = '..',
        },
        lazy = true
    },
    { "norcalli/nvim-colorizer.lua",
        event = { "BufNewFile", "BufReadPre" },
        opts = { "md", "tex", "json", "css", "javascript", "html", "python", "lua" }
    },

    { import = "plugins.ui.blankline" },
    { import = "plugins.ui.bufferline" },
    { import = "plugins.ui.lualine" },
    { import = "plugins.ui.symbols_outline" },
}
