local M = {}


M.adapters = {
    ["cppdbg"] = {
        id = 'cppdbg',
        type = 'executable',
        command = vim.fn.stdpath("data") .. "/mason/bin/OpenDebugAD7",
    },
}

local _tmp_filename = {}
M.configurations = {
    {
        name = '[cppdbg] Launch file',
        type = 'cppdbg', -- Adapt to the adapter name ("dap.adapters.<name>")
        request = 'launch',
        cwd = '${workspaceFolder}',
        stopAtEntry = true,
        setupCommands = {
            {
                text = '-enable-pretty-printing',
                description = 'enable pretty printing',
                ignoreFailures = false
            },
        },

        program = function()
            return vim.fn.input('Ctrl-D: List matches\nCtrl-A: Complete\n Path to executable: ',
                vim.fn.getcwd() .. '/build/', 'file')
        end,
    },

    {
        name = '[cppdbg] Attach to PID',
        type = 'cppdbg', -- Adapt to the adapter name ("dap.adapters.<name>")
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

    -- FIX: Telescoper executable picker
    -- local pickers = require("telescope.pickers")
    -- local finders = require("telescope.finders")
    -- local conf = require("telescope.config").values
    -- local actions = require("telescope.actions")
    -- local action_state = require("telescope.actions.state")
    -- {
    --     name = "Launch an executable",
    --     type = "cppdbg",
    --     request = "launch",
    --     cwd = "${workspaceFolder}",
    --     program = function()
    --         return coroutine.create(function(coro)
    --             local opts = {}
    --             pickers.new(opts, {
    --                 prompt_title = "Path to executable",
    --                 finder = finders.new_oneshot_job({ "fd", "--hidden", "--no-ignore", "--type", "x" }, {}),
    --                 sorter = conf.generic_sorter(opts),
    --                 attach_mappings = function(buffer_number)
    --                     actions.select_default:replace(function()
    --                         actions.close(buffer_number)
    --                         coroutine.resume(coro, action_state.get_selected_entry()[1])
    --                     end)
    --                     return true
    --                 end,
    --             }):find()
    --         end)
    --     end,
    -- }
}

return M
