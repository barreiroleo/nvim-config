return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = "nvim-lua/plenary.nvim",

    config = function()
        require("harpoon"):setup({ settings = { save_on_toggle = true } })
    end,

    keys = {
        { "<leader>we", function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end, { desc = "Harpoon: Toogle quick menu" } },
        { "<leader>wd", function() require("harpoon"):list():prev() end,                                   { desc = "Harpoon: Previous" } },
        { "<leader>wf", function() require("harpoon"):list():next() end,                                   { desc = "Harpoon: Next" } },

        { "<leader>a",  function() require("harpoon"):list():add() end,                                    { desc = "Harpoon: Add" } },
        { "<leader>1",  function() require("harpoon"):list():select(1) end,                                { desc = "Harpoon: Select 1" } },
        { "<leader>2",  function() require("harpoon"):list():select(2) end,                                { desc = "Harpoon: Select 2" } },
        { "<leader>3",  function() require("harpoon"):list():select(3) end,                                { desc = "Harpoon: Select 3" } },
        { "<leader>4",  function() require("harpoon"):list():select(4) end,                                { desc = "Harpoon: Select 4" } },
        { "<leader>5",  function() require("harpoon"):list():select(5) end,                                { desc = "Harpoon: Select 5" } },
    }
}
