local M = {}

---Toggle the LSP diagnostics
local lsp_diag_enabled = true
function M.toggle_diagnostics()
  lsp_diag_enabled = not lsp_diag_enabled
  if lsp_diag_enabled then
    vim.diagnostic.enable()
    vim.notify("Enabled LSP diagnostics", vim.log.levels.WARN, {title = "Diagnostics"})
  else
    vim.diagnostic.disable()
    vim.notify("Disabled LSP diagnostics", vim.log.levels.WARN, {title = "Diagnostics"})
  end
end

return M.toggle_diagnostics
