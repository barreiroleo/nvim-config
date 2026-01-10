return {
    -- "ThePrimeagen/99",
    "barreiroleo/99",
    opts = {
        --- md_files is a list of files to look for and auto add based on the location of the originating request.
        --- That means if you are at /foo/bar/baz.lua the system will automagically look for:
        --- /foo/bar/AGENT.md
        --- /foo/AGENT.md
        --- assuming that /foo is project root (based on cwd)
        md_files = {
            "AGENT.md",
        },
        model = "github-copilot/claude-sonnet-4.5" -- opencode models
    },

    keys = {
        { mode = { "n" },      "<leader>9f", function() require("99").fill_in_function() end,  desc = "Fill in function with 99" },
        { mode = { "v" },      "<leader>9v", function() require("99").visual() end,            desc = "Visual select and send to 99" },
        { mode = { "n", "v" }, "<leader>9s", function() require("99").stop_all_requests() end, desc = "Stop all 99 requests" },
    },
}
