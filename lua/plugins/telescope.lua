return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    cmd = { "Telescope" },
    keys = {
        {
            "<leader>flp",
            function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
            desc = "Find plugin files"
        },

        { "<leader>ff",  ":Telescope find_files<CR>",                desc = "Telescope find by file name" },
        { "<leader>fg",  ":Telescope live_grep<CR>",                 desc = "Telescope find by text" },
        { "<leader>fb",  ":Telescope buffers<CR>",                   desc = "Telescope buffers list" },
        { "<leader>fh",  ":Telescope help_tags<CR>",                 desc = "Telescope help tags (docs)" },
        { "<leader>/",   ":Telescope current_buffer_fuzzy_find<CR>", desc = "Telescope help tags (docs)" },

        { "<leader>fvo", ":Telescope vim_options<CR>",               desc = "Telescope vim options" },
        { "<leader>fvr", ":Telescope reloader<CR>",                  desc = "Telescope vim module reloader" },
        { "<leader>fvk", ":Telescope keymaps<CR>",                   desc = "Telescope vim keymaps" },
    },
    config = function()
        local actions = require("telescope.actions")
        local trouble = require("trouble.sources.telescope")
        require("telescope").setup {
            defaults = {
                winblend = 10,
                mappings = {
                    i = {
                        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
                        ["<C-Q>"] = actions.smart_add_to_qflist + actions.open_qflist,
                    },
                    n = {
                        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
                        ["<A-Q>"] = actions.smart_add_to_qflist + actions.open_qflist,
                        ["<C-n>"] = actions.cycle_history_next,
                        ["<C-p>"] = actions.cycle_history_prev,
                        ["<C-x>"] = actions.delete_buffer
                    },
                },
            },
            pickers = { colorscheme = { enable_preview = true } }
        }
    end,
}
