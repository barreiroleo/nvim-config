-- vim.deprecate = function() end

-- Fix the behaviour of alacritty restoring the cursor style after Leave or Suspend vim
local std_cursor = vim.o.guicursor
vim.cmd([[au VimEnter,VimResume * set guicursor=]] .. std_cursor)
vim.cmd [[au VimLeave,VimSuspend * set guicursor=a:ver90]]

-- bootstrap lazy.nvim, LazyVim and your plugins
require 'config'
