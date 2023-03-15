local keymaps = require("plugins.treesitter.TS-keymaps").TS_basics
local basics = {}

-- Highlight syntax.
basics.highlight = {
    -- `false` will disable the whole extension
    enable = true,
    -- list of language (parser name) that will be disabled
    disable = {"latex"},
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
}

-- Colorize parenthesis (), [], {}, etc.
basics.rainbow = {
    enable = true,
    -- disable = { },          -- parsers you want to disable the plugin for
    extended_mode = true,   -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil,   -- Do not enable for files with more than n lines, int
    -- colors = {}, -- table of hex strings
    -- termcolors = {} -- table of colour name strings
}

-- Incremental selection based on the named names from the grammar.
basics.incremental_selection = {
    enable = true,
    keymaps = keymaps,
}

-- Indentation based on treesitter for the = operator.
basics.indent = { enable = true }

return basics
