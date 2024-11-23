return {
    "neovim/nvim-lspconfig",
    dependencies = {
        { "williamboman/mason.nvim" },
        { "williamboman/mason-lspconfig.nvim" },
        { "j-hui/fidget.nvim", opts = { } },
        { "folke/lazydev.nvim", ft = "lua", config = true },
    },
    event = { "BufNewFile", "BufReadPre" },
    config = function() require("core.lsp") end,
    cmd = { "Mason", "MasonInstall" },
}
