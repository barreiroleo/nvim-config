return {
    "neovim/nvim-lspconfig",
    event = { "BufNewFile", "BufReadPre" },
    dependencies = {
        { "williamboman/mason.nvim" },
        { "williamboman/mason-lspconfig.nvim" },
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
    },
    config = function() require("core.lsp") end,
    cmd = { "Mason", "MasonInstall" },
}
