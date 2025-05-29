return {
    {
        "tpope/vim-fugitive",
        dependencies = "sindrets/diffview.nvim",
        cmd = { "Git" }
    },

    {
        "sindrets/diffview.nvim",
        cmd = { "DiffviewFileHistory", "DiffviewOpen" },
        opts = {
            default_args = {
                DiffviewOpen = { "--imply-local" },
            }
        }
    },

    {
        "echasnovski/mini.diff",
        version = false,
        opts = {
            view = {
                style = 'sign',
            },
            mappings = {
                goto_prev = '[c',
                goto_next = ']c',
            },
        },
        keys = {
            { "[c", function() MiniDiff.goto_hunk("prev") end, { desc = "MiniDiff: Prev hunk" } },
            { "[c", function() MiniDiff.goto_hunk("prev") end, { desc = "MiniDiff: Next hunk" } },
        }

    }

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
