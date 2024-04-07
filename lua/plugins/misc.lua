return {
    { "lambdalisue/suda.vim", lazy = true, cmd = { "SudaWrite", "SudaRead" } },
    {
        "folke/twilight.nvim",
        config = function()
            require("twilight").setup()
        end,
    },
}
