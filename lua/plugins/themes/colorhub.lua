local M = {}

M.CursorLine = { bg = nil }
M.Navic = { bg = nil, fg = nil, fg_icon = nil }
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
    opts.CursorLine = vim.tbl_deep_extend("force", M.CursorLine, opts.CursorLine or {} )
    opts.Navic = vim.tbl_deep_extend("force", M.Navic, opts.Navic or {} )
    opts.Lualine = vim.tbl_deep_extend("force", M.Lualine, opts.Lualine or {} )
    opts.TSContext = vim.tbl_deep_extend("force", M.TSContext, opts.TSContext or {} )

    -- P(opts)
    vim.api.nvim_set_hl(0, 'CursorLine', opts.CursorLine)
    require('plugins.treesitter.ts-context').setup(opts.TSContext)
    require("plugins.ui.navic").setup(opts.Navic)
end

return M
