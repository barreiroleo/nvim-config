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
            { "ray-x/lsp_signature.nvim",
                config = function()
                    vim.api.nvim_create_autocmd("LspAttach", {
                        callback = function(args)
                            local bufnr = args.buf
                            require "lsp_signature".on_attach({
                                -- handler_opts = {
                                --     border = "none"
                                -- },
                                -- auto_close_after = 5,
                                -- transparency = 10,
                                -- toggle_key = '<C-e>'
                            }, bufnr)
                        end,
                    })
                end
            },
        },
        event = { "BufNewFile", "BufReadPre" },
        config = function() require "core.lsp" end,
        cmd = { "Mason", "MasonInstall" }
    },
}
