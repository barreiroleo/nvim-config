-- https://github.com/llvm/llvm-project/blob/main/clang-tools-extra/clangd/tool/ClangdMain.cpp
-- https://github.com/llvm/llvm-project/blob/main/clang-tools-extra/clangd/CodeComplete.h

local randomized = {}
---@param opts table<string>
local function pick_str(opts)
    local idx = math.random(table.maxn(opts))
    vim.list_extend(randomized, { opts[idx] })
    return opts[idx]
end

local compilation_flags = {
    "--compile-commands-dir='build'",
    '--compile_args_from=' .. pick_str { "lsp", "filesystem" }          -- TEST: Default filesystem
}

local feature = {
    '--all-scopes-completion=false',
    '--clang-tidy=true',
    '--completion-parse=auto',                                          -- Run parser if preamble are ready. Otherwise, text-based completion.
    '--completion-style=bundled',                                       -- Pack overloads for instance

    '--fallback-style=webkit',                                          -- "{BasedOnStyle: LLVM, IndentWidth: 4}" is incompatible with .clang-format files
    '--hidden-features',                                                -- TEST: Def false - Enable hidden features mostly useful to clangd developers
    '--import-insertions=true',                                         -- TEST: Def false - If header insertion is enabled, add #import directives when accepting code completions or fixing includes in Objective-C code
    '--header-insertion-decorators=false',                              -- https://github.com/hrsh7th/nvim-cmp/issues/999#issuecomment-1130074680
    '--include-ineligible-results=true',                                -- TEST: Def false - Include ineligible completion results (e.g. private members)
    '--ranking-model=' .. pick_str { "heuristics", "decision_forest" }, -- TEST: Def decision_forest - Model to use to rank code-completion items
}

local miscellaneous = {
    '--j=8',                                                            -- TEST: Unk def   - Number of async workers used by clangd. Background index also uses this many workers.
    '--pch-storage=' .. pick_str { "disk", "memory" },                  -- TEST: Def disk  - Storing PCHs in memory increases memory usages, but may improve performance
    '--sync',                                                           -- TEST: Def false - Handle client requests on main thread. Background index still uses its own thread.
    '--use-dirty-headers=true',                                         -- Use files open in the editor when parsing headers instead of reading from the disk
    '--offset-encoding=utf-16',                                         -- temporary fix for null-ls
}

local protocol_and_logging = {
    '--log=' .. pick_str { "error", "info", "verbose" },                -- TEST: Def info  - Verbosity of log messages written to stderr
}

-- P(vim.list_extend({ "clangd" }, vim.tbl_flatten { compilation_flags, feature, miscellaneous, protocol_and_logging }))
-- "clangd --compile-commands-dir='build' --compile_args_from=filesystem --all-scopes-completion=false --clang-tidy=true --completion-parse=never --completion-style=detailed --debug-origin=true --fallback-style='{Base dOnStyle: LLVM, IndentWidth: 4}' --header-insertion-decorators=false --hidden-features --import-insertions=true --include-ineligible-results=true --ranking-model=heuristics --j=8 --pch-storage=memory --sync --use- dirty-headers=true --offset-encoding=utf-16 --log=info"

return {
    randomized = randomized,
    flags = vim.list_extend({ "clangd" }, vim.tbl_flatten { compilation_flags, feature, miscellaneous, protocol_and_logging })
}
