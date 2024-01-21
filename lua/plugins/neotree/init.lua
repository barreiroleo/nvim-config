---@class table<win_num, cur_pos>>
---@field win integer
---@field cursor table<integer, integer>
local prev_pos = {}

local function ToggleFocus()
    local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())
    if not string.find(bufname, "neo-tree ", nil, true) then
        prev_pos = { win = vim.api.nvim_get_current_win(), cursor = vim.api.nvim_win_get_cursor(0) }
        -- P({ "Saving pos: ", vim.api.nvim_win_get_number(prev_pos.win), prev_pos.cursor })
        require("neo-tree.command").execute({ dir = vim.uv.cwd() })
    else
        -- P({ "Going pos: ", vim.api.nvim_win_get_number(prev_pos.win), prev_pos.cursor })
        vim.api.nvim_set_current_win(prev_pos.win)
        vim.api.nvim_win_set_cursor(prev_pos.win, prev_pos.cursor)
    end
end

return {
    { 'nvim-neo-tree/neo-tree.nvim',
        branch = 'main',
        lazy = false,
        event = "VeryLazy",
        dependencies = {
            'nvim-lua/plenary.nvim',
            'kyazdani42/nvim-web-devicons',
            'MunifTanjim/nui.nvim',
            { 's1n7ax/nvim-window-picker',
                opts = { selection_chars = 'qel123', }
            }
        },
        cmd = 'Neotree',
        keys = {
            { '<leader>e', ToggleFocus, desc = 'Explorer NeoTree (cwd)', },
        },
        opts = require 'plugins.neotree.opts',
        init = function()
            vim.g.neo_tree_remove_legacy_commands = true
        end,
        deactivate = function() vim.cmd [[Neotree close]] end,
    }
}
