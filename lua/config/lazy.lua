local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
    vim.fn.system({ "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require("lazy").setup({
    spec = {
        -- To test imports
        -- { "LazyVim/LazyVim", import = "lazyvim.plugins.extras.ui.mini-animate" },
        { import = "plugins" },
    },
    dev = {
        path = "~/develop/plugins/",  -- directory where are local plugins
        patterns = { "barreiroleo" }, -- plugins that match these patterns will use local versions
        fallback = false,             -- Fallback to git when local plugin doesn't exist
    },
    defaults = { lazy = false, version = false },
    install = { colorscheme = { "habamax" } },
    checker = { enabled = true },
    performance = {
        rtp = {
            disabled_plugins = {
                "gzip",
                "matchit",
                "matchparen",
                -- "netrwPlugin", -- Needed to open urls with gx
                "tarPlugin",
                -- "tohtml", -- needed to export lines with :tohtml
                "tutor",
                "zipPlugin",
            },
        },
    },
})
