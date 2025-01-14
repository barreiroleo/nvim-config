_G.DD = function(...)
    Snacks.debug.inspect(...)
end
_G.BT = function()
    Snacks.debug.backtrace()
end
vim.print = _G.DD

function P(v)
    vim.notify(vim.inspect(v) .. "\n", vim.log.levels.WARN)
    return v
end

function R(...)
    require("plenary.reload").reload_module(...)
    return require(...)
end

require("core.utils.highlight_repeats")
require("core.utils.search_selection")
require("core.utils.less")
