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
            callback = function(event_data)
                local data = require("core.utils.lsp_progress").get_last_msg_for_client(event_data)
                if not data then return end

                vim.notify(data.message, vim.log.levels.INFO, {
                    id = "lsp_progress",
                    title = data.title,
                    opts = function(notif) notif.icon = data.spinner end,
                })
            end,
        })
    end,

    opts = {
        styles = {
            zen = { width = 150 }
        },
        bigfile = { enabled = true },
        indent = {
            enabled = true,
            indent = { char = '┆' },
            animate = { enabled = false },
        },
        notifier = {
            enabled = true,
            top_down = false
        },
        picker = {
            enabled = true,
            sources = {
                explorer = {
                    layout = {
                        layout = { position = "left" },
                        preview = { main = true, enabled = false }
                    }
                }
            }
        },
        statuscolumn = { enabled = true },
        words = { enabled = true },
        terminal = { enabled = true },
        zen = {
            enabled = true,
            win = { style = "zen" }
        }
    },

    keys = {
        { "<leader><leader>s", function() Snacks.scratch() end,               desc = "Snacks(scratch): Toggle Scratch Buffer" },
        { "<leader><leader>S", function() Snacks.scratch.select() end,        desc = "Snacks(scratch): Select Scratch Buffer" },
        { "<leader><leader>t", function() Snacks.terminal.toggle() end,       desc = "Snacks(terminal): Toggle terminal" },
        { "<leader>m",         function() Snacks.notifier.show_history() end, desc = "Snacks(notifier): Open messages history" },
        { "<leader>z",         function() Snacks.zen.zen() end,               desc = "Snacks(zen): Toogle Zen mode" },

        { "<leader>ff",        function() Snacks.picker.files() end,          desc = "Snacks(picker): Find file or path" },
        { "<leader>fg",        function() Snacks.picker.grep() end,           desc = "Snacks(picker): Find content. Usage: SearchThing--*.ft" },
        { "<leader>fb",        function() Snacks.picker.buffers() end,        desc = "Snacks(picker): Find buffer" },
        { "<leader>fh",        function() Snacks.picker.help() end,           desc = "Snacks(picker): Find help tag (vimdoc)" },
        { "<leader>f/",        function() Snacks.picker.grep_buffers() end,   desc = "Snacks(picker): Find in open buffers" },
        { "<leader>/",         function() Snacks.picker.lines() end,          desc = "Snacks(picker): Find in current buffer" },
        { "<leader>fm",        function() Snacks.picker.man() end,            desc = "Snacks(picker): Find in manpages" },
        { "<leader>fvk",       function() Snacks.picker.keymaps() end,        desc = "Snacks(picker): Find keymap" },

        {
            "<leader>e",
            function()
                local explorer_picker = Snacks.picker.get({ source = "explorer" })[1]
                if not explorer_picker then
                    Snacks.picker.explorer()
                    return
                elseif explorer_picker:is_focused() then
                    explorer_picker:close()
                else
                    explorer_picker:focus()
                end
            end,
            desc = "Snacks(picker): Toggle explorer"
        },

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
