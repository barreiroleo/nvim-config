local renderers = require("plugins.neotree.opts")

return {
    { "nvim-neo-tree/neo-tree.nvim",
        branch = "main",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "kyazdani42/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
        -- opts = opts,
        config = function()
            vim.g.neo_tree_remove_legacy_commands = true
            require("neo-tree").setup(opts)
        end
    }
}
