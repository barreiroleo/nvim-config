return {
    {
        'folke/trouble.nvim',
        cmd = "Trouble",
        opts = {},
    },

    {
        'hedyhli/outline.nvim',
        cmd = 'Outline',
        keys = {
            { '<leader>cs', function() require("outline").toggle() end, desc = 'Outline: Symbols LSP navigation' }
        },
        opts = {
            preview_window = { live = true },
        }
    },

    {
        'ldelossa/litee.nvim',
        opts = {
            notify = { enabled = false },
            panel = {
                orientation = "bottom",
                panel_size = 10,
            },
        },
        config = function(_, opts) require('litee.lib').setup(opts) end
    },

    {
        'ldelossa/litee-calltree.nvim',
        dependencies = 'ldelossa/litee.nvim',
        event = "LspAttach",
        opts = {
            on_open = "panel",
            map_resize_keys = false,
        },
        config = function(_, opts) require('litee.calltree').setup(opts) end,
    },
}
