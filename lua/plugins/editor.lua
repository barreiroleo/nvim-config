return {
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = { check_ts = true }
    },

    {
        "folke/todo-comments.nvim",
        event = { "BufNewFile", "BufReadPre" },
        dependencies = "nvim-lua/plenary.nvim",
        opts = {
            highlight = {
                -- vimgrep regex, supporting the pattern TODO(username):
                pattern = [[.*<((KEYWORDS)%(\(.{-1,}\))?):]],
            },
            search = {
                -- ripgrep regex, supporting the pattern TODO(username):
                pattern = [[\b(KEYWORDS)(\(\w*\))*:]],
            },
        }
    },

    {
        'norcalli/nvim-colorizer.lua',
        event = { 'BufNewFile', 'BufReadPre' },
        opts = { 'md', 'tex', 'json', 'css', 'javascript', 'html', 'python', 'lua' },
        cmd = { "ColorizerAttachToBuffer" }
    },

    { "zef/vim-cycle",         event = { "BufNewFile", "BufReadPre" } },
    { "numToStr/Comment.nvim", event = { "BufNewFile", "BufReadPre" }, config = true, },
    { 'tpope/vim-repeat',      event = { 'BufNewFile', 'BufReadPre' } },
    {
        "tpope/vim-surround",
        event = { "BufNewFile", "BufReadPre" },
        config = function()
            vim.cmd [[
                autocmd FileType tex let b:surround_{char2nr("q")} = "`\r'"
                autocmd FileType tex let b:surround_{char2nr('Q')} = "``\r''"
                autocmd FileType tex let b:surround_{char2nr('i')} = "\\textit{\r}"
                autocmd FileType tex let b:surround_{char2nr('b')} = "\\textbf{\r}"
                autocmd FileType tex let b:surround_{char2nr('t')} = "\\texttt{\r}"
                " autocmd FileType tex let b:surround_{char2nr('s')} = "\\textsc{\r}"
                autocmd FileType tex let b:surround_{char2nr('c')} = "\\corner{\r}"
                autocmd FileType tex let b:surround_{char2nr('s')} = "\\set{\r}"
                autocmd FileType tex let b:surround_{char2nr('$')} = "$\r$"
                autocmd FileType tex let b:surround_96 = "`\r'"
            ]]
        end
    },

    {
        'MagicDuck/grug-far.nvim',
        opts = {},
        keys = {
            vim.keymap.set({ 'n', 'x' }, '<leader>si', function()
                require('grug-far').open({ visualSelectionUsage = 'operate-within-range' })
            end, { desc = 'grug-far: Search within range' }),

            vim.keymap.set({ 'n', 'x' }, '<leader>ss', function()
                local search = vim.fn.getreg('/')
                -- surround with \b if "word" search (such as when pressing `*`)
                if search and vim.startswith(search, '\\<') and vim.endswith(search, '\\>') then
                    search = '\\b' .. search:sub(3, -3) .. '\\b'
                end
                require('grug-far').open({ prefills = { search = search, }, })
            end, { desc = 'grug-far: Search using @/ register value or visual selection' })

        }
    }
}
