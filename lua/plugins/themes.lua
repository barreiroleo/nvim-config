--- Dark and Light colorschemes
local COLORSCHEME_DARK = "kanagawa-paper"
local COLORSCHEME_LIGHT = "vscode"

---Repository to store functors to customizer highlights according the colorscheme
---@type table<string, function?>
local CUSTOM_HIGHLIGHT_MAP = {
    ["common"] = function()
        -- DAP UI highlights
        vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })
        -- Diagnostic highlights
        if vim.o.background == "dark" then
            vim.cmd.highlight("ErrorMsg guibg=#250000 guifg=0")
            vim.cmd.highlight("WarningMsg guibg=#252500 guifg=0")
        end
    end,

    ["default"] = function()
        vim.cmd.highlight("ColorColumn guibg=#303236")
    end
}

---Reaply custom highlights every time a colorscheme is loaded or switched.
vim.api.nvim_create_autocmd("ColorScheme", {
    callback = function(args)
        local colorscheme = args.match
        return CUSTOM_HIGHLIGHT_MAP[colorscheme] and CUSTOM_HIGHLIGHT_MAP[colorscheme]()
    end,
})

require("core.utils.auto-switch-theme").lazy_setup({
    dark = COLORSCHEME_DARK,
    light = COLORSCHEME_LIGHT,
})

return {
    -- I've found gruvbox's highlight to enoying bright. Specially with LSP references and copilot.
    {
        "sainnhe/gruvbox-material",
        lazy = false,
        priority = 1000,
        opts = {},
        config = function(_, opts)
            vim.o.termguicolors = true
            vim.g.gruvbox_material_background = "hard"
            vim.g.gruvbox_material_foreground = "material"
            vim.g.gruvbox_material_better_performance = 1
            vim.g.gruvbox_material_enable_bold = true
            vim.g.gruvbox_material_enable_italic = true
            vim.g.gruvbox_material_transparent_background = false

            CUSTOM_HIGHLIGHT_MAP["gruvbox-material"] = function()
                vim.cmd.highlight("LspInlayHint cterm=italic,underline guifg=#686868")
                vim.cmd.highlight("TreesitterContextBottom gui=underline guisp=Grey")
                vim.cmd.highlight("Normal guifg=#c5c9c5 guibg=#181616")
                vim.cmd.highlight("NormalNC guifg=#c8c093 guibg=#12120f")
                vim.cmd.highlight("NormalFloat guifg=#c8c093 guibg=#0d0c0c")
                vim.cmd.highlight("FloatBorder guifg=#54546d guibg=#0d0c0c")
                vim.api.nvim_set_hl(0, "LazyDimmed", { default = true, link = "Comment" })
            end
        end
    },

    -- Still love kanagawa dragon, but I'm tired of it.
    {
        "rebelot/kanagawa.nvim",
        lazy = false,
        priority = 1000,
        opts = {
            compile = true,
            background = { dark = "dragon" },
            transparent = false,
            dimInactive = true,
            overrides = function(colors)
                -- Supported keywords are the same for :h nvim_set_hl {val} parameter.
                return {
                    CursorLine              = { bg = colors.theme.ui.bg_m3 },
                    TreesitterContextBottom = { underline = true },
                    -- Dark completion:
                    -- https://github.com/rebelot/kanagawa.nvim#dark-completion-popup-menu
                    Pmenu                   = { link = "Normal" },
                    -- PmenuSel                = { link = "CursorLine" },
                    -- https://github.com/rebelot/kanagawa.nvim/blob/master/lua/kanagawa/highlights/plugins.lua#L196
                    BlinkCmpMenuBorder      = { link = "Pmenu" },
                    BlinkCmpLabelDetail     = { fg = colors.theme.syn.comment },
                    LineNr                  = { bg = "#1c1b1b" },
                }
            end,
        },
        config = function(_, opts)
            require("kanagawa").setup(opts)
        end,
    },

    {
        "thesimonho/kanagawa-paper.nvim",
        lazy = false,
        priority = 1000,
        opts = {
            cache = true,
        },
        config = function(_, opts)
            require("kanagawa-paper").setup(opts)
        end,
        init = function()
            CUSTOM_HIGHLIGHT_MAP["kanagawa-paper"] = function()
                vim.cmd.highlight("Normal guibg=#16161d")
                vim.cmd.highlight("NormalNC guibg=#131319")
                vim.cmd.highlight("ColorColumn guibg=#21212b")
                vim.cmd.highlight("NormalFloat guibg=#21212b")
                vim.cmd.highlight("FloatBorder guibg=#21212b")
            end
        end
    },

    -- Still prefeer vague over rose-pine
    {
        "vague2k/vague.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
        config = function(_, opts)
            require("vague").setup(opts)
        end
    },

    -- {
    --     "rose-pine/neovim",
    --     lazy = false,
    --     priority = 1000,
    --     opts = {},
    --     config = function(_, opts)
    --         require("rose-pine").setup(opts)
    --     end
    -- },

    {
        "Mofiqul/vscode.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
        config = function(_, opts)
            require("vscode").setup(opts)
        end
    },

    -- {
    --     "catppuccin/nvim",
    --     name = "catppuccin",
    --     lazy = false,
    --     priority = 1000,
    --     opts = {},
    --     config = function(_, opts)
    --         require("catppuccin").setup(opts)
    --     end,
    -- },

    {
        "wtfox/jellybeans.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
        config = function(_, opts)
            require("jellybeans").setup(opts)
        end,
        init = function()
            CUSTOM_HIGHLIGHT_MAP["jellybeans-muted"] = function()
                vim.api.nvim_set_hl(0, "SnacksPickerPreviewBorder", { default = true, link = "FloatBorder" })
            end
        end
    },

    -- {
    --     "olimorris/onedarkpro.nvim",
    --     lazy = false,
    --     priority = 1000,
    --     opts = {},
    --     config = function(_, opts)
    --         require("onedarkpro").setup(opts)
    --     end,
    -- },

    -- {
    --     "folke/tokyonight.nvim",
    --     lazy = false,
    --     priority = 1000,
    --     opts = {},
    --     config = function(_, opts)
    --         require("tokyonight").setup(opts)
    --     end,
    -- },

    -- {
    --     "EdenEast/nightfox.nvim",
    --     lazy = false,
    --     priority = 1000,
    --     opts = {},
    --     config = function(_, opts)
    --         require("nightfox").setup(opts)
    --     end,
    -- },

    -- {
    --     "gbprod/nord.nvim",
    --     lazy = false,
    --     priority = 1000,
    --     opts = {},
    --     config = function(_, opts)
    --         require("nord").setup(opts)
    --     end,
    -- },

    -- I've tweaked background more gruvbox-ish. Interesting.
    -- {
    --     'AlexvZyl/nordic.nvim',
    --     lazy = false,
    --     priority = 1000,
    --     opts = {},
    --     config = function(_, opts)
    --         require("nordic").setup(opts)
    --     end,
    --     init = function()
    --         CUSTOM_HIGHLIGHT_MAP["nordic"] = function()
    --             vim.cmd.highlight("Normal guibg=#0f1115")
    --             vim.cmd.highlight("NormalNC guibg=##0a0c0f")
    --             vim.cmd.highlight("FloatBorder guifg=#54546d")
    --             vim.cmd.highlight("TreesitterContextBottom gui=underline guisp=Grey")
    --         end
    --     end
    -- },
}
