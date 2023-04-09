return {
    { "windwp/nvim-autopairs",
        opts = { check_ts = true }
    },
    { "mbbill/undotree" },
    { "junegunn/vim-easy-align",
        keys = {
            { "ga", "<Plug>(EasyAlign)", mode = "n", desc = "EasyAlign in visual mode: e.g. vipga" },
            { "ga", "<Plug>(EasyAlign)", mode = "x", desc = "EasyAlign for a motion/text object (e.g. gaip)" }
        }
    },
    { "folke/todo-comments.nvim",
        dependencies = "nvim-lua/plenary.nvim",
    },
    { "tpope/vim-repeat" },
    { "zef/vim-cycle" },
    { "numToStr/Comment.nvim" },
    { "windwp/nvim-spectre",
        keys = {
            { "<leader>sr", function() require("spectre").open() end, desc = "Replace in files (Spectre)" },
        },
    },

    { "tpope/vim-surround",
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
