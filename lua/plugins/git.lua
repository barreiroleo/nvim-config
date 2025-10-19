return {
    {
        "tpope/vim-fugitive",
        cmd = { "Git" }
    },

    {
        "barreiroleo/diff-tools.nvim",
        opts = {}
    }

    -- {
    --     "sindrets/diffview.nvim",
    --     cmd = { "DiffviewFileHistory", "DiffviewOpen" },
    --     opts = {
    --         default_args = {
    --             DiffviewOpen = { "--imply-local" },
    --         }
    --     }
    -- },

    -- {
    --     "lewis6991/gitsigns.nvim",
    --     event = { "BufNewFile", "BufReadPre" },
    --     opts = {
    --         current_line_blame = true,
    --         current_line_blame_opts = {
    --             virt_text_pos = 'right_align',
    --         },
    --     }
    -- },
}
