return {
    { "SidOfc/mkdx",
        enabled = false,
        ft = { "markdown" },
        config = function()
            -- vim.go: behaves like :let &g:{option-name}
            vim.g["mkdx#settings"] = {
                highlight = { enable = 1 },
                enter = { shift = 1 },
                links = { external = { enable = 1 } },
                toc = { text = "Table of Contents", update_on_write = 0 },
                fold = { enable = 1 },
                map = { prefix = "\\" },
            }
            -- Testing
            -- toc = {
            --     text = "Table of Contents",
            --     update_on_write = 0,
            --     details = { nesting_level = 0 },
            -- },
            -- fold = { enable = 1, components = { "toc", "fence" } },
            -- map = { prefix = "m", enable = 1 },
            -- restore_visual = 1,
            -- gf_on_steroids = 1,
            -- checkbox = { toggles = { " ", "x", "-" } },
            -- tokens = { strike = "~~", list = "*" },
        end,
    },

    { "iamcco/markdown-preview.nvim",
        ft = { "markdown" },
        build = function()
            vim.fn["mkdp#util#install"]()
        end,
    },

    { "AckslD/nvim-FeMaco.lua",
        ft = { "markdown" },
        config = function()
            require("femaco").setup()
        end,
    },
}
