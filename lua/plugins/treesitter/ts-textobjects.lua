local mappings = require("plugins.treesitter.keymaps").textobjects

local M = {
    ["textobjects"] = {
        select = {
            enable = true,
            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,
            keymaps = mappings.select,
        },

        swap = {
            enable        = true,
            swap_next     = mappings.swap_next,
            swap_previous = mappings.swap_previous,
        },

        move = {
            enable              = true,
            set_jumps           = true, -- whether to set jumps in the jumplist
            goto_next_start     = mappings.goto_next_start,
            goto_next_end       = mappings.goto_next_end,
            goto_previous_start = mappings.goto_previous_start,
            goto_previous_end   = mappings.goto_previous_end,
        },

        lsp_interop = {
            enable = true,
            border = 'none',
            peek_definition_code = mappings.peek_definition_code,
        }
    }
}

return M
