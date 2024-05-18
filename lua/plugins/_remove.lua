return {
    -- {
    --     'windwp/nvim-spectre',
    --     keys = {
    --         { '<leader>sr', function() require('spectre').open() end, desc = 'Replace in files (Spectre)', },
    --     },
    -- },

    -- { "BarreiroLeo/harpoon", branch = "harpoon2",
    --     dependencies = "nvim-lua/plenary.nvim",
    --     config = function ()
    --         local harpoon = require("harpoon")
    --         harpoon:setup({ default = { save_on_toggle = true }})
    --
    --         local key = vim.keymap.set
    --         key("n", "<leader>a", function() harpoon:list():append() end, { desc = "Harpoon: Append" })
    --         key("n", "<leader>we", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon: Toogle quick menu" })
    --
    --         key("n", "<leader>1", function() harpoon:list():select(1) end, { desc = "Harpoon: Select 1" })
    --         key("n", "<leader>2", function() harpoon:list():select(2) end, { desc = "Harpoon: Select 2" })
    --         key("n", "<leader>3", function() harpoon:list():select(3) end, { desc = "Harpoon: Select 3" })
    --         key("n", "<leader>4", function() harpoon:list():select(4) end, { desc = "Harpoon: Select 4" })
    --
    --         -- Toggle previous & next buffers stored within Harpoon list
    --         key("n", "<leader>wd", function() harpoon:list():prev() end, { desc = "Harpoon: Previous" })
    --         key("n", "<leader>wf", function() harpoon:list():next() end, { desc = "Harpoon: Next" })
    --     end
    -- },

    -- -- Docs generation
    -- { "danymat/neogen",
    --     event = { "BufNewFile", "BufReadPre" },
    --     keys = {
    --         { "<leader>dg", ":lua require('neogen').generate()<CR>", mode = { "n", "v" }, desc = "Neogen: Generate docs" }
    --     },
    --     opts = { snippet_engine = "luasnip" }
    -- },
}
