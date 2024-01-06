local map = require("core.utils").map

local M = {}

local keymaps_backup = {}

---@class Mapping
---@field mode string The mode in which the key mapping should work
---@field key string The key combination that triggers the action
---@field action string The code that should be executed when the key combination is triggered
---@field opts table A table that include metadata about the key mapping, such as a description

local breakpoint_kinds = {
    ["toggle"] = ":lua require('dap').toggle_breakpoint()<CR>",
    ["condition"] = ":lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
    ["log"]   = ":lua require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>"
}

---Keymaps for global use
---@type Mapping
local keymaps_global = {
    { 'n', "<F8>",         breakpoint_kinds["toggle"],                    { desc = "DAP: Breakpoint toggle" } },
    { 'n', "<S-F8>",       breakpoint_kinds["condition"],                 { desc = "DAP: Breakpoint condition" } },
    { 'n', "<leader><F8>", breakpoint_kinds["log"],                       { desc = "DAP: Breakpoint log" } },

    { 'n', "<F5>",         ":lua require('dap').continue()<CR>",          { desc = "DAP: Start" } },
    -- { 'n', '<F5>',         ":lua require'osv'.run_this()<CR>",            { desc = "DAP: (vimkind) debug this file" } },
    -- { 'n', '<S-F5>',       ":lua require'osv'.launch({port = 8086})<CR>", { desc = "DAP: (vimkind) launch server, attach from another nvim" } },
}

---Keymaps for the buffer when debug session is started
---@type Mapping
local keymaps_debug = {
    -- TODO: Replace <leader> with real key
    { 'n', "<F5>",  ":lua require'dap'.continue()<CR>",                                    { desc = "DAP: Continue" } },
    { "n", "db",    ":lua require'dap'.step_back()<CR>",                                   { desc = "DAP: Step Back" } },
    { 'n', "<F11>", ":lua require'dap'.step_into()<CR>",                                   { desc = "DAP: Step Into" } },
    { 'n', "<F10>", ":lua require'dap'.step_over()<CR>",                                   { desc = "DAP: Step Over" } },
    { 'n', "<F12>", ":lua require'dap'.step_out()<CR>",                                    { desc = "DAP: Step Out" } },
    { "n", "dR",    ":lua require'dap'.run_to_cursor()<CR>",                               { desc = "DAP: Run to Cursor" } },
    { "n", "dp",    ":lua require'dap'.pause.toggle()<CR>",                                { desc = "DAP: Pause" } },
    { "n", "dq",    ":lua require'dap'.close()<CR>",                                       { desc = "DAP: Quit" } },

    { "n", "dC",    ":lua require'dap'.set_breakpoint(vim.fn.input '[Condition] > ')<CR>", { desc = "DAP: Conditional Breakpoint" } },
    { "n", "dt",    ":lua require'dap'.toggle_breakpoint()<CR>",                           { desc = "DAP: Toggle Breakpoint" } },

    { "n",          "dE",    ":lua require'dapui'.eval(vim.fn.input '[Expression] > ')<CR>", { desc = "DAP: Evaluate Input" } },
    { { "n", "v" }, "de",    ":lua require'dapui'.eval()<CR>",                             { desc = "DAP: Evaluate" } },
    { "n",          "dr",    ":lua require'dap'.repl.toggle()<CR>",                        { desc = "DAP: Toggle Repl" } },

    { "n", "dU",    ":lua require'dapui'.toggle()<CR>",                                    { desc = "DAP: Toggle UI" } },
    { "n", "dd",    ":lua require'dap'.disconnect()<CR>",                                  { desc = "DAP: Disconnect" } },
    { "n", "dg",    ":lua require'dap'.session()<CR>",                                     { desc = "DAP: Get Session" } },
    { "n", "dh",    ":lua require'dap.ui.widgets'.hover()<CR>",                            { desc = "DAP: Hover Variables" } },
    { "n", "dS",    ":lua require'dap.ui.widgets'.scopes()<CR>",                           { desc = "DAP: Scopes" } },
    { "n", "dx",    ":lua require'dap'.terminate()<CR>",                                   { desc = "DAP: Terminate" } },
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


---@param keymaps Mapping[]
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
