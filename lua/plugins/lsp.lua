return {
    { "neovim/nvim-lspconfig",
        dependencies = {
            { "williamboman/mason.nvim" },
            { "williamboman/mason-lspconfig.nvim" },
            { "WhoIsSethDaniel/mason-tool-installer.nvim" },
            { "nvimtools/none-ls.nvim" },

            { "j-hui/fidget.nvim",
                opts = {
                    progress = {
                        suppress_on_insert = true,
                        -- ignore = { "null-ls" },
                    },
                    notification = {
                        window = { winblend = 100 }
                    }
                }
            },
            { "ray-x/lsp_signature.nvim" },

            { "folke/neoconf.nvim",
                cmd = "Neoconf",
                config = true
            },
            { "folke/neodev.nvim",
                opts = {
                    library = { plugins = { "nvim-treesitter", "neotest", "plenary.nvim" } },
                }
            },
        },
        event = { "BufNewFile", "BufReadPre" },
        config = function() require "core.lsp" end,
        cmd = { "Mason", "MasonInstall" }
    },
}
