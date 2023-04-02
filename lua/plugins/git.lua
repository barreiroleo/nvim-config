return {
    { "TimUntersberger/neogit",
        dependencies = "nvim-lua/plenary.nvim",
        config = function()
            P('require("configs.neogit")')
        end,
    },

    { "sindrets/diffview.nvim",
        dependencies = "nvim-lua/plenary.nvim"
    },

    -- { "airblade/vim-gitgutter" },

    { "lewis6991/gitsigns.nvim",
        opts = {
            -- current_line_blame = true, -- #FIX lsp_diagnostic first.
            -- toggle line blame with "toggle_current_line_blame = true"
            current_line_blame_opts = {
                delay = 100,
            },
        }
    },
}
