local map = require("core.utils").map

return {
    -- Debugger
    { "mfussenegger/nvim-dap",
        dependencies = {
            { "jay-babu/mason-nvim-dap.nvim" },
            { "rcarriga/nvim-dap-ui" },
            { "theHamsta/nvim-dap-virtual-text" },
            { "jbyuki/one-small-step-for-vimkind" },
        },
        config = function () require("core.dap") end
    },

    -- Refactoring
    { "ThePrimeagen/refactoring.nvim",
        event = "VeryLazy",
        dependencies = {
            { "nvim-lua/plenary.nvim" },
            { "nvim-treesitter/nvim-treesitter" }
        },
        keys = {
            { "<leader>rr", "<cmd>lua require('refactoring').select_refactor()<CR>", mode = { "n", "v" }, desc = "Refactoring: Select refactor" },
        },
        opts = {
            prompt_func_return_type = { cpp = true, c = true },     -- prompt for return type
            prompt_func_param_type = { cpp = true, c = true },      -- prompt for function parameters
        }
    },

    -- Testing
    { "nvim-neotest/neotest",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "antoinemadec/FixCursorHold.nvim",
            { "nvim-neotest/neotest-vim-test",
                dependencies = "vim-test/vim-test"
            }
        },
        config = function()
            require('neotest').setup {
                adapters = {
                    require 'neotest-vim-test' {
                        allow_file_types = { 'cpp' }
                    },
                },
            }
        end
    },

    -- Databases
    { "tpope/vim-dadbod",
        dependencies = { "kristijanhusak/vim-dadbod-ui" }
    },

    -- Docs generation
    { "danymat/neogen",
        dependencies = "nvim-treesitter/nvim-treesitter",
        config = function()
            require("neogen").setup({ snippet_engine = "luasnip" })
            map("n", "<leader>dg", ":lua require('neogen').generate()<CR>", { desc = "Neogen: Generate docs" })
        end
    }
}
