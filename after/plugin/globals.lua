function P(v)
    vim.notify(vim.inspect(v) .. "\n", vim.log.levels.WARN)
    return v
end

function R(...)
    require("plenary.reload").reload_module(...)
    return require(...)
end

require("core.utils.highlight_repeats")

require("core.utils.less")
