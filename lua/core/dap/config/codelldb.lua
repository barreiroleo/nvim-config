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

M.configurations = {
    { name = "(codelldb) Launch file",
        type = "codelldb",
        request = "launch",
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/build/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
    },
}

return M
