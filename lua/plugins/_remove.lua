return {
    -- {
    --     'windwp/nvim-spectre',
    --     keys = {
    --         { '<leader>sr', function() require('spectre').open() end, desc = 'Replace in files (Spectre)', },
    --     },
    -- },



    -- Docs generation
    {
        "danymat/neogen",
        event = { "BufNewFile", "BufReadPre" },
        keys = {
            { "<leader>dg", function() require('neogen').generate() end, mode = { "n", "v" }, desc = "[Neogen] Generate docs" }
        },
        opts = { snippet_engine = "luasnip" }
    },
}
