return {
    { "windwp/nvim-autopairs",
        opts = { check_ts = true }
    },
    { "mbbill/undotree" },
    { "junegunn/vim-easy-align",
        keys = {
            { "ga", "<Plug>(EasyAlign)", mode = "n", desc = "EasyAlign in visual mode: e.g. vipga" },
            { "ga", "<Plug>(EasyAlign)", mode = "x", desc = "EasyAlign for a motion/text object (e.g. gaip)" }
        }
    },
    { "folke/todo-comments.nvim",
        dependencies = "nvim-lua/plenary.nvim",
    },
    { "tpope/vim-repeat" },
    { "zef/vim-cycle" },
    { "numToStr/Comment.nvim" },
    { "windwp/nvim-spectre",
        keys = {
            { "<leader>sr", function() require("spectre").open() end, desc = "Replace in files (Spectre)" },
        },
    },
}
