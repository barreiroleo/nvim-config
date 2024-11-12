local dap = require("dap")

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
