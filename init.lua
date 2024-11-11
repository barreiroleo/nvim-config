vim.g.mapleader = ","

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
    vim.fn.system({ "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require("lazy").setup({
    spec = { { import = "plugins" }, },
    dev = {
        path = "~/develop/plugins/",
        patterns = { "barreiroleo" },
        fallback = true,
    },
    performance = {
        rtp = {
            disabled_plugins = {
                "gzip", "matchit", "matchparen", "tarPlugin", "tutor", "zipPlugin",
                -- "netrwPlugin", Needed to download the language spells automatically
                -- "tohtml", Needed to export lines with :tohtml
            },
        },
    },
})
