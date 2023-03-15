local basics      = require("plugins.treesitter.TS-basics")
local textobjects = require("plugins.treesitter.TS-textobjects")
local refactor    = require("plugins.treesitter.TS-refactor")

local parsers = {
    "bash",
    "c", "cpp", "c_sharp", "make", "cmake", "meson",
    "lua", "python", "rust", "go", "java",
    "latex", "bibtex", "markdown",

    "http", "html", "css", "scss",
    "javascript", "jsdoc", "tsx", "typescript",
    "php", "phpdoc",

    "regex", "dockerfile", "hjson", "toml", "yaml",
    "diff", "gitattributes", "gitignore",
    "help", "vim",
}

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
        }
        -- config = function() require("configs.treesitter").setup() end,
    },
}
