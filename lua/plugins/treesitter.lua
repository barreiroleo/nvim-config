return {
    'nvim-treesitter/nvim-treesitter',
    event = { 'BufNewFile', 'BufReadPre' },
    build = ':TSUpdate',
    main = "nvim-treesitter.configs", -- Sets main module to use for opts
    dependencies = {
        'nvim-treesitter/nvim-treesitter-context',
        opts = { multiline_threshold = 1, } -- Avoid showing '{' only lines
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
    }
}
