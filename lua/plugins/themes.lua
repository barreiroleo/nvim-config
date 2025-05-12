---@type Theme
local COLORSCHEME = "kanagawa-wave"

---@alias Theme
---| "kanagawa-dragon"   # Kanagawa dark colorscheme
---| "kanagawa-wave"     # Kanagawa light colorscheme
---| "gruvbox-material"  # Gruvbox material colorscheme
---| "jellybeans"        # Jellybeans colorscheme

---Repository to store functors to customizer highlights according the colorscheme
---@type table<Theme, function?>
local customizer_hl_functors = {}

---Reaply custom highlights every time a colorscheme is loaded or switched.
vim.api.nvim_create_autocmd("ColorScheme", {
    callback = function(args)
        ---@type Theme
        local colorscheme = args.match

        -- DAP UI highlights
        vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

        -- Diagnostic highlights
        if vim.o.background == "dark" then
            vim.cmd.highlight("ErrorMsg guibg=#250000 guifg=0")
            vim.cmd.highlight("WarningMsg guibg=#252500 guifg=0")
        end

        -- Custom highlights per colorscheme
        if customizer_hl_functors[colorscheme] ~= nil then
            customizer_hl_functors[colorscheme]()
        end
    end,
})


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
                    CursorLine              = { bg = colors.theme.ui.bg_m3 },
                    TreesitterContextBottom = { underline = true },
                    -- Dark completion:
                    -- https://github.com/rebelot/kanagawa.nvim#dark-completion-popup-menu
                    Pmenu                   = { link = "Normal" },
                    -- PmenuSel                = { link = "CursorLine" },
                    -- TODO: Send a PR. There's a typo in BlinkCmpLabelDetail.
                    -- https://github.com/rebelot/kanagawa.nvim/blob/master/lua/kanagawa/highlights/plugins.lua#L196
                    BlinkCmpMenuBorder      = { link = "Pmenu" },
                    BlinkCmpLabelDetail     = { fg = colors.theme.syn.comment },
                }
            end,
        },
        config = function(_, opts)
            require("kanagawa").setup(opts)
            if COLORSCHEME ~= "kanagawa-dragon" and COLORSCHEME ~= "kanagawa-wave" then return end
            vim.cmd.colorscheme(COLORSCHEME)
        end,
    },

    {
        "sainnhe/gruvbox-material",
        lazy = false,
        priority = 1000,
        enabled = true,
        opts = {},
        config = function()
            vim.o.termguicolors = true
            vim.g.gruvbox_material_background = "hard"
            vim.g.gruvbox_material_foreground = "material"
            vim.g.gruvbox_material_better_performance = 1
            vim.g.gruvbox_material_enable_bold = true
            vim.g.gruvbox_material_enable_italic = true
            vim.g.gruvbox_material_transparent_background = false

            customizer_hl_functors["gruvbox-material"] = function()
                vim.cmd.highlight("LspInlayHint cterm=italic,underline guifg=#686868")
                vim.cmd.highlight("TreesitterContextBottom gui=underline guisp=Grey")
                vim.cmd.highlight("Normal guifg=#c5c9c5 guibg=#181616")
                vim.cmd.highlight("NormalNC guifg=#c8c093 guibg=#12120f")
                vim.cmd.highlight("NormalFloat guifg=#c8c093 guibg=#0d0c0c")
                vim.cmd.highlight("FloatBorder guifg=#54546d guibg=#0d0c0c")
            end

            if COLORSCHEME ~= "gruvbox-material" then return end
            vim.cmd.colorscheme("gruvbox-material")
        end
    },

    {
        "Mofiqul/vscode.nvim",
        lazy = false,
        priority = 1000,
        enabled = true,
        opts = {},
        config = function()
            if COLORSCHEME ~= "vscode" then return end
            vim.cmd.colorscheme("vscode")
        end
    },

    -- {
    --     "wtfox/jellybeans.nvim",
    --     lazy = false,
    --     priority = 1000,
    --     enabled = true,
    --     opts = {
    --         background = { dark = "jellybeans_mono" },
    --     },
    --     config = function(_, opts)
    --         require("jellybeans").setup(opts)
    --         if COLORSCHEME ~= "jellybeans" then return end
    --         vim.cmd.colorscheme("jellybeans-mono")
    --     end,
    -- },
}
