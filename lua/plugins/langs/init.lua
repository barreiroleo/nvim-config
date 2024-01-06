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

    { "Civitasv/cmake-tools.nvim", lazy = true,
        ft = { "cmake", "make", "c", "cpp" },
        cmd = { "CMakeGenerate", "CMakeBuild", "CMakeRun", "CMakeRunTest" }
    },

    -- Writing
    { import = "plugins.langs.ltex_extra" },
    -- Markdown
    { import = "plugins.langs.markdown" },
    -- Latex
    { import = "plugins.langs.latex" },
    -- PlantUML
    { 'scrooloose/vim-slumlord', lazy = true,
        ft = { 'puml', 'uml', 'md' }
    },
    { 'weirongxu/plantuml-previewer.vim', lazy = true,
        ft = { 'puml', 'uml', 'md' },
        dependencies = {
            'tyru/open-browser.vim',
            'aklt/plantuml-syntax',
        },
        config = function()
            vim.cmd [[
            let g:plantuml_previewer#plantuml_jar_path = '~/.local/bin/plantuml.jar'
            let g:plantuml_previewer#save_format = 'svg'
            ]]
        end,
    },
}
