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
    -- { name = "[codelldb] Launch file",
    --     type = "codelldb",
    --     request = "launch",
    --     program = function()
    --         return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/build/', 'file')
    --     end,
    --     cwd = '${workspaceFolder}',
    --     stopOnEntry = false,
    -- },

    {
        name = '[codelldb] Launch file',
        type = 'codelldb', -- Adapt to the adapter name ("dap.adapters.<name>")
        request = 'launch',
        cwd = '${workspaceFolder}',
        stopAtEntry = true,
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
        },

        program = function()
            return vim.fn.input('Ctrl-D: List matches\nCtrl-A: Complete\n Path to executable: ',
                vim.fn.getcwd() .. '/build/', 'file')
        end,
    },

    {
        name = '[codelldb] Attach to PID',
        type = 'codelldb', -- Adapt to the adapter name ("dap.adapters.<name>")
        request = 'attach',
        cwd = '${workspaceFolder}',
        stopAtEntry = true,
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
        },

        program = function()
            vim.ui.input({
                prompt = 'Ctrl-D: List matches\nCtrl-A: Complete\n Path to executable: ',
                default = vim.fn.getcwd() .. "/build/",
                completion = "file"
            }, function(input) _tmp_filename = { full = input, short = vim.fn.fnamemodify(input, ":t") } end)
            return _tmp_filename.full
        end,

        processId = function()
            local obj = vim.system({ 'pgrep', _tmp_filename.short }, { text = true }):wait()
            if obj.code == 0 then
                local numbers = {}
                for number in obj.stdout:gmatch("(%d+)") do
                    table.insert(numbers, tonumber(number))
                end

                local choice = nil
                vim.ui.select(numbers, {
                    prompt = 'Found instances ID: ',
                    format_item = function(item) return "PID " .. item end,
                }, function(idx) choice = idx end)
                return choice
            end
            return vim.fn.input('No PID. Input PID: ')
        end,
    },
}

return M
