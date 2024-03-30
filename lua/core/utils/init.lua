local M = {}

-- Save and exec the current Lua or VimL file
-- Used by a keymap <leader><leader>x
M.save_and_exec = require("core.utils.save_and_exec")

---Toggle the LSP diagnostics
-- Used by a keymap <leader>ud
M.toggle_diagnostics = require("core.utils.toggle_diagnostics")

-- Return the loaded options for a plugin
---@param name string
function M.get_opts(name)
    local plugin = require("lazy.core.config").plugins[name]
    if not plugin then
        return {}
    end
    local Plugin = require("lazy.core.plugin")
    return Plugin.values(plugin, "opts", false)
end

-- TODO: Migrate to Lua and proper keymap
require("core.utils.search_replace_v")
require("core.utils.HighlightRepeats")
require("core.utils.ToggleWrap")

return M
