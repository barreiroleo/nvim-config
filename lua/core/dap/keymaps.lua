local map = require("core.utils").map

local M = {}

local keymaps_backup = {}

---@class Mapping

---Keymaps for global use
---@type Mapping
local keymaps_global = {
    { 'n', "<F9>",  function() require('dap').toggle_breakpoint() end, { desc = "DAP: Breakpoint toggle" } },

    { 'n', "<F5>",  function() require 'dap'.continue() end,           { desc = "DAP: Continue" } },
    { 'n', "<F11>", function() require 'dap'.step_into() end,          { desc = "DAP: Step Into" } },
    { 'n', "<F10>", function() require 'dap'.step_over() end,          { desc = "DAP: Step Over" } },
    { 'n', "<F12>", function() require 'dap'.step_out() end,           { desc = "DAP: Step Out" } },
    -- { 'n', '<F5>',   function() require 'osv'.run_this() end,              { desc = "DAP: (vimkind) debug this file" } },
    -- { 'n', '<S-F5>', function() require 'osv'.launch({ port = 8086 }) end, { desc = "DAP: (vimkind) launch server, attach from another nvim" } },
}

---Keymaps for the buffer when debug session is started
---@type Mapping
local keymaps_debug = {
    -- TODO: Replace <leader> with real key
    { "n",          ",dC",  function() require 'dap'.set_breakpoint(vim.fn.input '[Condition] > ') end,                 { desc = "DAP: Conditional Breakpoint" } },
    { 'n',          ",dLC", function() require 'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end, { desc = "DAP: Breakpoint log" } },
    { "n",          ",dt",  function() require 'dap'.toggle_breakpoint() end,                                           { desc = "DAP: Toggle Breakpoint" } },

    { "n",          ",db",  function() require 'dap'.step_back() end,                                                   { desc = "DAP: Step Back" } },
    { "n",          ",dR",  function() require 'dap'.run_to_cursor() end,                                               { desc = "DAP: Run to Cursor" } },
    { "n",          ",dp",  function() require 'dap'.pause.toggle() end,                                                { desc = "DAP: Pause" } },

    { "n",          ",dq",  function() require 'dap'.close() end,                                                       { desc = "DAP: Quit" } },
    { "n",          ",dr",  function() require 'dap'.repl.toggle() end,                                                 { desc = "DAP: Toggle Repl" } },
    { "n",          ",dE",  function() require 'dapui'.eval(vim.fn.input '[Expression] > ') end,                        { desc = "DAP: Evaluate Input" } },
    { { "n", "v" }, ",de",  function() require 'dapui'.eval() end,                                                      { desc = "DAP: Evaluate" } },
    { "n",          ",dU",  function() require 'dapui'.toggle() end,                                                    { desc = "DAP: Toggle UI" } },

    { "n",          ",dd",  function() require 'dap'.disconnect() end,                                                  { desc = "DAP: Disconnect" } },
    { "n",          ",dg",  function() require 'dap'.session() end,                                                     { desc = "DAP: Get Session" } },
    { "n",          ",dx",  function() require 'dap'.terminate() end,                                                   { desc = "DAP: Terminate" } },
    { "n",          ",dh",  function() require 'dap.ui.widgets'.hover() end,                                            { desc = "DAP: Hover Variables" } },
    { "n",          ",dS",  function() require 'dap.ui.widgets'.scopes() end,                                           { desc = "DAP: Scopes" } },
}

---Backup the exististing keymaps before replace it
---@param keymaps Mapping[]
M.backup_keymaps = function(keymaps)
    local keys = vim.tbl_map(function(keymap) return keymap[2] end, keymaps)
    local buf_keymaps = vim.api.nvim_buf_get_keymap(0, 'n')
    keymaps_backup = vim.tbl_filter(function(keymap) return vim.tbl_contains(keys, keymap.lhs) end, buf_keymaps)
    vim.tbl_map(function(keymap) vim.api.nvim_buf_del_keymap(0, "n", keymap.lhs) end, keymaps_backup)
end

---@param keymaps Mapping[]
M.set_keymaps = function(keymaps)
    vim.tbl_map(function(keymap) map(keymap[1], keymap[2], keymap[3], keymap[4]) end, keymaps)
end


M.set_debug_keymaps = function()
    M.backup_keymaps(keymaps_debug)
    M.set_keymaps(keymaps_debug)
end

M.restore_global_keymaps = function()
    vim.tbl_map(function(keymap)
        vim.api.nvim_buf_set_keymap(keymap.buffer, keymap.mode, keymap.lhs, keymap.rhs, { silent = keymap.silent == 1 })
    end, keymaps_backup)
    keymaps_backup = {}
end

M.setup = function ()
    M.set_keymaps(keymaps_global)
end

---@type Mapping
-- local keymaps_debug = {
--     { "n", "gd",  ":= P('DAP: gd)",  { desc = "DAP: LSP gsi oveeride keymap" } },
--     { "n", "gsi", ":= P('DAP: gsi)", { desc = "DAP: LSP gsi oveeride keymap" } }
-- }
-- set_keymaps(keymaps_global)
-- M.set_debug_keymaps(test_keymap_debug)
-- P(keymaps_backup)
-- M.restore_global_keymaps()
-- P(keymaps_backup)

return M
