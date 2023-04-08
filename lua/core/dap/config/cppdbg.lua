local M = {}

M.adapters = {
    ["cppdbg"] = {
        id = 'cppdbg',
        type = 'executable',
        command = vim.fn.stdpath("data") .. "/mason/bin/OpenDebugAD7",
    },
}

M.configurations = {
    { name = '(cppdbg) Launch file',
        type = 'cppdbg',     -- Adapt to the adapter name ("dap.adapters.<name>")
        request = 'launch',
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/build/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopAtEntry = true,
        runInTerminal = true,
    },

    { name = '(cppdbg) Attach to gdbserver :1234',
        type = 'cppdbg', -- Adapt to the adapter name ("dap.adapters.<name>")
        request = 'launch',
        MIMode = 'gdb',
        miDebuggerServerAddress = 'localhost:1234',
        miDebuggerPath = '/usr/bin/gdb',
        cwd = '${workspaceFolder}',
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/build/', 'file')
        end,
    },
}

return M
