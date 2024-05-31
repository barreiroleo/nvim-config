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
        end
    }
})

require("mason-tool-installer").setup({
    ensure_installed = tools,
    auto_update = true,
})

require("mason-nvim-dap").setup({
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

-- Hover and signature popups rounded
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
vim.lsp.handlers["textDocument/signature_help"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })


vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserAutocmd_LspAttach", { clear = false }),
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        local bufnr = args.buf
        vim.keymap.set('n', 'gd',         vim.lsp.buf.definition,           { buffer = bufnr, desc = "[LSP] Go to definition"})
        vim.keymap.set('n', 'gD',         vim.lsp.buf.declaration,          { buffer = bufnr, desc = "[LSP] Go to declaration"})
        vim.keymap.set('n', 'gi',         vim.lsp.buf.implementation,       { buffer = bufnr, desc = "[LSP] List symbol implementations"})
        vim.keymap.set('n', 'gr',         vim.lsp.buf.references,           { buffer = bufnr, desc = "[LSP] List symbol references"})
        vim.keymap.set('n', 'gt',         vim.lsp.buf.type_definition,      { buffer = bufnr, desc = "[LSP] Go to type definition"})
        vim.keymap.set('n', '<C-k>',      vim.lsp.buf.signature_help,       { buffer = bufnr, desc = "[LSP] Show symbol signature information"})
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename,               { buffer = bufnr, desc = "[LSP] Rename symbol under cursor and references"})
        vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, { buffer = bufnr, desc = "[LSP] List code actions for position or range"})
        vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, { buffer = bufnr, desc = "[LSP] List code actions for position or range"})

        if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
            vim.keymap.set("n", "<leader>th", function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
            end, { buffer = bufnr, desc = "[LSP] Toggle inlay hints" })
        end
    end,
})
