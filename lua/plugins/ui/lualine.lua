local navic = require("nvim-navic")
local theme = require("plugins.themes.colorhub").Lualine

local M = { }

M.diff_source = function()
    local gitsigns = vim.b.gitsigns_status_dict
    if gitsigns then
        return {
            added = gitsigns.added,
            modified = gitsigns.changed,
            removed = gitsigns.removed,
        }
    end
end

M.statusline = {
    sections = {
        lualine_b = { { 'b:gitsigns_head', icon = '' }, { 'diff', source = M.diff_source } },
        lualine_c = { 'filename' },
        lualine_x = { }
    },
    inactive_sections = {
        lualine_c = { },
    },
}

M.winbar = {
    -- HACK:Using X section to fix winbar solid background.
    -- When no X section is used, the highlight group stop at the las component and the rest of the line becomes transparent.
    -- Placing a empty secction, the solid background continues to the end.
    -- On lualine issues a new interface for colors has been proposed.
    active_winbar = {
        lualine_c = { 'filename', { function() return navic.get_location() end, cond = navic.is_available } },
        lualine_x = { '" "' },
    },
    inactive_winbar = {
        lualine_c = { 'filename', { function() return navic.get_location() end, cond = navic.is_available } },
        lualine_x = { '" "' },
    },
}

M.options = {
    theme = theme,
    component_separators = '|',
    section_separators = { left = '', right = '' },
    disabled_filetypes = { 'neo-tree', 'TelescopePrompt', 'packer', 'toggleterm' },
    always_divide_middle = false,
    globalstatus = false,
}

return {
    { "nvim-lualine/lualine.nvim",
        enabled = true,
        event = "VeryLazy",
        dependencies = {
            {"SmiteshP/nvim-navic"},
            {"kyazdani42/nvim-web-devicons"}
        },
        opts = {
            options = M.options,
            sections = M.statusline.sections,
            inactive_sections = M.statusline.inactive_sections,
            winbar = M.winbar.active_winbar,
            inactive_winbar = M.winbar.inactive_winbar,
        }
    },
}
