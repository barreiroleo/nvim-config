return {
    "neovim/nvim-lspconfig",
    dependencies = {
        { "williamboman/mason.nvim" },
        { "williamboman/mason-lspconfig.nvim" },
        { "WhoIsSethDaniel/mason-tool-installer.nvim" },
        { "nvimtools/none-ls.nvim" },
        -- {
        --     "ray-x/lsp_signature.nvim",
        --     config = function()
        --         require("lsp_signature").setup({
        --             hint_enable = false,
        --             toggle_key_flip_floatwin_setting = true,
        --             toggle_key = "<C-e>",      -- toggle signature in insert mode
        --             move_cursor_key = "<C-k>", -- toggle focus between win and floating
        --         })
        --     end
        -- },
        { "folke/lazydev.nvim", ft = "lua", config = true },
    },
    event = { "BufNewFile", "BufReadPre" },
    config = function() require("core.lsp") end,
    cmd = { "Mason", "MasonInstall" },
}
