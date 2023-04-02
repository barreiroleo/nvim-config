local map = require("core.utils").map

return {
    { "ThePrimeagen/refactoring.nvim",
        dependencies = {
            { "nvim-lua/plenary.nvim" },
            { "nvim-treesitter/nvim-treesitter" }
        },
        config = function()
            local refactor = require("refactoring")
            refactor.setup({
                prompt_func_return_type = { cpp = true, c = true }, -- prompt for return type
                prompt_func_param_type = { cpp = true, c = true },  -- prompt for function parameters
            })
            -- Remaps for the refactoring operations currently offered by the plugin
            map("v", "<leader>re", function() refactor.refactor('Extract Function') end, { desc = "" })
            map("v", "<leader>rf", function() refactor.refactor('Extract Function To File') end, { desc = "" })
            map("v", "<leader>rv", function() refactor.refactor('Extract Variable') end, { desc = "" })
            map("v", "<leader>ri", function() refactor.refactor('Inline Variable') end, { desc = "" })

            -- Extract block doesn't need visual mode
            map("n", "<leader>rb", function() refactor.refactor('Extract Block') end, { desc = "" })
            map("n", "<leader>rbf", function() refactor.refactor('Extract Block To File') end, { desc = "" })

            -- Inline variable can also pick up the identifier currently under the cursor without visual mode
            map("n", "<leader>ri", function() refactor.refactor('Inline Variable') end, { desc = "" })
            -- prompt for a refactor to apply when the remap is triggered
            map("v", "<leader>rr", function() refactor.select_refactor() end, { desc = "" })
        end
    },
}
