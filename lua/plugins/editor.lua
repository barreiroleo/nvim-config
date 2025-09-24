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
            vim.keymap.set('x', '<leader>si',
                function() require('grug-far').with_visual_selection({ prefills = { paths = vim.fn.expand("%") } }) end,
                { desc = 'grug-far: Search selection in current file' }),

            vim.keymap.set('n', '<leader>si',
                function() require('grug-far').open({ prefills = { paths = vim.fn.expand("%") } }) end,
                { desc = 'grug-far: Search in current file' }),


            vim.keymap.set('n', '<leader>ss',
                function()
                    local bufname = vim.fn.expand("%")

                    require('grug-far').open({
                        prefills = {
                            paths = bufname,
                            search = "foo::(bar)( |>|,|&|\\*|\\{|\\(|::)",
                            replacement = "fizz::$1$2"
                        }
                    })

                    -- Uncomment to search/replace more than one pattern at the same time
                    -- require('grug-far').open({
                    --     prefills = {
                    --         paths = bufname,
                    --         search = "foo::(fizz)( |>|,|&|\\*|\\{|\\(|::)",
                    --         replacement = "buzz::$1$2"
                    --     }
                    -- })
                end,
                { desc = 'grug-far: Search in current file' }),
        }
    }
}
