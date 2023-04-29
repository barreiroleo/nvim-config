return {
    { 'nvim-neo-tree/neo-tree.nvim',
        branch = 'main',
        event = "VeryLazy",
        dependencies = {
            'nvim-lua/plenary.nvim',
            'kyazdani42/nvim-web-devicons',
            'MunifTanjim/nui.nvim',
        },
        cmd = 'Neotree',
        keys = {
            { '<leader>e', "<cmd>lua require('neo-tree.command').execute { toggle = true, dir = vim.loop.cwd() }<CR>",
                desc = 'Explorer NeoTree (cwd)',
            },
        },
        opts = require 'plugins.neotree.opts',
        init = function()
            vim.g.neo_tree_remove_legacy_commands = true
            -- vim.g.loaded_netrw = 1
            vim.g.loaded_netrwPlugin = 1
        end,
        deactivate = function() vim.cmd [[Neotree close]] end,
    }
}
