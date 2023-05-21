local null_ls = require("null-ls")
local Pack = {}

-- Get the available servers to install with mason-lspconfig:
-- :lua P(require("mason-lspconfig").get_available_servers())
-- :put = execute('messages')

Pack.lsp = {
    "arduino_language_server",                 -- Arduino
    "bashls",                                  -- Bash
    "clangd",                                  -- C / C++
    "omnisharp",                               -- C#
    "cmake",                                   -- Cmake
    "dockerls", "docker_compose_language_service", -- Docker
    "eslint", "emmet_ls", "html",              -- HTML
    "jdtls",                                   -- Java
    "tsserver",                                -- Js / Ts
    "jsonls",                                  -- Json
    "ltex", "texlab",                          -- Latex
    "lua_ls",                                  -- Lua
    "marksman",                                -- Markdown
    "pyright", "ruff_lsp",                     -- Python
    "rust_analyzer",                           -- Rust
    "sqlls",                                   -- SQL
    "taplo",                                   -- TOML
    "vimls",                                   -- VimL
    "yamlls",                                  -- YAML
}

-- Use dap adapter names, not mason.nvim package names.
-- See the keys in require("mason-nvim-dap.mappings.source")
Pack.dap = {
    'bash',
    'coreclr',             -- netcoredbg
    'cppdbg', 'codelldb',  -- Cpptool, codelldb
    'javadbg', 'javatest', -- Java
    'node2', 'js', 'chrome', 'firefox',
    'python',              --debugpy
}

-- TODO: Would be nice migrate to a config like { "eslint_d", { code_action, diagnostics } }
-- Using the key and values to build something like null_ls.builtins[sourcetype][tool]
-- Check: github.com/jinzhongjia/neovim-config/blob/lsp/lua/plugin-config/mason/null-ls/list.lua
local off_lsp = {
    null_ls.builtins.code_actions.refactoring, -- Refactoring plug
    null_ls.builtins.diagnostics.trail_space,  -- Highlight trail_space
    null_ls.builtins.code_actions.gitsigns,    -- Code actions for gitsigns plug
    null_ls.builtins.diagnostics.commitlint,   -- Check conventional commit format

    -- BASH
    ["beautysh"] = null_ls.builtins.formatting.beautysh,
    ["shellcheck"] = null_ls.builtins.code_actions.shellcheck,
    ["shfmt"] = null_ls.builtins.formatting.shfmt,

    -- C / C++ / C#
    ["clang-format"] = null_ls.builtins.formatting.clang_format.with {
        -- BTDS_Yes: Always break after template declaration
        extra_args = { '-style', '{BasedOnStyle: Google, IndentWidth: 4, AlwaysBreakTemplateDeclarations: Yes, ColumnLimit: 100}' },
    },
    ["cpplint"] = null_ls.builtins.diagnostics.cpplint,
    null_ls.builtins.diagnostics.clang_check,
    null_ls.builtins.diagnostics.cppcheck,

    -- CMake / Make
    -- null_ls.builtins.diagnostics.checkmake,
    -- ["cmake_lint"] = null_ls.builtins.diagnostics.cmake_lint,
    -- ["cmake_format"] = null_ls.builtins.formatting.cmake_format,

    -- C#
    ["csharpier"] = null_ls.builtins.formatting.csharpier,

    -- Docker
     ["hadolint"] = null_ls.builtins.diagnostics.hadolint,

    -- HTML / JS
    -- ["prettierd"] = null_ls.builtins.formatting.prettierd, -- TSServer is better
    ["eslint_d"] = null_ls.builtins.code_actions.eslint_d, null_ls.builtins.diagnostics.eslint_d , -- null_ls.builtins.formatting.eslint_d,

    -- Json
    ["fixjson"] = null_ls.builtins.formatting.fixjson,
    ["jq"] = null_ls.builtins.formatting.jq,
    ["jsonlint"] = null_ls.builtins.diagnostics.jsonlint,

    -- Lua
    ["selene"] = null_ls.builtins.diagnostics.selene,
    ["stylua"] = null_ls.builtins.formatting.stylua,

    -- Markdown
    ["markdownlint"] = null_ls.builtins.diagnostics.markdownlint,
    -- ["ocdc"] = null_ls.builtins.formatting.ocdc, -- Changelog formatter

    -- Python:
    -- ruff linter as lsp. Don't cover pylint yet
    ["mypy"] = null_ls.builtins.diagnostics.mypy,       -- Type checker
    ["pylint"] = null_ls.builtins.diagnostics.pylint,   -- Linter and refactors
    ["vulture"] = null_ls.builtins.diagnostics.vulture, -- Dead code analysis
    ["yapf"] = null_ls.builtins.formatting.yapf.with {
        extra_args = { "--style={based_on_style: pep8, indent_width: 4}" }
    },

    -- Rust
    ["rustfmt"] = null_ls.builtins.formatting.rustfmt,

    -- Latex
    -- null_ls.builtins.formatting.bibclean,
    -- null_ls.builtins.diagnostics.chktex,
    ["latexindent"] = null_ls.builtins.formatting.latexindent,

    -- SQL
    ["sqlfluff"] = null_ls.builtins.diagnostics.sqlfluff.with({
        extra_args = { "--dialect", "sqlite" }, -- mandatory
    }),
    null_ls.builtins.formatting.sqlfluff.with({
        extra_args = { "--dialect", "sqlite" },
    }),

    -- VimL
    ["vint"] = null_ls.builtins.diagnostics.vint,
}

Pack.null_tools = vim.tbl_filter(function (key) return type(key) == "string" end, vim.tbl_keys(off_lsp) )
Pack.null_sources = vim.tbl_values(off_lsp)

return Pack
