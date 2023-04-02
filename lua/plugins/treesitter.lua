local basics      = require("plugins.treesitter.TS-basics")
local textobjects = require("plugins.treesitter.TS-textobjects")
local refactor    = require("plugins.treesitter.TS-refactor")
local parsers     = require("plugins.treesitter.TS-parsers")

local treesitter_opts = {
    -- Install parsers synchronously (only `ensure_installed`)
    ensure_installed = parsers,
    sync_install = false,
    indent = basics.indent,
    highlight = basics.highlight,
    rainbow = basics.rainbow,
    incremental_selection = basics.incremental_selection,
    textobjects = {
        select = textobjects.select,
        swap = textobjects.swap,
        move = textobjects.move,
        lsp_interop = textobjects.lsp_interop,
    },
    refactor = {
        highlight_definitions = refactor.highlight_definitions,
        highlight_current_scope = refactor.highlight_current_scope,
        smart_rename = refactor.smart_rename,
        navigation = refactor.navigation,
    }
}

return{
    { "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        dependencies = {
            { "nvim-treesitter/nvim-treesitter-textobjects" },
            { "nvim-treesitter/nvim-treesitter-refactor" },
            { "p00f/nvim-ts-rainbow" },
            { "nvim-treesitter/nvim-treesitter-context",
                opts = { mode = 'topline' }
            }
        },
        config = function()
            require("nvim-treesitter.configs").setup(treesitter_opts)
        end
    },
}
