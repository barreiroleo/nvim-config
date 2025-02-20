---LSP Progress, replacing fidget
---@type table<number, {token:lsp.ProgressToken, msg:string, done:boolean}[]>
local progress = vim.defaulttable()

---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
local function lsp_progress_indicator(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    local value = ev.data.params
        .value --[[@as {percentage?: number, title?: string, message?: string, kind: "begin" | "report" | "end"}]]
    if not client or type(value) ~= "table" then
        return
    end
    local p = progress[client.id]

    for i = 1, #p + 1 do
        if i == #p + 1 or p[i].token == ev.data.params.token then
            p[i] = {
                token = ev.data.params.token,
                msg = ("[%3d%%] %s%s"):format(
                    value.kind == "end" and 100 or value.percentage or 100,
                    value.title or "",
                    value.message and (" **%s**"):format(value.message) or ""
                ),
                done = value.kind == "end",
            }
            break
        end
    end

    local msg = {} ---@type string[]
    progress[client.id] = vim.tbl_filter(function(v)
        return table.insert(msg, v.msg) or not v.done
    end, p)

    local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
    vim.notify(table.concat(msg, "\n"), "info", {
        id = "lsp_progress",
        title = client.name,
        opts = function(notif)
            notif.icon = #progress[client.id] == 0 and " "
                or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
        end,
    })
end

local function get_target_path()
    local path = vim.fs.dirname(vim.api.nvim_buf_get_name(0))
    vim.ui.input({ prompt = "Search in folder: ", default = path }, function(input)
        if input == "" then input = "." end
        path = input
    end)
    return path
end

return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,

    init = function()
        -- Replace print ui
        vim.api.nvim_create_autocmd("User", {
            pattern = "VeryLazy",
            callback = function()
                _G.P = function(...) Snacks.debug.inspect(...) end
                _G.BT = function() Snacks.debug.backtrace() end
                vim.print = _G.P
            end
        })

        ---Request LSP rename file method on file renaming from Mini
        vim.api.nvim_create_autocmd("User", {
            pattern = "MiniFilesActionRename",
            callback = function(event)
                ---@diagnostic disable-next-line: undefined-global
                Snacks.rename.on_rename_file(event.data.from, event.data.to)
            end,
        })

        ---LSP Progress, replacing fidget
        vim.api.nvim_create_autocmd("LspProgress", {
            callback = lsp_progress_indicator,
        })
    end,

    opts = {
        bigfile = { enabled = true },
        indent = {
            enabled = true,
            indent = { char = '┆' },
            animate = { enabled = false },
        },
        notifier = { enabled = true },
        picker = {
            enabled = true,
            sources = { explorer = { layout = { layout = { position = "right" } } } }
        },
        statuscolumn = { enabled = true },
        words = { enabled = true },
        terminal = { enabled = true },
    },

    keys = {
        { "<leader><leader>s", function() Snacks.scratch() end,               desc = "Snacks(scratch): Toggle Scratch Buffer" },
        { "<leader><leader>S", function() Snacks.scratch.select() end,        desc = "Snacks(scratch): Select Scratch Buffer" },
        { "<leader><leader>t", function() Snacks.terminal.toggle() end,       desc = "Snacks(terminal): Toggle terminal" },
        { "<leader>m",         function() Snacks.notifier.show_history() end, desc = "Snacks(notifier): Open messages history" },

        { "<leader>E",         function() Snacks.picker.explorer() end,       desc = "Snacks(picker): Toggle explorer" },
        { "<leader>ff",        function() Snacks.picker.files() end,          desc = "Snacks(picker): Find by file name" },
        { "<leader>fg",        function() Snacks.picker.grep() end,           desc = "Snacks(picker): Find by grep. Usage: SearchThing--*.ft" },
        { "<leader>fb",        function() Snacks.picker.buffers() end,        desc = "Snacks(picker): Find buffer" },
        { "<leader>fh",        function() Snacks.picker.help() end,           desc = "Snacks(picker): Find help tag (vimdoc)" },
        { "<leader>/",         function() Snacks.picker.grep_buffers() end,   desc = "Snacks(picker): Find in current buffer by grep" },
        { "<leader>fm",        function() Snacks.picker.man() end,            desc = "Snacks(picker): Find in manpages" },
        { "<leader>fvk",       function() Snacks.picker.keymaps() end,        desc = "Snacks(picker): Find keymap" },
        {
            "<leader>cfg",
            ---@diagnostic disable-next-line: missing-fields
            function() Snacks.picker.grep({ cwd = get_target_path() }) end,
            desc = "Picker: Current folder, find grep"
        },
        {
            "<leader>cff",
            ---@diagnostic disable-next-line: missing-fields
            function() Snacks.picker.files({ cwd = get_target_path() }) end,
            desc = "Picker: Current folder, find files"
        },
    }
}
