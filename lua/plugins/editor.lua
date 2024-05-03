return {
    { "windwp/nvim-autopairs",
        event = { "BufNewFile", "BufReadPre" },
        opts = { check_ts = true }
    },
    { "folke/todo-comments.nvim",
        event = { "BufNewFile", "BufReadPre" },
        dependencies = "nvim-lua/plenary.nvim",
        config = true,
    },
    { "zef/vim-cycle" },
    { "numToStr/Comment.nvim",
        event = { "BufNewFile", "BufReadPre" },
        config = true,
    },
    { 'tpope/vim-repeat',event = { 'BufNewFile', 'BufReadPre' } },
    { "tpope/vim-surround",
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
}
