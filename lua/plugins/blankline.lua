return {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPre",
    config = function()
        -- vim.cmd([[ highlight IndentBlanklineChar guifg=#00FF00 gui=nocombine ]])     -- No active highlight.
        vim.cmd([[ highlight IndentBlanklineContextChar guifg=#909090 gui=nocombine ]]) -- Active highlight.

        require("indent_blankline").setup {
            use_treesitter_scope = true,
            show_current_context = true,
            show_current_context_start = false, -- Don't underline start scope.
            show_first_indent_level = true,
            show_trailing_blankline_indent = false, -- No highlight empty lines.

            char = "│",
            space_char_blankline = " ",

            enabled = true,
            colored_indent_levels = true
        }

        -- vim.g.indent_blankline_buftype_exclude = {
        --     "terminal", "nofile"
        -- }
        -- vim.g.indent_blankline_filetype_exclude = {
        --     "help", "startify", "dashboard", "packer", "neogitstatus", "NvimTree", "Trouble",
        -- }
        -- vim.g.indent_blankline_context_patterns = {
        --     "class", "return", "function", "method", "^if",
        --     "^while", "jsx_element", "^for", "^object", "^table",
        --     "block", "arguments", "if_statement", "else_clause",
        --     "jsx_element", "jsx_self_closing_element", "try_statement",
        --     "catch_clause", "import_statement", "operation_type",
        -- }
    end
}
