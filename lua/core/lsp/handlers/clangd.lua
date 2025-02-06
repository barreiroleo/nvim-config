-- https://github.com/llvm/llvm-project/blob/main/clang-tools-extra/clangd/tool/ClangdMain.cpp
-- https://github.com/llvm/llvm-project/blob/main/clang-tools-extra/clangd/CodeComplete.h
--
-- Clang-tidy: Clangd only supports "pure" matchers, not those based on clang static analyzer
-- https://github.com/clangd/clangd/issues/905

-- TEST:
-- local compilation_flags = {
--     '--use-dirty-headers=true',                        -- Use files open in the editor when parsing headers instead of reading from the disk
-- }

return {
    on_attach = function(_client, bufnr)
        vim.keymap.set({ "n", "i" }, "<A-o>", "<cmd>ClangdSwitchSourceHeader<cr>",
            { desc = "Clang: Switch source/header", buffer = bufnr })
        vim.treesitter.stop(bufnr)
    end,

    init_options = {
        usePlaceholders = true,
        completeUnimported = true,
        clangdFileStatus = true,
        -- Controls the flags used when no compile command is found. Like compile_flags.txt
        fallbackFlags = { '-std=c++23', "-stdlib=libc++" }
    },

    cmd = { "/usr/bin/clangd",
        "-j=10",
        "--background-index",
        "--background-index-priority=background",
        "--clang-tidy", -- Run through nvim-lint. See comment on top.
        "--completion-style=detailed",
        "--function-arg-placeholders",
        "--header-insertion=never",
        "--log=error",
        "--malloc-trim",
        "--pch-storage=memory",

        "--fallback-style=webkit",
        '--offset-encoding=utf-16',
    },
}
