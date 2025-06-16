return {
    'nvim-treesitter/nvim-treesitter',
    event = { 'BufNewFile', 'BufReadPre' },
    build = ':TSUpdate',
    main = "nvim-treesitter.configs", -- Sets main module to use for opts
    dependencies = {
        { "nvim-treesitter/nvim-treesitter-textobjects" },
        {
            'nvim-treesitter/nvim-treesitter-context',
            opts = { multiline_threshold = 1, } -- Avoid showing '{' only lines
        }
    },
    opts = {
        ensure_installed = {
            "c", "cpp", "make", "cmake",
            "lua", "luadoc", "vim", "vimdoc",
            "rust", "java", "python", "bash",
            "markdown",
            "json", "jsonc", "toml", "yaml", "sql", "dockerfile",
        },
        ignore_install = { "javascript" },
        auto_install = true,
        sync_install = false,
        highlight = {
            enable = true,
            --- Disable TS highlighting for certain conditions, like buffer size or language.
            ---@param lang string
            ---@param _ integer: bufnr
            disable = function(lang, _)
                if lang == "latex" or lang == "cpp" then
                    return true
                end
            end,
            additional_vim_regex_highlighting = { 'latex' },
        },
        indent = { enable = true }, -- Indentation based on treesitter for the = operator.
        textobjects = {
            select = {
                enable = true,
                lookahead = true,
                keymaps = {
                    ["af"] = "@function.outer",
                    ["if"] = "@function.inner",
                    ["ac"] = "@class.outer",
                    ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
                    ["as"] = { query = "@local.scope", query_group = "locals", desc = "Select language scope" },
                },
            },
            move = {
                enable = true,
                goto_next_start = { ["]f"] = "@function.outer" },     -- ["]c"] = "@class.outer", ["]a"] = "@parameter.inner" },
                goto_next_end = { ["]F"] = "@function.outer" },       -- ["]C"] = "@class.outer", ["]A"] = "@parameter.inner" },
                goto_previous_start = { ["[f"] = "@function.outer" }, -- ["[c"] = "@class.outer", ["[a"] = "@parameter.inner" },
                goto_previous_end = { ["[F"] = "@function.outer" },   -- ["[C"] = "@class.outer", ["[A"] = "@parameter.inner" },
            },
        },
    }
}
