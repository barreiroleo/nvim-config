local M = {}

M.TSContext = { TC = nil, TC_Bottom = nil, TC_LineNumber = nil }

-- FIX: Lualine is excecuted before colorscheme loading. That means lualine is loading trash.
-- 'monokai-pro'
local flavour = require("catppuccin").flavour
local palette = require('catppuccin.palettes').get_palette(flavour)
M.Lualine= require 'lualine.themes.catppuccin'
M.Lualine.inactive.c.bg = palette.mantle
M.Lualine.normal.c.bg = palette.mantle

function M.setup(opts)
    opts = opts or {}
    opts.Lualine = vim.tbl_deep_extend("force", M.Lualine, opts.Lualine or {} )
    opts.TSContext = vim.tbl_deep_extend("force", M.TSContext, opts.TSContext or {} )

    -- P(opts)
    require('plugins.treesitter.ts-context').setup(opts.TSContext)
end

return M
