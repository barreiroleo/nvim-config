local mappings = require("plugins.treesitter.TS-keymaps").TS_refactor
local refactor = {}

-- Highlights definition and usages of the current symbol under the cursor.
refactor.highlight_definitions = {
    enable = true,
    -- Set to false if you have an `updatetime` of ~100.
    clear_on_cursor_move = true,
}


-- Highlights the block from the current scope where the cursor is.
refactor.highlight_current_scope = {
    enable = false
}


-- Renames the symbol under the cursor within the current scope (and current file).
refactor.smart_rename = {
    enable = true,
    keymaps = mappings.smart_rename,
}

-- Provides "go to definition" for the symbol under the cursor, and lists the
-- definitions from the current file. If you use goto_definition_lsp_fallback
-- instead of goto_definition in the config below vim.lsp.buf.definition is used
-- if nvim-treesitter can not resolve the variable. goto_next_usage/goto_previous_usage
-- go to the next usage of the identifier under the cursor.
refactor.navigation = {
    enable = true,
    keymaps = mappings.navigation,
}

return refactor
