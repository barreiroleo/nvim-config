-- This file is a repository that contains the custom colors used around my config.
--
-- Each color scheme or theme installed should execute the update function to update the repository.
--      require("plugins.themes.colorscheme").update("colors_name")
--
-- At the moment the colors are defined here but in the future would be nice if each theme could provide its own override.
--
-- The usage inner the plugins could be as follows: get the specific plugin function and use it afterward.
--       local get_colors = require("plugins.themes.colorscheme").get_Navic
--       -- In some setup next
--       colors = get_colors()
-- The specific functions must return the data scheme that needs the plugins to configure.

local M = {}
local _ = {}

_.CursorLine_bg = nil
_.Navic = { bg = "#11111B", fg = "#CDD6F4", fg_icon = "#CDD6F4" }
_.Lualine = nil
_.Context = { ['TC'] = nil, ['TC_LineNumber'] = nil, ['TC_Bottom'] = nil }


function M.update(theme)
    theme = theme or vim.g.colors_name

    if string.match(vim.g.colors_name, "catppuccin") then
        local flavour = require('catppuccin').flavour
        local palette = require('catppuccin.palettes').get_palette(flavour)
        _.CursorLine = {
            bg = palette.mantle,
        }
        _.Navic = {
            bg = palette.mantle,
            fg = palette.text,
            fg_icon = palette.peach,
        }

        -- TODO: fix order of excecution. Lualine is excecuting before catppuccin
        _.Lualine = require("lualine.themes.catppuccin")
        _.Lualine.normal.c.bg = palette.crust
        _.Lualine.inactive_c_bg = palette.mantle
        -- vim.api.nvim_set_hl(0, 'lualine_c_normal', { bg = palette.base, fg = palette.text })
        -- vim.api.nvim_set_hl(0, 'lualine_c_inactive', { bg = palette.mantle, fg = palette.overlay0 })

        _.Context = {
            ["TC"] = { bg = palette.mantle },
            ["TC_Bottom"] = { bg = palette.mantle },
            ["TC_LineNumber"] = { bg = palette.mantle, fg = palette.surface0 }
        }
    end

    if vim.g.colors_name == "monokai-pro" then
        _.Lualine = 'monokai-pro'
    end

end

function M.get_CursorLine() return _.CursorLine_bg end
function M.get_Navic() return _.Navic end
function M.get_Lualine() return _.Lualine end
function M.get_Context() return _.Context end

return M
