local bashdb = require('core.dap.config.bashdb')
local codelldb = require("core.dap.config.codelldb")
local cppdbg = require("core.dap.config.cppdbg")
local nlua = require("core.dap.config.nlua")
local python = require('core.dap.config.python')
local netcoredbg = require('core.dap.config.netcoredbg')

require('nvim-dap-virtual-text').setup()
require('dapui').setup()
local dap = require('dap')


local keymaps = require("core.dap.keymaps")
keymaps.setup()
dap.listeners.after.event_initialized['keymaps'] = keymaps.set_debug_keymaps
dap.listeners.after.event_terminated['keymaps'] = keymaps.restore_global_keymaps

local function clean_and_open()
    require("dapui").open()
    require("gitsigns").toggle_signs(false)
    vim.diagnostic.hide(nil, 0)
    vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })
end

local function restore_and_close()
    require("dapui").close()
    require("gitsigns").toggle_signs(true)
    vim.diagnostic.show()
end

dap.listeners.after.event_initialized['dapui_config'] = clean_and_open
dap.listeners.before.event_terminated['dapui_config'] = restore_and_close
dap.listeners.before.event_exited['dapui_config'] = restore_and_close

local adapters = {
    bashdb.adapters,
    codelldb.adapters,
    cppdbg.adapters,
    netcoredbg.adapters,
    nlua.adapters,
    python.adapters,
}

for _, config in pairs(adapters) do
    dap.adapters = vim.tbl_extend("error", dap.adapters, config)
end

local codelldb_cppdbg = vim.list_extend(codelldb.configurations, cppdbg.configurations)
dap.configurations = {
    bash = bashdb.configurations,
    c = codelldb_cppdbg,
    cpp = codelldb_cppdbg,
    cs = netcoredbg.configurations,
    lua = nlua.configurations,
    python = python.configurations,
    rust = codelldb_cppdbg,
}
