return {
    -- Plenary
    {
        "nvim-lua/plenary.nvim",
        keys = { { "<leader><leader>t", "<cmd>w<cr> | <Plug>PlenaryTestFile", desc = "Plenary: Test current file" } }
    },

    -- Debugger
    { "mfussenegger/nvim-dap",
        event = { "BufNewFile", "BufReadPre" },
        dependencies = {
            { "rcarriga/nvim-dap-ui",
                -- stylua: ignore
                keys = {
                    { "<leader>du", function() require("dapui").toggle({}) end,  desc = "Dap UI" },
                    { "<leader>de", function() require("dapui").eval() end, desc = "Eval", mode = { "n", "v" } },
                },
                dependencies = "nvim-neotest/nvim-nio"
            },
            { "jay-babu/mason-nvim-dap.nvim",
                cmd = { "DapInstall", "DapUninstall" }
            },
            { "theHamsta/nvim-dap-virtual-text",
                opts = {
                    enabled = true,
                    commented = true,
                    clear_on_continue = true,
                    virt_text_pos = "eol"
                }
            },
            { "jbyuki/one-small-step-for-vimkind" },
        },
        config = function () require("core.dap") end
    },

    -- Refactoring
    { "ThePrimeagen/refactoring.nvim",
        event = { "BufNewFile", "BufReadPre" },
        keys = {
            { "<leader>rr", function() require('refactoring').select_refactor() end, mode = { "n", "v" }, desc = "Refactoring: Select refactor" },
        },
        opts = {
            prompt_func_return_type = { cpp = true, c = true },     -- prompt for return type
            prompt_func_param_type = { cpp = true, c = true },      -- prompt for function parameters
        }
    },

    -- Make
    { "tpope/vim-dispatch",
        cmd = { "Dispatch", "Make" }
    },

    -- Databases
    { "tpope/vim-dadbod", enabled = false,
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
            vim.g.dbs = {
                ['dev-mysql'] = 'mysql://root:root@127.0.0.1',
                ['dev-redis'] = 'redis://',
                ['dev-sqlite'] = 'sqlite:db.sqlite3',
            }
        end
    },

    -- Testing
    { "nvim-neotest/neotest",
        event = "LspAttach",
        keys = {
            { "<leader>tr", function() require("neotest").run.run() end,             desc = "[Neotest] Run nearest test" },
            { "<leader>ts", function() require("neotest").summary.toggle() end,      desc = "[Neotest] Toggle summary" },
            { "<leader>to", function() require("neotest").output_panel.toggle() end, desc = "[Neotest] Output panel" }
        },
        dependencies = {
            "alfaix/neotest-gtest",
            -- "nvim-neotest/neotest-plenary",
            -- "nvim-neotest/neotest-vim-test",
            -- "vim-test/vim-test",
        },
        config = function()
            require("neotest").setup {
                adapters = {
                    require("neotest-gtest").setup({}),
                    require('rustaceanvim.neotest')
                    -- require("neotest-plenary"),
                    -- require("neotest-vim-test") {
                    --     allow_file_types = { 'c', 'cpp' },
                    -- },
                },
                loglevel = 1
            }
        end,
    },
}
