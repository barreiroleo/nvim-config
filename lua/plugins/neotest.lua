return {
    "nvim-neotest/neotest",
    event = "LspAttach",
    dependencies = {
        "alfaix/neotest-gtest",
        "nvim-neotest/neotest-plenary",
    },

    config = function(_, opts)
        local adapters = {
            require("neotest-gtest").setup({
                -- TODO: I don't like this global approach. Need to read about neotest projects settings
                filter_dir = function(name, _rel_path, _root)
                    if name == "include" or name == "build" then
                        return false
                    end
                    return true
                end
            }),
            require('rustaceanvim.neotest'),
            require("neotest-plenary"),
        }

        ---@diagnostic disable-next-line: missing-fields
        require("neotest").setup({
            adapters = adapters,
            log_level = 1
        })
    end,

    keys = {
        { "<leader>tr", function() require("neotest").run.run() end,             desc = "Neotest: Run nearest test" },
        { "<leader>ts", function() require("neotest").summary.toggle() end,      desc = "Neotest: Toggle summary" },
        { "<leader>to", function() require("neotest").output_panel.toggle() end, desc = "Neotest: Output panel" }
    }
}
