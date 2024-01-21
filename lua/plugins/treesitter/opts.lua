local opts = {
    highlight = {
        enable = true,
        disable = function(lang, bufnr)
            return lang == 'latex' or vim.api.nvim_buf_line_count(bufnr) > 10000
        end,
        additional_vim_regex_highlighting = { 'latex' },
    },
    rainbow = {
        enable = true,
        disable = {},           -- parsers you want to disable the plugin for
        extended_mode = true,   -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
        max_file_lines = nil,   -- Do not enable for files with more than n lines, int
    },
    indent = { enable = true }, -- Indentation based on treesitter for the = operator.
    sync_install = false,

    ensure_installed = require 'plugins.treesitter.ts-parsers',
    playground = require 'plugins.treesitter.ts-playground',
}

return opts
