local keymaps = {}

keymaps.basics = {
    init_selection    = "gnn",
    node_incremental  = "grn",
    scope_incremental = "grc",
    node_decremental  = "grm",
}

keymaps.refactor = {
    smart_rename = {
        smart_rename = "grr",
    },
    navigation = {
        goto_definition      = "gnd",
        list_definitions     = "gnD",
        list_definitions_toc = "gO",
        goto_next_usage      = "<a-*>",
        goto_previous_usage  = "<a-#>",
    }
}

keymaps.textobjects = {
    select = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
    },
    swap_next = {
        ["<leader>a"] = "@parameter.inner",
    },
    swap_previous = {
        ["<leader>A"] = "@parameter.inner",
    },
    goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
    },
    goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
    },
    goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
    },
    goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
    },
    peek_definition_code = {
        ["<leader>df"] = "@function.outer",
        ["<leader>dF"] = "@class.outer",
    }
}

return keymaps
