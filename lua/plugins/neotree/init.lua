return {
    { 'nvim-neo-tree/neo-tree.nvim',
        branch = 'main',
        lazy = false,
        event = "VeryLazy",
        dependencies = {
            'nvim-lua/plenary.nvim',
            'kyazdani42/nvim-web-devicons',
            'MunifTanjim/nui.nvim',
            { 's1n7ax/nvim-window-picker',
                opts = { selection_chars = 'qel123', }
            }
        },
        cmd = 'Neotree',
        keys = {
            { '<leader>e', "<cmd>lua require('neo-tree.command').execute { toggle = true, dir = vim.uv.cwd() }<CR>",
                desc = 'Explorer NeoTree (cwd)',
            },
        },
        opts = require 'plugins.neotree.opts',
        init = function()
            vim.g.neo_tree_remove_legacy_commands = true
        end,
        deactivate = function() vim.cmd [[Neotree close]] end,
    }
}
