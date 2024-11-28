-- https://github.com/llvm/llvm-project/blob/main/clang-tools-extra/clangd/tool/ClangdMain.cpp
-- https://github.com/llvm/llvm-project/blob/main/clang-tools-extra/clangd/CodeComplete.h

-- TEST:
-- local compilation_flags = {
--     "--compile-commands-dir='build'",
--     '--compile_args_from=' .. { "lsp", "filesystem" }, -- TEST: Default filesystem
--
--     '--j=8',                                           -- TEST: Unk def   - Number of async workers used by clangd. Background index also uses this many workers.
--     '--pch-storage=' .. { "disk", "memory" },          -- TEST: Def disk  - Storing PCHs in memory increases memory usages, but may improve performance
--     '--use-dirty-headers=true',                        -- Use files open in the editor when parsing headers instead of reading from the disk
-- }

return {
    on_attach = function(_client, bufnr)
        vim.keymap.set({ "n", "i" }, "<A-o>", "<cmd>ClangdSwitchSourceHeader<cr>",
            { desc = "Clang: Switch source/header", buffer = bufnr })
    end,

    init_options = {
        usePlaceholders = true,
        completeUnimported = true,
        clangdFileStatus = true,
    },

    cmd = vim.list_extend({ "clangd" }, {
        "--background-index",
        "--background-index-priority=background",
        "--clang-tidy",
        "--completion-style=detailed",
        "--function-arg-placeholders",
        "--header-insertion=never",
        "--log=error",
        "--malloc-trim",
        "--pch-storage=memory",

        "--fallback-style=webkit",
        '--offset-encoding=utf-16',
    }),
}
