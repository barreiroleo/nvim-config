return{
    { "nvim-treesitter/nvim-treesitter",
        event = { "BufNewFile", "BufReadPre" },
        build = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = false })
            ts_update()
        end,
        dependencies = {
            { "nvim-treesitter/nvim-treesitter-textobjects" },
            { "nvim-treesitter/nvim-treesitter-refactor" },
            { "p00f/nvim-ts-rainbow" },
            { "nvim-treesitter/nvim-treesitter-context",
                opts = { mode = 'topline' }
            },
            { "windwp/nvim-ts-autotag", config = true }
        },
        config = function()
            require("nvim-treesitter.configs").setup(require("plugins.treesitter.opts"))
        end
    },
}
