return {
    {
        -- Themes: latte, frappe, macchiato, mocha
        -- ~/.local/share/nvim/lazy/catppuccin/lua/catppuccin/palettes/mocha.lua | base, mantle, crust
        "catppuccin/nvim",
        name = "catppuccin",
        enabled = false,
        priority = 1000,
        config = function()
            require("catppuccin").setup {
                background = {
                    light = 'latte',
                    dark = 'mocha'
                },
                transparent_background = true,
            }
            vim.cmd.colorscheme("catppuccin")
        end,
    },

    {
        'rebelot/kanagawa.nvim',
        lazy = false,
        priority = 1000,
        enabled = true,
        config = function()
            require('kanagawa').setup {
                compile = true,     -- enable compiling the colorscheme
                transparent = true, -- do not set background color
                background = {
                    dark = 'dragon',
                },
                overrides = function(colors)
                    local theme = colors.theme
                    return {
                        NormalFloat = { bg = "none" },
                        FloatBorder = { bg = "none" },
                        FloatTitle = { bg = "none" },

                        -- Save an hlgroup with dark background and dimmed foreground
                        -- so that you can use it where your still want darker windows.
                        -- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
                        NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

                        -- Popular plugins that open floats will link to NormalFloat by default;
                        -- set their background accordingly if you wish to keep them dark and borderless
                        LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
                        MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
                    }
                end,
            }
            vim.cmd.colorscheme("kanagawa")
        end,
    },
}
