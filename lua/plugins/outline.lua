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
        "barreiroleo/hierarchy.nvim",
        cmd = "FunctionReferences",
        opts = {}
    },

    {
        "barreiroleo/callgraph.nvim",
        lazy = true,
        dev = true,
        opts = {}
    },
}
