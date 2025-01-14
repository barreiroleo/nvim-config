return {
    -- {
    --     -- Themes: latte, frappe, macchiato, mocha
    --     -- ~/.local/share/nvim/lazy/catppuccin/lua/catppuccin/palettes/mocha.lua | base, mantle, crust
    --     "catppuccin/nvim",
    --     name = "catppuccin",
    --     priority = 1000,
    --     config = function()
    --         require("catppuccin").setup {
    --             background = {
    --                 light = 'latte',
    --                 dark = 'mocha'
    --             },
    --             transparent_background = true,
    --         }
    --         vim.cmd.colorscheme("catppuccin")
    --     end,
    -- },

    {
        'rebelot/kanagawa.nvim',
        lazy = false,
        priority = 1000,
        config = function()
            require('kanagawa').setup {
                compile = false,      -- enable compiling the colorscheme
                transparent = false, -- do not set background color
                background = {
                    dark = 'dragon',
                },
                overrides = function(colors)
                    local theme = colors.theme
                    return {
                        NormalFloat = { bg = "none" },
                        FloatBorder = { bg = "none" },
                        FloatTitle = { bg = "none" },

                        CursorLine = { bg = theme.ui.bg_m3 },

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

            vim.cmd("highlight! default link Pmenu Normal")
            vim.cmd("highlight! default link WinSeparator SignColumn")
            vim.cmd("highlight! TreesitterContextBottom gui=underline guisp=Grey")
            vim.cmd("highlight! default link lualine_c_normal StatusLine")
        end,
    },

    -- {
    --     'sainnhe/gruvbox-material',
    --     lazy = false,
    --     priority = 1000,
    --     enabled = true,
    --     config = function()
    --         vim.g.gruvbox_material_background = 'hard'
    --         vim.g.gruvbox_material_foreground = 'mix'
    --         vim.g.gruvbox_material_better_performance = 1
    --         vim.g.gruvbox_material_enable_italic = true
    --         vim.g.gruvbox_material_enable_bold = true
    --         vim.g.gruvbox_material_transparent_background = false
    --         vim.o.termguicolors = true
    --
    --         vim.cmd.colorscheme('gruvbox-material')
    --         vim.cmd.highlight("LspInlayHint cterm=italic,underline guifg=#686868")
    --         vim.cmd.highlight("TreesitterContextBottom gui=underline guisp=Grey")
    --         vim.cmd.highlight("Normal guibg=#0f0f0f")
    --         vim.cmd.highlight("NormalNC guibg=#0f0f0f")
    --         vim.cmd.highlight("NormalFloat guibg=#0f0f0f")
    --         vim.cmd.highlight("FloatBorder guibg=#141414")
    --     end
    -- },
}
