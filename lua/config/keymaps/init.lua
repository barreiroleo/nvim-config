-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- This file is automatically loaded by lazyvim.plugins.config

require("config.keymaps.general")
require("config.keymaps.interface")
require("config.keymaps.behaviour")

local opts = { noremap = true, silent = true }
-- vim.api.nvim_set_keymap('n', '<leader>e',  ":lua vim.diagnostic.open_float()<CR>",  opts)
-- vim.api.nvim_set_keymap('n', '[d',        ":lua vim.diagnostic.goto_prev()<CR>",   opts)
-- vim.api.nvim_set_keymap('n', ']d',        ":lua vim.diagnostic.goto_next()<CR>",   opts)
-- vim.api.nvim_set_keymap('n', '<leader>q',  ":lua vim.diagnostic.setloclist()<CR>",  opts)
