return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
        local harpoon = require("harpoon")
        harpoon:setup({ default = { save_on_toggle = true } })

        local function harpoon_ns() return vim.api.nvim_create_namespace('harpoon_sign') end
        vim.api.nvim_set_hl(0, "HarpoonSign", { fg = "#8aadf4", bold = true })

        local function harpoon_sign(row)
            vim.api.nvim_buf_set_extmark(0, harpoon_ns(), row - 1, -1,
                {
                    sign_text = "",
                    sign_hl_group = "HarpoonSign",
                })
        end

        vim.api.nvim_create_autocmd({ "BufEnter" }, {
            pattern = "*",
            callback = function()
                vim.api.nvim_buf_clear_namespace(0, harpoon_ns(), 0, -1)
                local filename = vim.fn.expand("%:p:.")
                local harpoon_marks = harpoon:list().items
                for _, mark in ipairs(harpoon_marks) do
                    if mark.value == filename then
                        harpoon_sign(mark.context.row)
                        return
                    end
                end
            end,
        })

        local function harpoon_add()
            vim.api.nvim_buf_clear_namespace(0, harpoon_ns(), 0, -1)
            harpoon_sign(vim.fn.line("."))
            harpoon:list():append()
        end

        -- vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end, { desc = "Harpoon: Append" })
        vim.keymap.set("n", "<leader>a", harpoon_add, { desc = "Harpoon: Add", })
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
