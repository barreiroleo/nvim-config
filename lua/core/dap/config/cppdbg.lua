local M = {}

M.adapters = {
    ["cppdbg"] = {
        id = 'cppdbg',
        type = 'executable',
        command = vim.fn.stdpath("data") .. "/mason/bin/OpenDebugAD7",
    },
}

local common = {
    setupCommands = {
        {
            description = "Enable pretty-printing for gdb",
            text = "-enable-pretty-printing",
            ignoreFailures = true
        },
        {
            description = "ignore SIGUSR1 signal",
            text = "handle SIGUSR1 nostop noprint pass"
        },
    }
}

M.configurations = {
    {
        name = '[cppdbg] Launch file',
        type = 'cppdbg',
        request = 'launch',
        cwd = '${workspaceFolder}',
        stopAtEntry = true,
        setupCommands = common.setupCommands,
        program = require("core.dap.utils").input_executable,
    },

    {
        name = '[cppdbg] Attach to PID',
        type = 'cppdbg',
        request = 'attach',
        cwd = '${workspaceFolder}',
        stopAtEntry = true,
        setupCommands = common.setupCommands,
        pid = require("dap.utils").pick_process_by_name
    },
}

return M
