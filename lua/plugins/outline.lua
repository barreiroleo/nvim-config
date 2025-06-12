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
        opts = {
            run = {
                direction = "out",
                depth_limit_in = 10,
                depth_limit_out = 3,
                filter_location = { "/usr/include/c", "/usr/include/c++" },
                -- filter_location = function(uri)
                --     for _, filter in ipairs({ "/usr/include/c", "/usr/include/c++" }) do
                --         if uri:find(filter or "", 1, true) then
                --             vim.notify("Filtered out call to " .. uri, vim.log.levels.TRACE)
                --             return true
                --         end
                --     end
                --     return false
                -- end,
                root_location = vim.uri_from_fname(vim.fn.getcwd()),
            },
            export = {
                file_path = vim.fs.normalize("/tmp/callgraph.dot"),
                graph_name = "CallGraph",
                direction = "LR", -- TB, LR, BT, RL
            }
        },
        keys = {
            { '<leader>ci', function() require("callgraph").run({ direction = "in" }) end,  desc = 'Callgraph: incoming calls' },
            { '<leader>co', function() require("callgraph").run({ direction = "out" }) end, desc = 'Callgraph: outgoing calls' },
            { '<leader>cm', function() require("callgraph").run({ direction = "mix" }) end, desc = 'Callgraph: incoming/outgoing calls' },
        },
    },
}
