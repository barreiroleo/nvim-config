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
    "gopls",                                       -- Go
    "eslint", "emmet_ls", "html",                  -- HTML
    "jdtls",                                       -- Java
    "ts_ls",                                       -- Js / Ts
    "jsonls",                                      -- Json
    "ltex", "texlab",                              -- Latex
    "lua_ls",                                      -- Lua
    "marksman",                                    -- Markdown
    "basedpyright",                                -- Python
    "rust_analyzer",                               -- Rust
    "sqlls",                                       -- SQL
}

Pack.dap = {
    'coreclr',              -- netcoredbg
    'cppdbg', 'codelldb',   -- Cpptool, codelldb
}

Pack.null_sources = {
    require("null-ls").builtins.code_actions.refactoring, -- Refactoring plug
    require("null-ls").builtins.diagnostics.trail_space,  -- Highlight trail_space
    -- require("null-ls").builtins.code_actions.gitsigns,    -- Code actions for gitsigns plug
}

Pack.lint_tools = {
    'cmakelint',
    'cpplint',
    'shellcheck',
    'hadolint',
    'jsonlint',
    'selene',
    'checkmake',
    'markdownlint',
    'sqlfluff',
}

Pack.format_tools = {
    'black',
    'stylua'
}
-- stylua: ignore end

return Pack
