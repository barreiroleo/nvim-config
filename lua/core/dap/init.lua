local dap = require('dap')

local keymaps = require("core.dap.keymaps")

local bashdb = require('core.dap.config.bashdb')
local codelldb = require("core.dap.config.codelldb")
local cppdbg = require("core.dap.config.cppdbg")
local nlua = require("core.dap.config.nlua")
local python = require('core.dap.config.python')

require('nvim-dap-virtual-text').setup()
require('dapui').setup()

keymaps.setup()
dap.listeners.after.event_initialized['keymaps'] = keymaps.set_debug_keymaps
dap.listeners.after.event_terminated['keymaps'] = keymaps.restore_global_keymaps

dap.listeners.after.event_initialized['dapui_config'] = function() require("dapui").open() end
dap.listeners.before.event_terminated['dapui_config'] = function() require("dapui").close() end
dap.listeners.before.event_exited['dapui_config'] = function() require("dapui").close() end


local adapters = {
    bashdb.adapters,
    codelldb.adapters,
    cppdbg.adapters,
    nlua.adapters,
    python.adapters
}

for _, config in pairs(adapters) do
    dap.adapters = vim.tbl_extend("error", dap.adapters, config)
end

-- FIX: tbl_extend doesn't work properly
local codelldb_cppdbg = {}
codelldb_cppdbg = vim.list_extend(codelldb_cppdbg, codelldb.configurations)
codelldb_cppdbg = vim.list_extend(codelldb_cppdbg, cppdbg.configurations)
dap.configurations = {
    bash = bashdb.configurations,
    cpp = codelldb_cppdbg,
    c = codelldb_cppdbg,
    rust = codelldb_cppdbg,
    lua = nlua.configurations,
    python = python.configurations,
}
