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
            chat = { adapter = "ollama", },
            inline = { adapter = "ollama", },
        },
        adapters = {
            ollama = function()
                return require("codecompanion.adapters").extend("ollama", {
                    env = {
                        url = "http://localhost:11434",
                        -- api_key = "OLLAMA_API_KEY",
                    },
                    schema = {
                        model = {
                            -- default = "CodeOllamaLlama3.1-8B",
                            default = "llama3.1:latest",
                            -- default = "codellama:13b",
                        },
                        temperature = {
                            default = 0.1
                        },
                    }
                })
            end,
        },
    }
}
