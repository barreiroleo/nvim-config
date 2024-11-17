return {
    {
        "tpope/vim-fugitive",
        dependencies = {
            "sindrets/diffview.nvim",
        },
        cmd = { "Git" }
    },

    {
        "lewis6991/gitsigns.nvim",
        event = { "BufNewFile", "BufReadPre" },
        opts = {
            current_line_blame = true,
            current_line_blame_opts = {
                virt_text_pos = 'right_align',
            },
        }
    },
}
