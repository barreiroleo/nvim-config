function R(...)
    require("plenary.reload").reload_module(...)
    return require(...)
end

require("core.utils.highlight_repeats")
require("core.utils.search_selection")
require("core.utils.less")
