local get_target_path = function()
    local path = vim.fs.dirname(vim.api.nvim_buf_get_name(0))
    vim.ui.input({ prompt = "Search in folder: ", default = path }, function(input)
        if input == "" then input = "." end
        path = input
    end)
    return path
end

return {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },

    config = function()
        local actions = require("fzf-lua.actions")
        require("fzf-lua").setup({
            winopts = { preview = { layout = { "horizontal" } } },
            grep = {
                actions = {
                    ["ctrl-q"] = { fn = actions.file_edit_or_qf, prefix = "select-all+" }
                }
            }
        })
    end,

    keys = {
        { "<leader>ff",  function() require('fzf-lua').files() end,          desc = "Fzf: Find by file name" },
        { "<leader>fg",  function() require('fzf-lua').live_grep_glob() end, desc = "Fzf: Find by grep. Usage: SearchThing--*.ft" },
        { "<leader>fb",  function() require('fzf-lua').buffers() end,        desc = "Fzf: Find buffer" },
        { "<leader>fh",  function() require('fzf-lua').helptags() end,       desc = "Fzf: Find help tag (vimdoc)" },
        { "<leader>/",   function() require('fzf-lua').grep_curbuf() end,    desc = "Fzf: Find in current buffer by grep" },
        { "<leader>fm",  function() require('fzf-lua').manpages() end,       desc = "Fzf: Find in manpages" },
        { "<leader>fvk", function() require('fzf-lua').keymaps() end,        desc = "Fzf: Find keymap" },
        {
            "<leader>cfg",
            function() require("fzf-lua").live_grep_glob({ cwd = get_target_path() }) end,
            desc = "Fzf: Current folder, find grep"
        },
        {
            "<leader>cff",
            function() require("fzf-lua").files({ cwd = get_target_path() }) end,
            desc = "Fzf: Current folder, find files"
        },
    },
}
