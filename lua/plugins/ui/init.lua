return {
    {'SmiteshP/nvim-navic',
        config = require("plugins.ui.navic").config,
        lazy = true
    },
    { import = "plugins.ui.lualine" }
}
