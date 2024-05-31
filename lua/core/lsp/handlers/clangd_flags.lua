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
    '--compile_args_from=' .. pick_str { "lsp", "filesystem" } -- TEST: Default filesystem
    -- '--compile_args_from=' .. "filesystem"                  -- TEST: Default filesystem
}

local feature = {
    '--all-scopes-completion=true',
    '--fallback-style=webkit',                                          -- "{BasedOnStyle: LLVM, IndentWidth: 4}" is incompatible with .clang-format files
    '--header-insertion-decorators=false',                              -- https://github.com/hrsh7th/nvim-cmp/issues/999#issuecomment-1130074680
    '--ranking-model=' .. pick_str { "heuristics", "decision_forest" }, -- TEST: Def decision_forest - Model to use to rank code-completion items
}

local miscellaneous = {
    '--j=8',                                           -- TEST: Unk def   - Number of async workers used by clangd. Background index also uses this many workers.
    '--pch-storage=' .. pick_str { "disk", "memory" }, -- TEST: Def disk  - Storing PCHs in memory increases memory usages, but may improve performance
    '--sync',                                          -- TEST: Def false - Handle client requests on main thread. Background index still uses its own thread.
    '--use-dirty-headers=true',                        -- Use files open in the editor when parsing headers instead of reading from the disk
    '--offset-encoding=utf-16',                        -- temporary fix for null-ls
}

local protocol_and_logging = {
    -- '--log=verbose', -- TEST: Def info  - Verbosity of log messages written to stderr
}

return {
    randomized = randomized,
    flags = vim.list_extend({ "clangd" }, vim.iter({ compilation_flags, feature, miscellaneous, protocol_and_logging }):flatten():totable())
}
