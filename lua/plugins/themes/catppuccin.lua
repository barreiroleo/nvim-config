-- Themes: latte, frappe, macchiato, mocha
-- ~/.local/share/nvim/site/pack/packer/start/catppuccin/lua/catppuccin/palettes/mocha.lua | base, mantle, crust
local flavour_dark = 'mocha'
local flavour_light = 'latte'

local AutoLightDark = function()
    vim.api.nvim_create_autocmd('OptionSet', {
        group = vim.api.nvim_create_augroup("CatpuccinAfterUser", { clear = true }),
        pattern = 'background',
        callback = function()
            vim.cmd('Catppuccin ' .. (vim.v.option_new == 'light' and flavour_light or flavour_dark))
        end,
    })
end

local CatppuccinAfter = function()
    vim.api.nvim_create_autocmd("User", {
        group = vim.api.nvim_create_augroup("CatpuccinAfterUser", { clear = true }),
        pattern = "VeryLazy",
        callback = function()
            AutoLightDark()
        end,
    })
end

return {
    { "catppuccin/nvim", name = "catppuccin",
    lazy = false,
    priority = 1000,
    opts = {
        flavour_dark = 'mocha',
        transparent_background = true,
        term_colors = true,
        dim_inactive = {
            enabled = false,
            shade = 'dark',
            percentage = 0,
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
    },
    config = function()
        vim.cmd.colorscheme "catppuccin-mocha"
        CatppuccinAfter()
    end,
}
}
