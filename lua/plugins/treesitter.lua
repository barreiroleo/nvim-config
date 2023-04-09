local treesitter_opts = {
    unpack(require("plugins.treesitter.ts-basics")),

    require("plugins.treesitter.ts-parsers"),

    require("plugins.treesitter.ts-textobjects"),
    require("plugins.treesitter.ts-refactor"),
    require("plugins.treesitter.ts-playground"),
}

return{
    { "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
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
            require("nvim-treesitter.configs").setup(treesitter_opts)
        end
    },
}
