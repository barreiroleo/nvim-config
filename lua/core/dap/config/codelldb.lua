local M = {}

M.adapters = {
    ["codelldb"] = {
        type = 'server',
        port = "${port}",
        executable = {
            command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
            args = { "--port", "${port}" },
            -- On windows you may have to uncomment this:
            -- detached = false,
        }
    }
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
        name = '[codelldb] Launch file',
        type = 'codelldb',
        request = 'launch',
        cwd = '${workspaceFolder}',
        stopAtEntry = true,
        setupCommands = common.setupCommands,
        program = require("core.dap.utils").input_executable,
    },

    {
        name = '[codelldb] Attach to PID',
        type = 'codelldb',
        request = 'attach',
        cwd = '${workspaceFolder}',
        stopAtEntry = true,
        setupCommands = common.setupCommands,
        pid = require("dap.utils").pick_process_by_name
    },
}

return M
