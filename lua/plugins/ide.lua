return {
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
    { "aznhe21/actions-preview.nvim",
        event = "LspAttach",
        config = function()
            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(args)
                    local bufnr = args.buf
                    local run = require("actions-preview").code_actions
                    vim.keymap.set({ "v", "n" }, "<leader>ca", run, { buffer = bufnr })
                end,
            })
        end
    },

    -- TaskRunner
    { "stevearc/overseer.nvim", lazy = true,
        opts = {
            task_lists = { direction = "right" },
            templates = { "builtin", "user.cpp_build", "user.run_script" }
        },
        cmd = { "OverseerOpen", "OverseerLoadBundle", "OverseerRunCmd", "OverseerRun",
            "OverseerInfo", "OverseerBuild", "OverseerQuickAction", "OverseerTaskAction"
        }
    },

    -- Make
    { "tpope/vim-dispatch",
        cmd = { "Dispatch", "Make" }
    },

    -- Testing
    { "nvim-neotest/neotest",
        event = "LspAttach",
        keys = {
            { "<leader>tt", function() require("neotest").run.run() end,        { desc = "[Neotest] Run nearest test" } },
            { "<leader>ts", function() require("neotest").summary.toggle() end, { desc = "[Neotest] Toggle summary" } }
        },
        dependencies = {
            "nvim-neotest/neotest-plenary",
            "alfaix/neotest-gtest",
            "nvim-neotest/neotest-vim-test",
            "vim-test/vim-test",
        },
        config = function()
            require("neotest").setup {
                adapters = {
                    require("neotest-plenary"),
                    require("neotest-gtest").setup({}),
                    require("neotest-vim-test") {
                        allow_file_types = { 'c', 'cpp' },
                    },
                },
                loglevel = 1
            }
        end,


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

    -- Docs generation
    { "danymat/neogen",
        event = { "BufNewFile", "BufReadPre" },
        keys = {
            { "<leader>dg", ":lua require('neogen').generate()<CR>", mode = { "n", "v" }, desc = "Neogen: Generate docs" }
        },
        opts = { snippet_engine = "luasnip" }
    }
}
