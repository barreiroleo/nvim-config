return {
    { "folke/trouble.nvim",
        event = { "BufNewFile", "BufReadPre" },
        dependencies = "kyazdani42/nvim-web-devicons",
    },
    { "norcalli/nvim-colorizer.lua",
        event = { "BufNewFile", "BufReadPre" },
        opts = { "md", "tex", "json", "css", "javascript", "html", "python", "lua" }
    },
    { "Bekaboo/dropbar.nvim" },

    { import = "plugins.ui.blankline" },
    { import = "plugins.ui.bufferline" },
    { import = "plugins.ui.lualine" },
    { import = "plugins.ui.symbols_outline" },
}
