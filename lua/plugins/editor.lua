return {
    { "windwp/nvim-autopairs",
        event = { "BufNewFile", "BufReadPre" },
        opts = { check_ts = true }
    },
    { "mbbill/undotree",
        event = { "BufNewFile", "BufReadPre" },
    },
    { "junegunn/vim-easy-align",
        keys = {
            { "ga", "<Plug>(EasyAlign)", mode = "n", desc = "EasyAlign in visual mode: e.g. vipga" },
            { "ga", "<Plug>(EasyAlign)", mode = "x", desc = "EasyAlign for a motion/text object (e.g. gaip)" }
        }
    },
    { "folke/todo-comments.nvim",
        event = { "BufNewFile", "BufReadPre" },
        dependencies = "nvim-lua/plenary.nvim",
        config = true,
    },
    { "tpope/vim-repeat",
        event = { "BufNewFile", "BufReadPre" },
    },
    { "zef/vim-cycle",
        event = { "BufNewFile", "BufReadPre" },
    },
    { "numToStr/Comment.nvim",
        event = { "BufNewFile", "BufReadPre" },
        config = true,
    },
    { "windwp/nvim-spectre",
        keys = {
            { "<leader>sr", function() require("spectre").open() end, desc = "Replace in files (Spectre)" },
        },
    },

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
    }
}
