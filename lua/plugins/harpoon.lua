return {
    "ThePrimeagen/harpoon",
    event = { "BufNewFile", "BufReadPre" },
    branch = "harpoon2",
    dependencies = "nvim-lua/plenary.nvim",

    config = function()
        local harpoon = require("harpoon")
        harpoon:setup({ settings = { save_on_toggle = true } })

        vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end, { desc = "Harpoon: Add", })

        vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end, { desc = "Harpoon: Select 1" })
        vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end, { desc = "Harpoon: Select 2" })
        vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end, { desc = "Harpoon: Select 3" })
        vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end, { desc = "Harpoon: Select 4" })

        -- Toggle previous & next buffers stored within Harpoon list
        vim.keymap.set("n", "<leader>wd",function() harpoon:list():prev() end, { desc = "Harpoon: Previous" })
        vim.keymap.set("n", "<leader>wf",function() harpoon:list():next() end, { desc = "Harpoon: Next" })
    end,
    keys = {
        { "<leader>we", function() local harpoon = require("harpoon") harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon: Toogle quick menu" } }
    }
}
