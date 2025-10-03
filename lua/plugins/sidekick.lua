return {
    "folke/sidekick.nvim",
    opts = {
        cli = {
            mux = {
                backend = "tmux",
                enabled = true,
            },
        },
    },

    keys = {
        {
            -- Apply current edit suggestion or jump to next one. Fallback to normal tab behavior
            "<tab>",
            function()
                if not require("sidekick").nes_jump_or_apply() then return "<Tab>" end
            end,
            expr = true,
            desc = "Goto/Apply Next Edit Suggestion",
        },
        {
            "<M-v>",
            function() require("sidekick.cli").send({ msg = "{selection}" }) end,
            mode = { "x" },
            desc = "Send Visual Selection",
        },

        {
            "<M-p>",
            function() require("sidekick.cli").prompt() end,
            mode = { "n", "x" },
            desc = "Sidekick Select Prompt",
        },
        {
            "<M-l>",
            function() require("sidekick.cli").send({ msg = "{this}" }) end,
            mode = { "x", "n" },
            desc = "Send This",
        },
        {
            "<M-.>",
            function() require("sidekick.cli").focus({ name = "opencode" }) end,
            mode = { "n", "x", "i", "t" },
            desc = "Sidekick Switch Focus",
        },
    },
}
