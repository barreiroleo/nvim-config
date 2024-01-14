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
    { "zef/vim-cycle" },
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
    },

    { "ThePrimeagen/harpoon", branch = "harpoon2",
        dependencies = "nvim-lua/plenary.nvim",
        config = function ()
            local harpoon = require("harpoon")
            harpoon:setup()

            vim.keymap.set("n", "<leader>a", function() harpoon:list():append() end, { desc = "Harpoon: Append" })
            vim.keymap.set("n", "<leader>we", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon: Toogle quick menu" })

            vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end, { desc = "Harpoon: Select 1" })
            vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end, { desc = "Harpoon: Select 2" })
            vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end, { desc = "Harpoon: Select 3" })
            vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end, { desc = "Harpoon: Select 4" })

            -- Toggle previous & next buffers stored within Harpoon list
            vim.keymap.set("n", "<leader>wd", function() harpoon:list():prev() end, { desc = "Harpoon: Previous" })
            vim.keymap.set("n", "<leader>wf", function() harpoon:list():next() end, { desc = "Harpoon: Next" })
        end
    }
}
