-- Themes: latte, frappe, macchiato, mocha
-- ~/.local/share/nvim/lazy/catppuccin/lua/catppuccin/palettes/mocha.lua | base, mantle, crust
local flavour_dark = 'mocha'
local flavour_light = 'latte'

-- AutoLightDark switch colorscheme
local AutoLightDark = function()
    vim.api.nvim_create_autocmd('OptionSet', {
        group = vim.api.nvim_create_augroup("CatppuccinAfterUser", { clear = true }),
        pattern = 'background',
        callback = function()
            vim.cmd('Catppuccin ' .. (vim.v.option_new == 'light' and flavour_light or flavour_dark))
        end,
    })
end

function setup_colorhub()
    local palette = require('catppuccin.palettes').get_palette(flavour_dark)
    local Lualine = require 'lualine.themes.catppuccin'
    Lualine.inactive.c.bg = palette.mantle
    Lualine.normal.c.bg = palette.mantle
    require("plugins.themes.colorhub").setup {
        Lualine = Lualine,
        Navic = {
            bg = palette.mantle,
            fg = palette.text,
            fg_icon = palette.peach,
        },
        TSContext = {
            ['TC'] = { bg = palette.mantle },
            ['TC_Bottom'] = { bg = palette.mantle },
            ['TC_LineNumber'] = { bg = palette.mantle, fg = palette.surface1 },
        }
    }
end

return {
    "catppuccin/nvim",
    name = "catppuccin",
    enabled = true,
    lazy = false,
    priority = 1000,
    config = function()
        require("catppuccin").setup {
            flavour = 'mocha',
            background = {
                light = flavour_light,
                dark = flavour_dark
            },
            transparent_background = true,
            -- Special integrations https://github.com/catppuccin/nvim#special-integrations
        }
        vim.cmd.colorscheme("catppuccin-" .. flavour_dark)
        setup_colorhub()
        AutoLightDark()
    end,
}
