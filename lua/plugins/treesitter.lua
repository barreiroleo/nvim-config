return {
    {
        'nvim-treesitter/nvim-treesitter',
        event = { 'BufNewFile', 'BufReadPre' },
        build = ':TSUpdate',
        dependencies = {
            { 'p00f/nvim-ts-rainbow' },
            { 'nvim-treesitter/nvim-treesitter-context', opts = { mode = 'topline' } },
            { 'windwp/nvim-ts-autotag', config = true },
        },
        config = function()
            require('nvim-treesitter.configs').setup {
                -- stylua: ignore
                ensure_installed = {
                    "c", "cpp", "make", "cmake",
                    "lua", "luadoc", "vim", "vimdoc",
                    "rust", "java", "python", "bash",
                    "bibtex", "latex", "markdown", "mermaid",
                    "json", "jsonc", "toml", "yaml", "sql", "dockerfile",
                },
                ignore_install = { "javascript" },
                auto_install = true,
                sync_install = false,
                highlight = {
                    enable = true,
                    disable = function(lang, bufnr)
                        local max_filesize = 100 * 1024 -- 100 KB
                        local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(bufnr))
                        if ok and stats and stats.size > max_filesize then
                            vim.notify("TS highlight disabled: max sizw", vim.log.levels.WARN)
                            return true
                        elseif lang == "latex" then
                            return true
                        end
                    end,
                    additional_vim_regex_highlighting = { 'latex' },
                },
                indent = { enable = true }, -- Indentation based on treesitter for the = operator.
                rainbow = {
                    enable = true,
                    disable = {},         -- parsers you want to disable the plugin for
                    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
                    max_file_lines = nil, -- Do not enable for files with more than n lines, int
                },
            }
        end,
    },
}
