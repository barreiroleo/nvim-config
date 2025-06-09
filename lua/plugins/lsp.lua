return {
    {
        "neovim/nvim-lspconfig",
        event = { "BufNewFile", "BufReadPre" },
        cmd = { "Mason", "MasonInstall" },
        dependencies = {
            { "mason-org/mason.nvim" },
            { "mason-org/mason-lspconfig.nvim" },
            { "folke/lazydev.nvim" }
        },
        config = function()
            vim.lsp.config("*", {
                capabilities = require("core.lsp.capabilities").extend_capabilities()
            })

            require("core.lsp.ui")

            require('mason').setup()

            require("mason-lspconfig").setup({
                ensure_installed = {
                    "clangd",
                    "lua_ls",
                },
                automatic_enable = {
                    exclude = { "rust_analyzer" }
                },
            })
        end,
    },

    {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
            library = {
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                { path = "snacks.nvim",        words = { "Snacks" } },
            },
        }
    },

    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        opts = {
            suggestion = { enabled = false },
            panel = { enabled = false },
            filetypes = {
                markdown = true,
                help = true,
            },
        },
    },
}
