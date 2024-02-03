return {
    { "lervag/vimtex", enabled = false,
        ft = { "tex" },
        config = function()
            -- vim.g.vimtex_view_method = "sioyek"
            vim.g.maplocalleader = ","
            -- vim.g.vimtex_syntax_enabled = false
            -- vim.g.vimtex_syntax_conceal_disable = true
            -- vim.g.vimtex_compiler_latexmk = { build_dir = "../build" }
            vim.g.vimtex_format_enabled = true
        end,
    },
}
