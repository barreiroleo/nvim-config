return {
    { "folke/trouble.nvim",
        dependencies = "kyazdani42/nvim-web-devicons",
    },
    {'SmiteshP/nvim-navic',
        config = require("plugins.ui.navic").config,
        lazy = true
    },
    { "norcalli/nvim-colorizer.lua",
        opts = { "md", "tex", "json", "css", "javascript", "html", "python", "lua" }
    },

    { import = "plugins.ui.blankline" },
    { import = "plugins.ui.bufferline" },
    { import = "plugins.ui.lualine" },
    { import = "plugins.ui.symbols_outline" },
}
