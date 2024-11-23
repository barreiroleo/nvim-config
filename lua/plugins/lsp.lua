return {
    "neovim/nvim-lspconfig",
    event = { "BufNewFile", "BufReadPre" },
    dependencies = {
        { "williamboman/mason.nvim" },
        { "williamboman/mason-lspconfig.nvim" },
        {
            "j-hui/fidget.nvim", opts = {}
        },
        {
            "folke/lazydev.nvim", ft = "lua", opts = {}
        },
    },
    config = function() require("core.lsp") end,
    cmd = { "Mason", "MasonInstall" },
}
