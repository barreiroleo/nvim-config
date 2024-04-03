local Pack = {}

-- Get the available servers to install with mason-lspconfig:
-- :lua P(require("mason-lspconfig").get_available_servers())
-- :put = execute('messages')

-- stylua: ignore start
Pack.lsp = {
    "bashls",                                      -- Bash
    "clangd",                                      -- C / C++
    "omnisharp",                                   -- C#
    "cmake",                                       -- Cmake
    "dockerls", "docker_compose_language_service", -- Docker
    "eslint", "emmet_ls", "html",                  -- HTML
    "jdtls",                                       -- Java
    "tsserver",                                    -- Js / Ts
    "jsonls",                                      -- Json
    "ltex", "texlab",                              -- Latex
    "lua_ls",                                      -- Lua
    "marksman",                                    -- Markdown
    "pyright", "ruff_lsp",                         -- Python
    "rust_analyzer",                               -- Rust
    "sqlls",                                       -- SQL
}

Pack.dap = {
    'bash_',
    'coreclr',                         -- netcoredbg
    'cppdbg', 'codelldb',              -- Cpptool, codelldb
    'javadbg', 'javatest',             -- Java
    'node2', 'js', 'chrome', 'firefox',
    'python',                          --debugpy
}

Pack.null_sources = {
    require("null-ls").builtins.code_actions.refactoring, -- Refactoring plug
    require("null-ls").builtins.diagnostics.trail_space,  -- Highlight trail_space
    require("null-ls").builtins.code_actions.gitsigns,    -- Code actions for gitsigns plug
}

Pack.lint_tools = {
    'cmakelint',
    'shellcheck',
    'hadolint',
    'jsonlint',
    'selene',
    'checkmake',
    'markdownlint',
    'mypy', 'pylint', 'vulture',
    'sqlfluff',
}

Pack.format_tools = {
    "stylua"
}
-- stylua: ignore end

return Pack
