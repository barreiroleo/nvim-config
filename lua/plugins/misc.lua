return {
    {
        "nvim-lua/plenary.nvim",
        keys = {
            { "<leader><leader>t", "<cmd>w<cr> | <Plug>PlenaryTestFile", desc = "Plenary: Test current file" }
        }
    },

    {
        'mbbill/undotree',
        cmd = "UndotreeShow"
    },

    {
        "chentoast/marks.nvim",
        event = { "BufNewFile", "BufReadPre" },
        opts = {}
    },

    {
        "danymat/neogen",
        keys = {
            { "<leader>dg", function() require('neogen').generate() end, mode = { "n", "v" }, desc = "Neogen: Generate docs" }
        },
        opts = { snippet_engine = "luasnip" }
    },

    {
        "ThePrimeagen/refactoring.nvim",
        keys = {
            { "<leader>rr", function() require("refactoring").select_refactor({}) end, mode = { "n", "x" }, desc = "Refactoring: Select refactor" },
        },
        opts = {
            prompt_func_return_type = { cpp = true, c = true },
            prompt_func_param_type = { cpp = true, c = true },
        },
    },
}
