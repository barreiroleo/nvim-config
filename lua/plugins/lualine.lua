--- @param trunc_width number? trunctates component when screen width is less then trunc_width
--- @param trunc_len number? truncates component to trunc_len number of chars
--- @param hide_width number? hides component when window width is smaller then hide_width
--- @param use_ellipsis boolean? whether to disable adding '...' at end after truncation
--- return function that can format the component accordingly
local function trunc(trunc_width, trunc_len, hide_width, use_ellipsis)
    return function(str)
        local win_width = vim.fn.winwidth(0)
        if hide_width and win_width < hide_width then
            return ''
        elseif trunc_width and trunc_len and win_width < trunc_width and #str > trunc_len then
            return str:sub(1, trunc_len) .. (use_ellipsis and '...' or '')
        end
        return str
    end
end

local lint_component = {
    function()
        local linters = require("lint").get_running()
        if #linters == 0 then return "" end
        return "[" .. table.concat(linters, ", ") .. "]"
    end,
    fmt = trunc(80, 10, nil, true),
    icon = "󱉶 "
}

return {
    "nvim-lualine/lualine.nvim",
    event = { "BufNewFile", "BufReadPre", "InsertEnter" },
    opts = function()
        local opts = require("lualine").get_config()
        opts.options = {
            component_separators = '|',
            section_separators = { left = '', right = '' },
        }
        -- opts.winbar.lualine_a = {'filename'}
        -- opts.inactive_winbar.lualine_a = {'filename'}
        opts.sections.lualine_b = { {'branch', fmt = trunc(80, 0, nil, true)}, 'diagnostics' }
        opts.sections.lualine_x = { Snacks.profiler.status(), lint_component, 'lsp_status' }
        return opts
    end,
}
