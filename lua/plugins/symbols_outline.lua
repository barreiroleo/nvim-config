local map = require("core.utils").map

local keymaps = {
    close          = { "q" },
    goto_location  = "<Cr>",
    focus_location = "o",
    hover_symbol   = "<C-space>",
    toggle_preview = "K",
    rename_symbol  = "r",
    code_actions   = "a",
}

return {
    {
        "simrat39/symbols-outline.nvim",
        config = function()
            require("symbols-outline").setup({
                highlight_hovered_item = false,
                show_guides            = true,
                auto_preview           = false,
                position               = 'right',
                show_numbers           = true,
                show_relative_numbers  = true,
                show_symbol_details    = true,
                keymaps                = keymaps
            })
            map("n", "<leader>s", "<cmd>SymbolsOutline<CR>", { desc = "Symbols navigation" })
            P("Migrate symbols-outline to another plug. There's so many issues")
        end,
    },
}
