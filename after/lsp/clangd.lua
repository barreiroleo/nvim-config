-- https://github.com/llvm/llvm-project/blob/main/clang-tools-extra/clangd/tool/ClangdMain.cpp
-- https://github.com/llvm/llvm-project/blob/main/clang-tools-extra/clangd/CodeComplete.h
--
-- Clang-tidy: Clangd only supports "pure" matchers, not those based on clang static analyzer
-- https://github.com/clangd/clangd/issues/905

-- local compilation_flags = {
--     -- Use files open in the editor when parsing headers instead of reading from the disk
--     '--use-dirty-headers=true',
-- }

-- NOTE: Legacy lsp-config
-- on_attach = function(_client, bufnr)
--     local commands = require("lspconfig.configs.clangd").commands
--     vim.keymap.set({ "n", "i" }, "<A-o>", commands.ClangdSwitchSourceHeader[1],
--         { desc = "Clang: Switch source/header", buffer = bufnr })
--     vim.keymap.set({ "n", "i" }, "<leader>k", commands.ClangdShowSymbolInfo[1],
--         { desc = "Clang: Show symbol info", buffer = bufnr })
-- end,

require("core.lsp.on_attach_fn").on_attach_client_name("clangd",
    function(autocmd_args, on_attach_args)
        vim.keymap.set({ "n", "i" }, "<A-o>", "<cmd>LspClangdSwitchSourceHeader<cr>",
            { desc = "Clang: Switch source/header", buffer = autocmd_args.buf })
        vim.keymap.set({ "n", "i" }, "<leader>k", "<cmd>LspClangdShowSymbolInfo<cr>",
            { desc = "Clang: Show symbol info", buffer = autocmd_args.buf })
    end
)

return {
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
