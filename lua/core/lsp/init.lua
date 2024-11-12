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

-- Diagnostic message display. Error lens
vim.diagnostic.config {
    virtual_text = {
        spacing = 4,
        severity = {
            min = vim.diagnostic.severity.WARN,
            max = vim.diagnostic.severity.ERROR
        },
        source = "if_many",
        prefix = '■' -- Could be '●', '▎', 'x', '⯀'
    },
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = '',
            [vim.diagnostic.severity.WARN] = '',
            [vim.diagnostic.severity.HINT] = '',
            [vim.diagnostic.severity.INFO] = '',
        },
        linehl = {
            [vim.diagnostic.severity.ERROR] = 'ErrorMsg',
            [vim.diagnostic.severity.WARN] = 'WarningMsg',
        },
        numhl = {
            [vim.diagnostic.severity.ERROR] = 'ErrorMsg',
            [vim.diagnostic.severity.WARN] = 'WarningMsg',
        },
    },
    float = { source = "if_many", border = "rounded" },
    underline = true,
    update_in_insert = true,
    severity_sort = true,
}
vim.cmd.highlight("ErrorMsg guibg=#250003 guifg=0")
vim.cmd.highlight("WarningMsg guibg=#382b00 guifg=0")


-- Override floating windows border globally
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
---@diagnostic disable-next-line: duplicate-set-field
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
    opts = opts or {}
    ---@diagnostic disable-next-line: assign-type-mismatch
    opts.border = opts.border or "rounded"
    return orig_util_open_floating_preview(contents, syntax, opts, ...)
end
