local mappings = require("plugins.treesitter.keymaps").refactor

local M = {
    ["refactor"] = {
        -- Highlights definition and usages of the current symbol under the cursor.
        highlight_definitions = {
            enable = true,
            -- Set to false if you have an `updatetime` of ~100.
            clear_on_cursor_move = true,
        },

        -- Highlights the block from the current scope where the cursor is.
        highlight_current_scope = {
            enable = true
        },

        -- Renames the symbol under the cursor within the current scope (and current file).
        smart_rename = {
            enable = true,
            keymaps = mappings.smart_rename,
        },

        -- Provides "go to definition" for the symbol under the cursor, and lists the
        -- definitions from the current file. If you use goto_definition_lsp_fallback
        -- instead of goto_definition in the config below vim.lsp.buf.definition is used
        -- if nvim-treesitter can not resolve the variable. goto_next_usage/goto_previous_usage
        -- go to the next usage of the identifier under the cursor.
        navigation = {
            enable = true,
            keymaps = mappings.navigation,
        }
    }
}

return M
