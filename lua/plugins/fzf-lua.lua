return {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
    keys = {
        { "<leader>ff",  function() require('fzf-lua').files() end,            desc = "Fzf: Find by file name" },
        { "<leader>fg",  function() require('fzf-lua').live_grep_native() end, desc = "Fzf: Find by text" }, -- live_grep_resume
        { "<leader>fb",  function() require('fzf-lua').buffers() end,          desc = "Fzf: Find buffer" },
        { "<leader>fh",  function() require('fzf-lua').helptags() end,         desc = "Fzf: Find help tag (vimdoc)" },
        { "<leader>/",   function() require('fzf-lua').grep_curbuf() end,      desc = "Fzf: Find in current buffer" },
        { "<leader>fm",  function() require('fzf-lua').manpages() end,         desc = "Fzf: Find in manpages" },
        { "<leader>fvk", function() require('fzf-lua').keymaps() end,          desc = "Fzf: Find keymap" },
    },
}
