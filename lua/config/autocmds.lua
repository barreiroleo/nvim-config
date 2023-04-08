-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local function augroup(name)
    return vim.api.nvim_create_augroup("ConfigAutocmds " .. name, { clear = true })
end

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    group = augroup("highlight_yank"),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- Resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
    group = augroup("resize_splits"),
    callback = function()
        vim.cmd("tabdo wincmd =")
    end,
})

-- Delete undesired spaces on save
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    group = augroup("spaces"),
    callback = function()
        vim.cmd [[%s/\s\+$//e]]
    end,
})

-- Close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
    group = augroup("close_with_q"),
    pattern = {
        -- Vim native: <cmd>help, <cmd>Man, <cmd>messages, Quickfix
        "help", "man", "notify", "qf", "lspinfo",
        -- Treesitter: <cmd>InspectTree,
        "query", "tsplayground",
        -- Spectre search and replace
        "spectre_panel",
        -- Debug REPL
        "dap-repl",
        -- Others
        "PlenaryTestPopup", "startuptime",
    },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
    end,
})

-- Reload tmux on tmux.conf save
vim.api.nvim_create_autocmd("BufWritePost", {
    group = augroup("tmux_reload"),
    pattern = { "tmux.conf" },
    callback = function()
        vim.cmd("silent !tmux source-file ~/.config/tmux/tmux.conf ';' display 'Reloaded'")
    end,
})

-- FIX: wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
    group = augroup("wrap_spell"),
    pattern = { "gitcommit", "markdown", "md", "text", "txt" },
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
    end,
})
