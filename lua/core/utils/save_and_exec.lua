local M = {}

-- Save and exec the current Lua or VimL file
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
  local current_file_name = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":t")
  vim.notify(string.format("File %s Sourced", current_file_name), vim.log.levels.INFO, { title = "Core utils" })

  vim.cmd("silent w")
  vim.cmd("message clear")
  vim.cmd(command)
end

return M.save_and_exec
