local M = {}

-- local _key_example = { 1, {
--     abbr = 0, buffer = 1, callback = function() end, desc = "vim.lsp.buf.hover()", expr = 0,
--     lhs = "K", lhsraw = "K", lnum = 0, mode = "n", mode_bits = 1, noremap = 1, nowait = 0,
--     script = 0, scriptversion = 1, sid = -8, silent = 0
-- } }
---@type vim.api.keyset.keymap[]
local key_conflicts_map = {}

---@type vim.api.keyset.keymap[]
local debug_keymaps = {
    { "n",          ",dC",  function() require('dap').set_breakpoint(vim.fn.input '[Condition] > ') end,                 { desc = "DAP: Conditional Breakpoint" } },
    { 'n',          ",dLC", function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end, { desc = "DAP: Breakpoint log" } },
    { "n",          ",dt",  require('dap').toggle_breakpoint,                                                            { desc = "DAP: Toggle Breakpoint" } },

    { "n",          ",db",  require('dap').step_back,                                                                    { desc = "DAP: Step Back" } },
    { "n",          ",dR",  require('dap').run_to_cursor,                                                                { desc = "DAP: Run to Cursor" } },
    { "n",          ",dp",  require('dap').pause,                                                                        { desc = "DAP: Pause" } },

    { "n",          ",dq",  require('dap').close,                                                                        { desc = "DAP: Quit" } },
    { "n",          ",dr",  require('dap').repl.toggle,                                                                  { desc = "DAP: Toggle Repl" } },
    { "n",          ",dE",  function() require 'dapui'.eval(vim.fn.input '[Expression] > ') end,                         { desc = "DAP: Evaluate Input" } },
    -- TODO: support visual mode
    { { "n", "v" }, ",de",  require 'dapui'.eval,                                                                        { desc = "DAP: Evaluate" } },
    { "n",          ",dU",  require 'dapui'.toggle,                                                                      { desc = "DAP: Toggle UI" } },

    { "n",          ",dd",  require('dap').disconnect,                                                                   { desc = "DAP: Disconnect" } },
    { "n",          ",dg",  require('dap').session,                                                                      { desc = "DAP: Get Session" } },
    { "n",          ",dx",  require('dap').terminate,                                                                    { desc = "DAP: Terminate" } },
    { "n",          "K",    require('dap.ui.widgets').hover,                                                             { desc = "DAP: Hover Variables" } },
    { "n",          ",dS",  require('dap.ui.widgets').scopes,                                                            { desc = "DAP: Scopes" } },
}

function M.setup_global_keymaps()
    vim.keymap.set('n', "<F9>", require('dap').toggle_breakpoint, { desc = "DAP: Breakpoint toggle" })
    vim.keymap.set('n', "<F6>", require('dap').goto_, { desc = "DAP: Goto line" })
    vim.keymap.set('n', "<F5>", require('dap').continue, { desc = "DAP: Continue" })
    vim.keymap.set('n', "<F11>", require('dap').step_into, { desc = "DAP: Step Into" })
    vim.keymap.set('n', "<F10>", require('dap').step_over, { desc = "DAP: Step Over" })
    vim.keymap.set('n', "<F12>", require('dap').step_out, { desc = "DAP: Step Out" })
end

function M.setup_keymaps()
    for _, buf in pairs(vim.api.nvim_list_bufs()) do
        local buf_keymaps = vim.api.nvim_buf_get_keymap(buf, 'n')
        for _, dap_keymap in pairs(debug_keymaps) do
            for _, buf_keymap in pairs(buf_keymaps) do
                ---@diagnostic disable-next-line: undefined-field
                local lhs = buf_keymap.lhs
                if lhs and lhs == dap_keymap[2] then
                    table.insert(key_conflicts_map, buf_keymap)
                    vim.api.nvim_buf_del_keymap(buf, "n", lhs)
                    vim.keymap.set("n", lhs, dap_keymap[3], dap_keymap[4])
                end
            end
        end
    end
end

function M.shutdown_keymaps()
    for _, keymap in pairs(key_conflicts_map) do
        ---@diagnostic disable-next-line: undefined-field
        local rhs = keymap.rhs or keymap.callback
        assert(rhs, "keymap doesn't have a rhs or callback")
        ---@diagnostic disable-next-line: undefined-field
        vim.keymap.set(keymap.mode, keymap.lhs, rhs, { buffer = keymap.buffer, silent = keymap.silent == 1 })
    end
end

return M
