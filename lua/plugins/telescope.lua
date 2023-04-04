return{
    { "nvim-telescope/telescope.nvim",
        dependencies = {
            { "nvim-lua/plenary.nvim"},
            { "nvim-telescope/telescope-fzf-native.nvim" },
            { "nvim-telescope/telescope-file-browser.nvim" },
        },
        opts = {
            defaults = {
                theme = "ivy",
                winblend = 10
            }
        },
        keys = {
            { "<leader>fp", function() require("telescope.builtin").find_files( { cwd = require("lazy.core.config").options.root }) end,
                desc = "Find plugin files"
            },

            {"<leader>ff", ":Telescope find_files<CR>",   desc = "Telescope find by file name" },
            {"<leader>fg", ":Telescope live_grep<CR>",    desc = "Telescope find by text" },
            {"<leader>fb", ":Telescope buffers<CR>",      desc = "Telescope buffers list" },
            {"<leader>fh", ":Telescope help_tags<CR>",    desc = "Telescope help tags (docs)" },
            {"<leader>f/", ":Telescope current_buffer_fuzzy_find<CR>", desc = "Telescope help tags (docs)" },

            {"<leader>fvo", ":Telescope vim_options<CR>", desc = "Telescope vim options"},
            {"<leader>fvr", ":Telescope reloader<CR>",    desc = "Telescope vim module reloader"},
            {"<leader>fvk", ":Telescope keymaps<CR>",     desc = "Telescope vim keymaps"},

            {"<leader>flr", ":Telescope lsp_references<CR>",      desc = "Telescope LSP references"},
            {"<leader>flc", ":Telescope lsp_incoming_calls<CR>",  desc = "Telescope LSP incoming calls"},
            {"<leader>flci", ":Telescope lsp_incoming_calls<CR>", desc = "Telescope LSP incoming calls"},
            {"<leader>flco", ":Telescope lsp_outgoing_calls<CR>", desc = "Telescope LSP outgoing calls"},

            {"<leader>flgd", ":Telescope lsp_definitions<CR>",      desc = "Telescope LSP definitions"},
            {"<leader>flgt", ":Telescope lsp_type_definitions<CR>", desc = "Telescope LSP goto type definition"},
            {"<leader>flgi", ":Telescope lsp_implementations<CR>",  desc = "Telescope LSP goto implementation"},

            {"<leader>flds", ":Telescope lsp_document_symbols<CR>",  desc = "Telescope LSP list document symbols"},
            {"<leader>flws", ":Telescope lsp_workspace_symbols<CR>", desc = "Telescope LSP list workspace symbols"},
            {"<leader>fldws", ":Telescope lsp_dynamic_workspace_symbols<CR>", desc = "Telescope LSP dynamically list workspace symbols"},

            {"<leader>fldg", ":Telescope diagnostics<CR>", desc = "Telescope LSP list diagnostics"},

        },
    },

    { "nvim-telescope/telescope-fzf-native.nvim", build = "make",
        config = function() require('telescope').load_extension('fzf') end,
        lazy = true
    },
    { "nvim-telescope/telescope-file-browser.nvim",
        config = function() require('telescope').load_extension('file_browser') end,
        keys = {
            {"<leader>fe", ":Telescope file_browser path=%:p:h select_buffer=true<CR>", desc = "Telescope toogle file browser"}
        },
    }
}
