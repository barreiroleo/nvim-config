local function should_disable(lang, bufnr)
    local max_filesize = 600 * 1024 -- 600 KB
    local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(bufnr))
    if ok and stats and stats.size > max_filesize then
        local msg = string.format(
            "Disabling Tree-sitter. Max size: %d KB, current size: %d KB.",
            max_filesize / 1024,
            stats.size / 1024
        )
        vim.notify(msg, vim.log.levels.WARN)
        return true
    elseif lang == "latex" then
        return true
    end
end

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
            disable = should_disable,
            additional_vim_regex_highlighting = { 'latex' },
        },
        indent = { enable = true }, -- Indentation based on treesitter for the = operator.
    }
}
