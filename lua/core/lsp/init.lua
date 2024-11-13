local servers_lsp = require("core.lsp.packages").lsp
local servers_dap = require("core.lsp.packages").dap
local null_sources = require("core.lsp.packages").null_sources

local format_tools = require("core.lsp.packages").format_tools
local lint_tools = require("core.lsp.packages").lint_tools
local tools = vim.iter({ lint_tools, format_tools }):flatten():totable()

local capabilities = vim.tbl_deep_extend("force", {},
    vim.lsp.protocol.make_client_capabilities(),
    require("cmp_nvim_lsp").default_capabilities()
)
-- local capabilities = vim.lsp.protocol.make_client_capabilities()

require("core.lsp.lsp_ui")

-- Install servers and tools
require("mason").setup()

require("mason-lspconfig").setup({
    -- Use lspconfig names
    ensure_installed = servers_lsp,
    auto_update = true,

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
        ["rust_analyzer"] = function(server_name)
        end
    }
})

require("mason-tool-installer").setup({
    ensure_installed = tools,
    auto_update = true,
})

require("mason-nvim-dap").setup({
    automatic_installation = false,
    ensure_installed = servers_dap,
})

require("null-ls").setup({
    debug = false,
    sources = null_sources,
})
