return {
    {
        "rebelot/kanagawa.nvim",
        lazy = false,
        priority = 1000,
        enabled = true,
        opts = {
            compile = true,
            background = { dark = "dragon" },
            transparent = false,
            dimInactive = true,
            overrides = function(colors)
                -- Supported keywords are the same for :h nvim_set_hl {val} parameter.
                return {
                    ["CursorLine"] = { bg = colors.theme.ui.bg_m3 },
                    ["Pmenu"] = { link = "Normal" },
                    ["WinSeparator"] = { link = "SignColumn" },
                    ["TreesitterContextBottom"] = { underline = true },
                    ["lualine_c_normal"] = { link = "StatusLine" }
                }
            end,
        },
        config = function()
            vim.cmd.colorscheme("kanagawa-dragon")
        end,
    },

    -- {
    --     "thesimonho/kanagawa-paper.nvim",
    --     lazy = false,
    --     priority = 1000,
    --     enabled = true,
    --     opts = {
    --         transparent = false,
    --         gutter = true,
    --         dimInactive = true,
    --         functionStyle = { italic = true },
    --         keywordStyle = { italic = true, bold = false },
    --         statementStyle = { italic = true, bold = false },
    --         typeStyle = { italic = true },
    --         overrides = function(colors)
    --             -- Supported keywords are the same for :h nvim_set_hl {val} parameter.
    --             return {
    --                 ["CursorLine"] = { bg = colors.theme.ui.bg_m3 },
    --                 ["Pmenu"] = {bg = colors.theme.ui.bg_dim},
    --                 ["WinSeparator"] = { link = "SignColumn" },
    --                 ["TreesitterContextBottom"] = { underline = true },
    --                 ["lualine_c_normal"] = { link = "StatusLine" }
    --             }
    --         end,
    --     },
    --     config = function()
    --         vim.cmd.colorscheme("kanagawa-paper")
    --     end
    -- },

    -- {
    --     "sainnhe/gruvbox-material",
    --     lazy = false,
    --     priority = 1000,
    --     enabled = true,
    --     opts = {},
    --     config = function()
    --         vim.o.termguicolors = true
    --         vim.g.gruvbox_material_background = "hard"
    --         vim.g.gruvbox_material_foreground = "material"
    --         vim.g.gruvbox_material_better_performance = 1
    --         vim.g.gruvbox_material_enable_bold = true
    --         vim.g.gruvbox_material_enable_italic = true
    --         vim.g.gruvbox_material_transparent_background = false
    --         vim.cmd.colorscheme("gruvbox-material")
    --         vim.cmd.highlight("LspInlayHint cterm=italic,underline guifg=#686868")
    --         vim.cmd.highlight("TreesitterContextBottom gui=underline guisp=Grey")
    --         vim.cmd.highlight("Normal guifg=#c5c9c5 guibg=#181616")
    --         vim.cmd.highlight("NormalNC guifg=#c8c093 guibg=#12120f")
    --         vim.cmd.highlight("NormalFloat guifg=#c8c093 guibg=#0d0c0c")
    --         vim.cmd.highlight("FloatBorder guifg=#54546d guibg=#0d0c0c")
    --     end
    -- },

    -- {
    --     "sainnhe/everforest",
    --     lazy = false,
    --     priority = 1000,
    --     enabled = true,
    --     opts = {},
    --     config = function()
    --         vim.o.termguicolors = true
    --         vim.g.everforest_background = "hard"
    --         vim.g.everforest_ui_contrast = "high"
    --         vim.g.everforest_better_performance = 1
    --         vim.g.everforest_enable_italic = 1
    --         vim.g.everforest_transparent_background = 0
    --         vim.cmd.colorscheme("everforest")
    --         vim.cmd.highlight("LspInlayHint cterm=italic,underline guifg=#686868")
    --         vim.cmd.highlight("TreesitterContextBottom gui=underline guisp=Grey")
    --         vim.cmd.highlight("Normal guifg=#c5c9c5 guibg=#181616")
    --         vim.cmd.highlight("NormalNC guifg=#c8c093 guibg=#12120f")
    --         vim.cmd.highlight("NormalFloat guifg=#c8c093 guibg=#0d0c0c")
    --         vim.cmd.highlight("FloatBorder guifg=#54546d guibg=#0d0c0c")
    --     end
    -- },

    -- {
    --     "wtfox/jellybeans.nvim",
    --     lazy = false,
    --     priority = 1000,
    --     enabled = true,
    --     opts = {},
    --     config = function()
    --         vim.cmd.colorscheme("jellybeans")
    --     end,
    -- },

    -- {
    --     "Mofiqul/vscode.nvim",
    --     lazy = false,
    --     priority = 1000,
    --     enabled = true,
    --     opts = {},
    --     config = function()
    --         vim.cmd.colorscheme("vscode")
    --     end
    -- },
}
