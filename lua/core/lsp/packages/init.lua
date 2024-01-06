local Pack = {}

-- Get the available servers to install with mason-lspconfig:
-- :lua P(require("mason-lspconfig").get_available_servers())
-- :put = execute('messages')

Pack.lsp = require("core.lsp.packages.lsp")
Pack.dap = require("core.lsp.packages.dap")

local off_lsp = require("core.lsp.packages.no-lsp")
Pack.null_tools = vim.tbl_filter(function(key) return type(key) == "string" end, vim.tbl_keys(off_lsp))
Pack.null_sources = vim.tbl_values(off_lsp)

return Pack
