local null_ls = require("null-ls")

return{
    null_ls.builtins.code_actions.refactoring, -- Refactoring plug
    null_ls.builtins.diagnostics.trail_space,  -- Highlight trail_space
    null_ls.builtins.code_actions.gitsigns,    -- Code actions for gitsigns plug
}
