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
    { 'weirongxu/plantuml-previewer.vim', lazy = true,
        ft = { 'plantuml', 'puml', 'uml', 'md' },
        dependencies = {
            'tyru/open-browser.vim',
            'aklt/plantuml-syntax',
        },
        init = function()
            -- Custom filetypes
            vim.filetype.add({
                extension = {
                    puml = function(path, bufnr) return 'plantuml' end
                }
            })
        end,
        config = function()
            vim.g.plantuml_previewer = { plantuml_jar_path = vim.fs.normalize('~/.local/bin/plantuml.jar') }
            vim.g.plantuml_previewer = { save_format = 'svg' }
            vim.g.plantuml_previewer = { debug_mode = 1 }
        end,
    },
}
