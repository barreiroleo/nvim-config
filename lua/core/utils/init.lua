local M = {}

-- Save and exec the current Lua or VimL file
-- Used by a keymap <leader><leader>x
M.save_and_exec = require("core.utils.save_and_exec")

---Toggle the LSP diagnostics
-- Used by a keymap <leader>ud
M.toggle_diagnostics = require("core.utils.toggle_diagnostics")

-- Returns the root directory based certain rules:
-- Used by Lazygit launcher <leader>gg / gG
M.get_root = require("core.utils.get_root")

-- Opens a floating terminal (interactive by default)
-- Used by Lazygit
M.float_term = require("core.utils.float_term")

-- Shorthand to declare a keymap
-- Used by all keymaps declaration under config/keymaps
M.map = function(mode, lhs, rhs, opts)
    opts = opts or {}
    opts.silent = opts.silent ~= false
    vim.keymap.set(mode, lhs, rhs, opts)
end

---Check if the plugin exist in the Lazy plugins list
---@param plugin string
-- Used by a couple of rules in config/{keymaps, options}
function M.has(plugin)
    return require("lazy.core.config").plugins[plugin] ~= nil
end

return M
