-- Filters: classic | octagon | pro | machine | ristretto | spectrum

local monokai_opts = {
    transparent_background = false,
    terminal_colors = true,
    day_night = {
        enable = true,
        day_filter = "pro",
        night_filter = "ristretto",
    }
}

return{
    { "loctvl842/monokai-pro.nvim",
        enabled = false,
        lazy = false,
        priority = 1000,
        config = function()
            require("monokai-pro").setup(monokai_opts)
            vim.cmd.colorscheme("monokai-pro")
            require("plugins.themes.colorhub").setup()
        end,
    }
}
