return {
    {
        "nvim-lua/plenary.nvim",
        keys = { { "<leader><leader>t", "<cmd>w<cr> | <Plug>PlenaryTestFile", desc = "Plenary: Test current file" } }
    },
    {
        'mbbill/undotree',
        cmd = "UndotreeShow"
    },
    {
        "lambdalisue/suda.vim",
        cmd = { "SudaWrite", "SudaRead" }
    },
    {
        "chentoast/marks.nvim",
        event = { "BufNewFile", "BufReadPre" },
        opts = {}
    },
    {
        "tpope/vim-dispatch",
        cmd = { "Dispatch", "Make" }
    },

    {
        "danymat/neogen",
        event = { "BufNewFile", "BufReadPre" },
        keys = {
            { "<leader>dg", function() require('neogen').generate() end, mode = { "n", "v" }, desc = "Neogen: Generate docs" }
        },
        opts = { snippet_engine = "luasnip" }
    },

    {
        "barreiroleo/refactoring.nvim",
        branch = "fix_ts_nightly",
        event = { "BufNewFile", "BufReadPre" },
        keys = {
            { "<leader>rr", function() require("refactoring").select_refactor({}) end, mode = { "n", "x" }, desc = "Refactoring: Select refactor" },
        },
        opts = {
            prompt_func_return_type = { cpp = true, c = true },
            prompt_func_param_type = { cpp = true, c = true },
        },
    },
}
