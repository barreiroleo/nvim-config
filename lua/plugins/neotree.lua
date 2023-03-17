local opts = require("plugins.neotree.opts")

return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "main",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "kyazdani42/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
    cmd = "Neotree",

    init = function()
        vim.g.neo_tree_remove_legacy_commands = true
        require("neo-tree")
    end,

    deactivate = function()
        vim.cmd([[Neotree close]])
    end,

    opts = opts,

    keys = {
        { "<leader>e", function() require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() }) end, desc = "Explorer NeoTree (cwd)" },
    },

}
