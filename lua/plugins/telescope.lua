local map = require("core.utils").map

return{
    { "nvim-telescope/telescope.nvim",
        dependencies = {
            { "nvim-lua/plenary.nvim"},
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
            { "nvim-telescope/telescope-file-browser.nvim" }
        },
        opts = {
            defaults = {
                winblend = 10
            },
            file_browser = {
                theme = "ivy",
                hijack_netrw = true,
                mappings = {
                    ["i"] = {},
                    ["n"] = {},
                }
            }
        },
        config = function()
            map("n", "<leader>ff", ":Telescope find_files<CR>", { desc = "Telescope find by file name" })
            map("n", "<leader>fg", ":Telescope live_grep<CR>",  { desc = "Telescope find by text" })
            map("n", "<leader>fb", ":Telescope buffers<CR>",    { desc = "Telescope buffers list" })
            map("n", "<leader>fh", ":Telescope help_tags<CR>",  { desc = "Telescope help tags (docs)" })
            map("n", "<leader>f/", ":Telescope current_buffer_fuzzy_find<CR>",  { desc = "Telescope help tags (docs)" })

            map("n", "<leader>fvo", ":Telescope vim_options<CR>", {desc = "Telescope vim options"})
            map("n", "<leader>fvr", ":Telescope reloader<CR>", {desc = "Telescope vim module reloader"})
            map("n", "<leader>fvk", ":Telescope keymaps<CR>", {desc = "Telescope vim keymaps"})

            map("n", "<leader>flr", ":Telescope lsp_references<CR>", {desc = "Telescope LSP references"})
            map("n", "<leader>flc", ":Telescope lsp_incoming_calls<CR>", {desc = "Telescope LSP incoming calls"})
            map("n", "<leader>flci", ":Telescope lsp_incoming_calls<CR>", {desc = "Telescope LSP incoming calls"})
            map("n", "<leader>flco", ":Telescope lsp_outgoing_calls<CR>", {desc = "Telescope LSP outgoing calls"})

            map("n", "<leader>flgd", ":Telescope lsp_definitions<CR>", {desc = "Telescope LSP definitions"})
            map("n", "<leader>flgt", ":Telescope lsp_type_definitions<CR>", {desc = "Telescope LSP goto type definition"})
            map("n", "<leader>flgi", ":Telescope lsp_implementations<CR>", {desc = "Telescope LSP goto implementation"})

            map("n", "<leader>flds", ":Telescope lsp_document_symbols<CR>", {desc = "Telescope LSP list document symbols"})
            map("n", "<leader>flws", ":Telescope lsp_workspace_symbols<CR>", {desc = "Telescope LSP list workspace symbols"})
            map("n", "<leader>fldws", ":Telescope lsp_dynamic_workspace_symbols<CR>", {desc = "Telescope LSP dynamically list workspace symbols"})

            map("n", "<leader>fldg", ":Telescope diagnostics<CR>", {desc = "Telescope LSP list diagnostics"})

            -- File browser
            map("n", "<leader>fe", ":Telescope file_browser path=%:p:h select_buffer=true<CR>", {desc = "Telescope toogle file browser" })

            vim.api.nvim_create_autocmd('User', {
                pattern = 'LazyDone',
                callback = function()
                    require('telescope').load_extension('fzf')
                    require('telescope').load_extension('file_browser')
                end
            })
        end
    }
}
