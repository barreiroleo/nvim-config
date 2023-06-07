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
            {"kyazdani42/nvim-web-devicons"}
        },
        opts = {
            options = M.options,
            sections = M.statusline.sections,
            inactive_sections = M.statusline.inactive_sections,
        }
    },
}
