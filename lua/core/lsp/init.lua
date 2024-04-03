local servers_lsp = require("core.lsp.packages").lsp
local servers_dap = require("core.lsp.packages").dap
local null_sources = require("core.lsp.packages").null_sources

local format_tools = require("core.lsp.packages").format_tools
local lint_tools = require("core.lsp.packages").lint_tools
local tools = vim.tbl_flatten(vim.tbl_extend("force", {}, { lint_tools, format_tools }))

-- Install servers and tools
require("mason").setup()

require("mason-lspconfig").setup({
    -- Use lspconfig names
    ensure_installed = servers_lsp,
    auto_update = true,
})

require("mason-tool-installer").setup({
    ensure_installed = tools,
    auto_update = true,
})

require("mason-nvim-dap").setup({
    ensure_installed = servers_dap,
})

-- Load servers
local handlers = require("core.lsp.handlers")
require("mason-lspconfig").setup_handlers(handlers)

-- Load null sources
require("null-ls").setup({
    debug = false,
    sources = null_sources,
})

-- Config LSP related UI
require("core.lsp.ui")
