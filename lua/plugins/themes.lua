---@type Theme
local COLORSCHEME = "kanagawa-dragon" -- gruvbox-material

---@alias Theme
---| '"kanagawa-dragon"'    # Kanagawa dark colorscheme
---| '"kanagawa-wave"'      # Kanagawa light colorscheme
---| '"gruvbox-material"'   # Gruvbox material colorscheme

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
                    ["CursorLine"] = { bg = colors.theme.ui.bg_m3 },
                    ["Pmenu"] = { link = "Normal" },
                    ["WinSeparator"] = { link = "SignColumn" },
                    ["TreesitterContextBottom"] = { underline = true },
                    ["lualine_c_normal"] = { link = "StatusLine" },
                    -- NOTE: Related issue: https://github.com/rebelot/kanagawa.nvim/issues/253
                    -- Override did't take any effect, even with :KanagawaCompile. Had to manually override
                    -- ["@lsp.type.comment.cpp"] = { link = "Comment" },
                }
            end,
        },
        config = function()
            customizer_hl_functors["kanagawa-dragon"] = function()
                vim.api.nvim_set_hl(0, "@lsp.type.comment.cpp", { default = true, link = "Comment" })
            end
            if COLORSCHEME ~= "kanagawa-dragon" and COLORSCHEME ~= "kanagawa-wave" then return end
            vim.cmd.colorscheme("kanagawa-dragon")
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

    -- NOTE: Doesn't play well with classic setup yet.
    -- Potentially usable in future or wait for an alternative
    -- {
    --     "wtfox/jellybeans.nvim",
    --     lazy = false,
    --     priority = 1000,
    --     enabled = true,
    --     opts = {},
    --     config = function()
    --         if COLORSCHEME ~= "jellybeans" then return end
    --         vim.cmd.colorscheme("jellybeans")
    --     end,
    -- },
}
