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
