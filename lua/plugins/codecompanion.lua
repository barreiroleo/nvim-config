-- deepseek-r1:14b: Knows C++23. Fast processing but responses takes long because the verbosity.
-- deepseek-coder-v2:16b. Knows until C++20. Fast. Horrible at inline requests and C++ in general.
-- codegemma:7b-instruct. Knows C++23. Fast. Horrible with codecompanion in general.

-- Knows C++23.
local phi4 = function()
    return require("codecompanion.adapters").extend("ollama", {
        name = "phi4",
        schema = {
            model = {
                default = "phi4:14b"
            },
        },
    })
end

-- Knows C++. Doesn't work with inline requests.
-- Result is present in logs but not well formated. Raise a ticket.
local gemma3 = function()
    return require("codecompanion.adapters").extend("ollama", {
        name = "gemma3",
        schema = {
            model = {
                default = "gemma3:12b",
            },
            temperature = { default = 1.0 },
            top_k = { default = 64 },
            top_p = { default = 0.95 },
        },
    })
end

local commit_prompt =
[[
You are a senior software engineer. Given this diff, generate a commit message filling the %placeholder% in the template:
Use "N/A" when a certain tag doesn't apply. Do not hallucinate.
```
%Conventional commit title%

[DESCRIPTION]:
%Description%
[WHY]:
%Why%
[ISSUE]:
%Issue%
```
]]

return {
    "olimorris/codecompanion.nvim",
    event = { 'BufNewFile', 'BufReadPre' },
    cmd = {
        "CodeCompanion", "CodeCompanionActions", "CodeCompanionChat", "CodeCompanionCmd",
    },
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    opts = {
        strategies = {
            agent = { adapter = "phi4", },
            chat = { adapter = "gemma3", },
            inline = { adapter = "phi4", },
        },
        adapters = {
            phi4 = phi4,
            gemma3 = gemma3,
        },

        prompt_library = {
            ["Commit"] = {
                strategy = "chat",
                description = "Generate commit from diff",
                opts = { short_name = "commit", is_slash_cmd = true, auto_submit = false },
                prompts = {
                    {
                        role = "system",
                        content = commit_prompt,
                        opts = { visible = false }
                    },
                    {
                        role = "user",
                        content = function(ctx)
                            if ctx.is_visual then
                                return string.format("```\n%s\n```", ctx.lines)
                            end
                            return string.format("```\n%s\n```",
                                require("codecompanion.helpers.actions").get_code(ctx.start_line, ctx.line_count))
                        end
                    }
                }
            }
        }
        -- opts = {
        --     log_level = "DEBUG"
        -- }
    },
    init = function()
        require("plugins.snacks_notifiers.codecompanion").setup()
    end
}
