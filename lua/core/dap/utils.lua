local api = vim.api
local keymap_restore = {}

local M = {}
function M.keymaps_setup()
    for _, buf in pairs(api.nvim_list_bufs()) do
        local keymaps = api.nvim_buf_get_keymap(buf, 'n')
        for _, keymap in pairs(keymaps) do
            ---@diagnostic disable-next-line: undefined-field
            if keymap.lhs == "K" then
                table.insert(keymap_restore, keymap)
                api.nvim_buf_del_keymap(buf, 'n', 'K')
            end
        end
    end
    api.nvim_set_keymap(
        'n', 'K', '<Cmd>lua require("dap.ui.widgets").hover()<CR>', { silent = true })
end

function M.keymaps_shutdown()
    for _, keymap in pairs(keymap_restore) do
        api.nvim_buf_set_keymap(
            keymap.buffer,
            keymap.mode,
            keymap.lhs,
            keymap.rhs,
            { silent = keymap.silent == 1 }
        )
    end
    keymap_restore = {}
end

--- Open a user input to indicate the full path executable to debug.
function M.input_executable()
    return vim.fn.input('Ctrl-D: List matches\nCtrl-A: Complete\n Path to executable: ',
        vim.fn.getcwd() .. "/build/", 'file')
end

return M
