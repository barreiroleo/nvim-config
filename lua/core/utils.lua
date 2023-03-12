local M = {}

M.map = function(mode, lhs, rhs, opts)
    opts = opts or {}
    opts.silent = opts.silent ~= false
    vim.keymap.set(mode, lhs, rhs, opts)
end

M.save_and_exec = function()
  local source_commands = {
    lua = "luafi %",
    vim = "source %",
  }

  local ft = vim.api.nvim_buf_get_option(0, "filetype")
  local command = source_commands[ft]
  if command == nil then
    vim.notify("This type cant not be sourced", vim.log.levels.ERROR, { title = "Core utils" })
    return
  end

  -- Save and source
  vim.api.nvim_command "silent w"
  vim.api.nvim_command(command)

  local current_file_name = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":t")
  vim.notify(string.format("File %s Sourced", current_file_name), vim.log.levels.INFO, { title = "Core utils" })
end

---@param plugin string
function M.has(plugin)
    return require("lazy.core.config").plugins[plugin] ~= nil
end

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

-- FIXME: create a togglable terminal
-- Opens a floating terminal (interactive by default)
---@param cmd? string[]|string
---@param opts? LazyCmdOptions|{interactive?:boolean}
function M.float_term(cmd, opts)
  opts = vim.tbl_deep_extend("force", {
    size = { width = 0.9, height = 0.9 },
  }, opts or {})
  require("lazy.util").float_term(cmd, opts)
end


M.root_patterns = { ".git", "lua" }

-- returns the root directory based on:
-- * lsp workspace folders
-- * lsp root_dir
-- * root pattern of filename of the current buffer
-- * root pattern of cwd
---@return string
function M.get_root()
  ---@type string?
  local path = vim.api.nvim_buf_get_name(0)
  path = path ~= "" and vim.loop.fs_realpath(path) or nil
  ---@type string[]
  local roots = {}
  if path then
    for _, client in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
      local workspace = client.config.workspace_folders
      local paths = workspace and vim.tbl_map(function(ws)
        return vim.uri_to_fname(ws.uri)
      end, workspace) or client.config.root_dir and { client.config.root_dir } or {}
      for _, p in ipairs(paths) do
        local r = vim.loop.fs_realpath(p)
        if path:find(r, 1, true) then
          roots[#roots + 1] = r
        end
      end
    end
  end
  table.sort(roots, function(a, b)
    return #a > #b
  end)
  ---@type string?
  local root = roots[1]
  if not root then
    path = path and vim.fs.dirname(path) or vim.loop.cwd()
    ---@type string?
    root = vim.fs.find(M.root_patterns, { path = path, upward = true })[1]
    root = root and vim.fs.dirname(root) or vim.loop.cwd()
  end
  ---@cast root string
  return root
end

return M
