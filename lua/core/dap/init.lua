local dap, dapui = require('dap'), require("dapui")
require('nvim-dap-virtual-text').setup({})
require("core.dap.keymaps").setup_global_keymaps()
dapui.setup()

local function clean_and_open()
    dapui.open()
    require("core.dap.keymaps").setup_keymaps()
    -- require("gitsigns").toggle_signs(false)
    vim.diagnostic.hide(nil, 0)
    vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })
end

local function restore_and_close()
    vim.diagnostic.show()
    -- require("gitsigns").toggle_signs(true)
    require("core.dap.keymaps").shutdown_keymaps()
    dapui.close()
end

dap.listeners.before.attach.dapui_config = clean_and_open
dap.listeners.before.launch.dapui_config = clean_and_open
dap.listeners.after.terminate.dapui_config = restore_and_close
dap.listeners.after.disconnect.dapui_config = restore_and_close


local bashdb = require('core.dap.config.bashdb')
local codelldb = require("core.dap.config.codelldb")
local cppdbg = require("core.dap.config.cppdbg")
local gdb = require("core.dap.config.gdb")
local netcoredbg = require('core.dap.config.netcoredbg')
local nlua = require("core.dap.config.nlua")

local adapters = {
    bashdb.adapters,
    codelldb.adapters,
    cppdbg.adapters,
    gdb.adapters,
    netcoredbg.adapters,
    nlua.adapters,
}

for _, config in pairs(adapters) do
    dap.adapters = vim.tbl_extend("error", dap.adapters, config)
end

local c_cpp_rust = {}
vim.list_extend(c_cpp_rust, codelldb.configurations)
vim.list_extend(c_cpp_rust, cppdbg.configurations)
-- vim.list_extend(c_cpp_rust, gdb.configurations)

dap.configurations = {
    c = c_cpp_rust,
    cpp = c_cpp_rust,
    rust = c_cpp_rust,
    lua = nlua.configurations,
    bash = bashdb.configurations,
    cs = netcoredbg.configurations,
}
