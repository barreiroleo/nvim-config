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
    ["shfmt"] = null_ls.builtins.formatting.shfmt,

    -- C / C++ / C#
    null_ls.builtins.diagnostics.cppcheck,

    -- CMake / Make
    null_ls.builtins.diagnostics.checkmake,
    -- ["cmake_lint"] = null_ls.builtins.diagnostics.cmake_lint,
    -- ["cmake_format"] = null_ls.builtins.formatting.cmake_format,

    -- Docker
    ["hadolint"] = null_ls.builtins.diagnostics.hadolint,

    -- Lua
    ["stylua"] = null_ls.builtins.formatting.stylua,

    -- Markdown
    ["markdownlint"] = null_ls.builtins.diagnostics.markdownlint,
    -- ["ocdc"] = null_ls.builtins.formatting.ocdc, -- Changelog formatter

    -- Python:
    -- ruff linter as lsp. Don't cover pylint yet
    ["mypy"] = null_ls.builtins.diagnostics.mypy,       -- Type checker
    ["pylint"] = null_ls.builtins.diagnostics.pylint,   -- Linter and refactors
    ["yapf"] = null_ls.builtins.formatting.yapf.with {
        extra_args = { "--style={based_on_style: pep8, indent_width: 4}" }
    },

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
