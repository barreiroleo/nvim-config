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
            { "ray-x/lsp_signature.nvim", enabled = true,
                config = function()
                    require "lsp_signature".setup({
                        hint_enable = false,
                        toggle_key_flip_floatwin_setting = true,
                        toggle_key = "<C-e>",      -- toggle signature in insert mode
                        move_cursor_key = "<C-k>", -- toggle focus between win and floating
                    })
                end
            },

            -- --- Get vim completions outside vim config path
            -- { "folke/neodev.nvim",
            --     opts = {
            --         override = function(_, library)
            --             library.enabled = true
            --             library.plugins = { "nvim-treesitter", "plenary.nvim", "neotypes" }
            --             library.types = true
            --         end,
            --     }
            -- }
            { "folke/lazydev.nvim", ft = "lua", config = true }
        },
        event = { "BufNewFile", "BufReadPre" },
        config = function() require "core.lsp" end,
        cmd = { "Mason", "MasonInstall" }
    },
}
