return {
    -- Java
    { 'mfussenegger/nvim-jdtls' },
    -- Rust
    { 'rust-lang/rust.vim' },

    -- Markdown
    { import = "plugins.langs.markdown" },
    -- Latex
    { import = "plugins.langs.latex" },

    -- { "~/develop/proyects/plugins/ltex_extra.nvim" },
    { "barreiroleo/ltex_extra.nvim",
        ft = { "markdown", "tex" }
    },
}
