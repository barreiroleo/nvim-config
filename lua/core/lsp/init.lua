local servers_lsp  = require("core.lsp.packages").lsp
local servers_dap  = require("core.lsp.packages").dap
local null_tools   = require("core.lsp.packages").null_tools
local null_sources = require("core.lsp.packages").null_sources

-- Install servers and tools
require("mason").setup()

require("mason-lspconfig").setup {
    -- Use lspconfig names
    ensure_installed = servers_lsp,
    auto_update = true,
}

require("mason-tool-installer").setup {
    ensure_installed = null_tools,
    auto_update = true,
}

require("mason-nvim-dap").setup {
    ensure_installed = servers_dap
}

-- Load servers
local handlers = require("core.lsp.handlers")
require('mason-lspconfig').setup_handlers(handlers)

-- Load null sources
require("null-ls").setup {
    debug = true,
    sources = null_sources,
}

-- Config lsp diagnostic UI
-- require("core.lsp.diagnostics")
-- require("core.lsp.format")
