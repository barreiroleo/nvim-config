return {
    -- Java
    -- { 'mfussenegger/nvim-jdtls', ft = "java",
    --     enable = false,
    --     config = function()
    --         local config = {
    --             cmd = { vim.fn.stdpath("data") .. '/mason/bin/jdtls' },
    --             root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', '.git', 'mvnw', 'pom.xml' }, { upward = true })[1]),
    --         }
    --         require('jdtls').start_or_attach(config)
    --     end
    -- },
    -- Rust
    { 'rust-lang/rust.vim', ft = "rust" },

    -- Writing
    { import = "plugins.langs.ltex_extra" },
    -- Markdown
    { import = "plugins.langs.markdown" },
    -- Latex
    { import = "plugins.langs.latex" },
    -- PlantUML
    { "scrooloose/vim-slumlord",
        dependencies = "aklt/plantuml-syntax",
        ft = { "puml", "uml" }
    },
}
