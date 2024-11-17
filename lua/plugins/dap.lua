return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "nvim-neotest/nvim-nio",
        "jay-babu/mason-nvim-dap.nvim",
        "jbyuki/one-small-step-for-vimkind",
        {
            "theHamsta/nvim-dap-virtual-text",
            opts = {
                enabled = true,
                commented = true,
                clear_on_continue = true,
                virt_text_pos = "eol"
            }
        },
    },
    config = function() require("core.dap") end,
    keys = {
        { "<leader>dC",   function() require("dap").set_breakpoint(vim.fn.input '[Condition] > ') end, desc = "DAP: Conditional breakpoint" },
        { "<F9>",         function() require "dap".toggle_breakpoint() end,                            desc = "DAP: Breakpoint toggle" },
        { "<F6>",         function() require "dap".goto_() end,                                        desc = "DAP: Goto line" },
        { "<F5>",         function() require "dap".continue() end,                                     desc = "DAP: Continue" },
        { "<leader><F5>", function() require "dap".run_last() end,                                     desc = "DAP: Run last" },
        { "<F11>",        function() require "dap".step_into() end,                                    desc = "DAP: Step Into" },
        { "<F10>",        function() require "dap".step_over() end,                                    desc = "DAP: Step Over" },
        { "<F12>",        function() require "dap".step_out() end,                                     desc = "DAP: Step Out" },
    }
}
