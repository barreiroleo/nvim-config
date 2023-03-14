return{
    { "nvim-telescope/telescope.nvim",
        dependencies = {
            { "nvim-lua/plenary.nvim"},
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" }
        },
        opts = {
            defaults = {
                winblend = 10
            }
        },
        config = function()
            require('telescope').load_extension('fzf')
        end
    }
}
