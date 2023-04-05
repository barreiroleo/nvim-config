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
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    keys = { { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols LSP navigation" } },
    config = function()
        require("symbols-outline").setup({
            highlight_hovered_item = false,
            show_guides            = true,
            auto_preview           = false,
            position               = 'right',
            show_numbers           = false,
            show_relative_numbers  = false,
            show_symbol_details    = true,
            keymaps                = keymaps
        })
        vim.cmd("autocmd FileType Outline setlocal signcolumn=no")
        vim.notify("Migrate symbols-outline to another plug. There's so many issues", vim.log.levels.INFO)
    end,
}
