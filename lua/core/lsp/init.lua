local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

require("core.lsp.ui")
require("mason").setup()

require("mason-lspconfig").setup({
    ensure_installed = {
        "clangd",
        "lua_ls",
        "basedpyright",
    },

    handlers = {
        function(server_name)
            require("lspconfig")[server_name].setup {
                capabilities = capabilities
            }
        end,

        ["lua_ls"] = function(server_name)
            require("lspconfig")[server_name].setup {
                capabilities = capabilities,
                settings = require("core.lsp.handlers.lua_ls").settings
            }
        end,

        ["clangd"] = function(server_name)
            require("lspconfig")[server_name].setup {
                capabilities = capabilities,
                on_attach = require("core.lsp.handlers.clangd").on_attach,
                commands = require("core.lsp.handlers.clangd").commands,
                cmd = require("core.lsp.handlers.clangd").cmd
            }
        end,

        ["ltex"] = function(server_name)
            require("lspconfig")[server_name].setup {
                capabilities = capabilities,
                filetypes = require("core.lsp.handlers.ltex").filetypes,
                settings = require("core.lsp.handlers.ltex").settings,
            }
        end,

        ["texlab"] = function(server_name)
            require("lspconfig")[server_name].setup {
                capabilities = capabilities,
                on_attach = require("core.lsp.handlers.texlab").on_attach,
                filetypes = require("core.lsp.handlers.texlab").filetypes,
                settings = require("core.lsp.handlers.texlab").settings,
            }
        end,

        -- Disable Rust from lsp-config cuz Rustacean
        ["rust_analyzer"] = function(_) end
    }
})
