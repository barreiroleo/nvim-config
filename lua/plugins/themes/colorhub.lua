-- This file contains the color definition for all the modifications for individual plugins.
-- It's like a repository. Fetch this file from a particular plugin like:
--     require("plugins.themes.colorhub").SpecificPlugin
-- will return a table with the color definition depending on the actual
-- colorscheme or a nil value in case of there isn't a color definition for the
-- current colorscheme. That can be used for example
--     local colors = require("plugins.theme.colorhub").Navic
--     if colors then bg = colors.bg end

local M = {}

M.CursorLine_bg = nil
M.Navic = nil
M.Lualine = nil
M.Context = nil

if vim.g.colors_name == "catppuccin" then
    local flavour = require("catppuccin").flavour
    local palette = require('catppuccin.palettes').get_palette(flavour)
    M.CursorLine = {
        bg = palette.mantle
    }
    M.Navic = {
        bg = palette.crust,
        fg = palette.text,
        fg_icon = palette.peach,
    }
    M.Lualine = {
        normal_c_bg = palette.crust,
        inactive_c_bg = palette.mantle
    }
    M.Context = {
        bg = palette.mantle,
        fg = palette.text,
    }
end

return M
