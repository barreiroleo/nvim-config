return {
    { "tpope/vim-fugitive",
        event = { "BufNewFile", "BufReadPre" },
        dependencies = {
            "sindrets/diffview.nvim",
        },
    },

    { "lewis6991/gitsigns.nvim",
        event = { "BufNewFile", "BufReadPre" },
        opts = {
            -- toggle line blame with "toggle_current_line_blame = true"
            current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
            current_line_blame_opts = {
                virt_text = true,
                virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
                delay = 1000,
                ignore_whitespace = false,
            },
            current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
            sign_priority = 4096,
        }
    },
}
