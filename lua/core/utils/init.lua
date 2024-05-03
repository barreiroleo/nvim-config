local M = {}

-- Save and exec the current Lua or VimL file
-- Used by a keymap <leader><leader>x
M.save_and_exec = require("core.utils.save_and_exec")

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
require("core.utils.GetVisualSelection")
require("core.utils.HighlightRepeats")
require("core.utils.ToggleWrap")
require("core.utils.Quickfix")

return M
