return {
    { "neovim/nvim-lspconfig",
        dependencies = {
            { "williamboman/mason.nvim" },
            { "williamboman/mason-lspconfig.nvim" },
            { "WhoIsSethDaniel/mason-tool-installer.nvim" },
            { "jose-elias-alvarez/null-ls.nvim" },

            { "j-hui/fidget.nvim",
                opts = {
                    window = { blend = 0 },
                    sources = { ["null-ls"] = { ignore = true } },
                }
            },
            { "SmiteshP/nvim-navic" },
            { "ray-x/lsp_signature.nvim" },

            { "folke/neoconf.nvim",
                cmd = "Neoconf",
                config = true
            },
            { "folke/neodev.nvim",
                opts = { experimental = { pathStrict = true } }
            },
        },
        event = { "BufReadPre", "BufNewFile" },
        config = function() require "core.lsp" end,
    },
}
