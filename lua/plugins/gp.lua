local system_prompt =
    "You are a general AI assistant working as a code editor. You're an expert on engineering.\n"
    .. "The user provided the additional info about how they would like you to respond:\n"
    .. "- If you're unsure don't guess and say you don't know instead.\n"
    .. "- Ask question if you need clarification to provide better answer.\n"
    .. "- Think deeply and carefully from first principles step by step.\n"
    .. "- Zoom out first to see the big picture and then zoom in to details.\n"
    .. "- Use Socratic method to improve your thinking and coding skills.\n"
    .. "- Don't elide any code from your output if the answer requires coding.\n"
    .. "- Take a deep breath; You've got this!\n"
    .. "- Be consice on your answers\n"
    .. "- Please AVOID COMMENTARY OUTSIDE OF THE SNIPPET RESPONSE.\n"
    .. "- START AND END YOUR ANSWER WITH:\n\n```"

return {
    "robitx/gp.nvim",
    opts = {
        default_command_agent = "CodeOllamaLlama3.1-8B",
        default_chat_agent = "CodeOllamaLlama3.1-8B",

        providers = {
            ollama = {
                endpoint = "http://localhost:11434/v1/chat/completions",
            },
        },
        agents = {
            {
                provider = "ollama",
                name = "CodeOllamaLlama3.1-8B",
                chat = true,
                command = true,
                -- string with model name or table with model name and parameters
                model = {
                    model = "llama3.1",
                    temperature = 0.2,
                    top_p = 1,
                    min_p = 0.05,
                },
                system_prompt = system_prompt
            },
        },

        hooks = {
            -- Custom commands :GpExplain, :GpUnitTests.., :GpTranslator etc.

            -- Custom command which writes unit tests for the selected code.
            UnitTests = function(gp, params)
                local template = "I have the following code from {{filename}}:\n\n"
                    .. "```{{filetype}}\n{{selection}}\n```\n\n"
                    .. "Please respond by writing table driven unit tests for the code above."
                local agent = gp.get_command_agent()
                gp.Prompt(params, gp.Target.vnew, agent, template)
            end,

            -- Custom command which explains the selected code.
            Explain = function(gp, params)
                local template = "I have the following code from {{filename}}:\n\n"
                    .. "```{{filetype}}\n{{selection}}\n```\n\n"
                    .. "Please respond by explaining the code above."
                local agent = gp.get_chat_agent()
                P(agent)
                gp.Prompt(params, gp.Target.vnew, agent, template)
            end,

            -- Custom command to review the selected code.
            CodeReview = function(gp, params)
                local template = "I have the following code from {{filename}}:\n\n"
                    .. "```{{filetype}}\n{{selection}}\n```\n\n"
                    .. "Please analyze for code smells and suggest improvements."
                local agent = gp.get_chat_agent()
                gp.Prompt(params, gp.Target.vnew("markdown"), agent, template)
            end,

            -- Generate commit on diff buffers
            Commit = function(gp, params)
                local buffer_content = ""
                for _, line in ipairs(vim.api.nvim_buf_get_lines(0, 0, vim.api.nvim_buf_line_count(0), false)) do
                    buffer_content = buffer_content .. '\n' .. line
                end

                local commit_prompt = system_prompt ..
                    "\nGenerate a commit bassed on the commit's differences:\n"
                    .. buffer_content

                gp.cmd.ChatNew(params, commit_prompt)
            end
        },
    },
}
