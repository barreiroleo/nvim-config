-- TODO: Would be nice migrate to a config like { "eslint_d", { code_action, diagnostics } }
-- Using the key and values to build something like null_ls.builtins[sourcetype][tool]
-- Check: github.com/jinzhongjia/neovim-config/blob/lsp/lua/plugin-config/mason/null-ls/list.lua

local null_ls = require("null-ls")

return{
    null_ls.builtins.code_actions.refactoring, -- Refactoring plug
    null_ls.builtins.diagnostics.trail_space,  -- Highlight trail_space
    null_ls.builtins.code_actions.gitsigns,    -- Code actions for gitsigns plug
    null_ls.builtins.diagnostics.commitlint,   -- Check conventional commit format

    -- BASH
    ["beautysh"] = null_ls.builtins.formatting.beautysh,
    ["shellcheck"] = null_ls.builtins.code_actions.shellcheck,
    ["shfmt"] = null_ls.builtins.formatting.shfmt,

    -- C / C++ / C#
    -- ["cpplint"] = null_ls.builtins.diagnostics.cpplint,
    null_ls.builtins.diagnostics.clang_check,
    null_ls.builtins.diagnostics.cppcheck,

    -- CMake / Make
    null_ls.builtins.diagnostics.checkmake,
    -- ["cmake_lint"] = null_ls.builtins.diagnostics.cmake_lint,
    -- ["cmake_format"] = null_ls.builtins.formatting.cmake_format,

    -- C#
    -- ["csharpier"] = null_ls.builtins.formatting.csharpier,

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
