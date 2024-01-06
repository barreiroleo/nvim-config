-- Use dap adapter names, not mason.nvim package names.
-- See the keys in require("mason-nvim-dap.mappings.source")

return{
    'bash_',
    'coreclr',             -- netcoredbg
    'cppdbg', 'codelldb',  -- Cpptool, codelldb
    'javadbg', 'javatest', -- Java
    'node2', 'js', 'chrome', 'firefox',
    'python',              --debugpy
}
