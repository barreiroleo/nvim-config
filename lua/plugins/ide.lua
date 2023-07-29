return {
    -- Debugger
    { "mfussenegger/nvim-dap",
        event = { "BufNewFile", "BufReadPre" },
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
        event = { "BufNewFile", "BufReadPre" },
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

    -- TaskRunner
    { "stevearc/overseer.nvim",
        opts = {
            task_lists = { direction = "right" },
            templates = { "builtin", "user.cpp_build", "user.run_script" }
        }
    },

    -- Make
    { "tpope/vim-dispatch",
        cmd = { "Dispatch", "Make" }
    },

    -- Testing
    { "nvim-neotest/neotest",
        event = { "BufNewFile", "BufReadPre" },
        ft = {"cpp", "c", "h", "hpp", "python", "vim", "lua" },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "antoinemadec/FixCursorHold.nvim",
            { "nvim-neotest/neotest-plenary",
                "nvim-neotest/neotest-vim-test",
                dependencies = "vim-test/vim-test"
            },
        },
        config = function()
            require("neotest").setup {
                adapters = {
                    require("neotest-plenary"),
                    require("neotest-vim-test") {
                        allow_file_types = { 'cpp' },
                    },
                },
            }
        end
    },

    -- Databases
    { "tpope/vim-dadbod",
        dependencies = {
            "kristijanhusak/vim-dadbod-ui",
            "kristijanhusak/vim-dadbod-completion",
            "hrsh7th/nvim-cmp",
        },
        cmd = { "DB", "DBUI", "DBUIFindBuffer" },
        config = function ()
            vim.api.nvim_create_autocmd("FileType", {
                pattern = { "sql", "mysql", "plsql" },
                callback = function()
                    require('cmp').setup.buffer({ sources = { { name = 'vim-dadbod-completion' } } })
                end,
            })
        end
    },

    -- Docs generation
    { "danymat/neogen",
        event = { "BufNewFile", "BufReadPre" },
        dependencies = "nvim-treesitter/nvim-treesitter",
        keys = {
            { "<leader>dg", ":lua require('neogen').generate()<CR>", mode = { "n", "v" }, desc = "Neogen: Generate docs" }
        },
        opts = { snippet_engine = "luasnip" }
    }
}
