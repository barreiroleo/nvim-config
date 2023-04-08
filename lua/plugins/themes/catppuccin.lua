-- Themes: latte, frappe, macchiato, mocha
-- ~/.local/share/nvim/lazy/catppuccin/lua/catppuccin/palettes/mocha.lua | base, mantle, crust
local flavour_dark = 'mocha'
local flavour_light = 'latte'


local AutoLightDark = function()
    vim.api.nvim_create_autocmd('OptionSet', {
        group = vim.api.nvim_create_augroup("CatppuccinAfterUser", { clear = true }),
        pattern = 'background',
        callback = function()
            vim.cmd('Catppuccin ' .. (vim.v.option_new == 'light' and flavour_light or flavour_dark))
        end,
    })
end

local CatppuccinAfter = function()
    vim.api.nvim_create_autocmd("User", {
        group = vim.api.nvim_create_augroup("CatppuccinAfterUser", { clear = true }),
        pattern = "VeryLazy",
        callback = function()
            AutoLightDark()
            require("plugins.ui.ts-context").set_tscontext_hl()
        end,
    })
end

local catppuccin_opt = {
    flavour = 'mocha',
    background = {
        light = "latte",
        dark = "mocha"
    },
    transparent_background = true,
    term_colors = false,
    dim_inactive = {
        enabled = false,
        shade = 'dark',
        percentage = 0.15,
    },
    integrations = {
        cmp = true,
        symbols_outline = true,
        telescope = true,
        treesitter = true,
        treesitter_context = true,
        ts_rainbow = true,
        -- Special integrations, see https://github.com/catppuccin/nvim#special-integrations
        dap = {
            enabled = true,
            enable_ui = true,
        },
        indent_blankline = {
            enabled = true,
            colored_indent_levels = true,
        },
    },
    custom_highlights = {
        CursorLine = { bg = "#181825" }, -- Mocha: Mantle
    },
}

return {
    { "catppuccin/nvim", name = "catppuccin",
        enabled = true,
        lazy = false,
        priority = 1000,
        config = function()
            require("catppuccin").setup(catppuccin_opt)
            vim.cmd.colorscheme("catppuccin")
            require("plugins.themes.colorhub").update("catppuccin")
            CatppuccinAfter()
        end,
    }
}
