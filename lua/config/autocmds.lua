local function augroup(name)
    return vim.api.nvim_create_augroup("UserAutocmd_" .. name, { clear = false })
end

-- Highlight yanked content
vim.api.nvim_create_autocmd("TextYankPost", {
    group = augroup("HighlightYank"),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- -- Resize splits if window got resized
-- vim.api.nvim_create_autocmd({ "VimResized" }, {
--     -- group = augroup("resize_splits"),
--     group = augroup_id,
--     callback = function()
--         vim.cmd("tabdo wincmd =")
--     end,
-- })

-- -- Create a new window when deleting the last buffer
-- vim.api.nvim_create_autocmd({ "BufDelete" }, {
--     group = augroup("LastBuffer"),
--     callback = function()
--         vim.cmd("if len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 0 | enew | endif")
--     end,
-- })

-- Remove trailing space on save
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    group = augroup("RemoveTrailingSpaces"),
    callback = function()
        vim.cmd [[%s/\s\+$//e]]
    end,
})

-- Close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
    group = augroup("CloseWith<q>"),
    pattern = {
        -- Vim native: <cmd>help, <cmd>Man, <cmd>messages, Quickfix
        "help", "man", "notify", "qf", "lspinfo",
        -- Treesitter: <cmd>InspectTree,
        "query", "tsplayground",
        -- Spectre search and replace
        "spectre_panel",
        -- Debug REPL
        "dap-repl",
        -- dadbod UI
        "dbui", "dbout",
        -- NeoTest
        "neotest-output", "neotest-summary",
        -- Others
        "PlenaryTestPopup", "startuptime",
        "fugitive"
    },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
    end,
})

-- Reload tmux on tmux.conf save
vim.api.nvim_create_autocmd("BufWritePost", {
    group = augroup("TmuxReload"),
    pattern = { "tmux.conf" },
    callback = function()
        vim.cmd("silent !tmux source-file ~/.config/tmux/tmux.conf ';' display 'Reloaded'")
    end,
})

-- Set wrap and spellcheckss
vim.api.nvim_create_autocmd("FileType", {
    group = augroup("SetSpell"),
    pattern = { "gitcommit", "markdown", "md", "text", "txt" },
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
    end,
})

-- Load the template file when create a new file (:e file / :n file)
vim.api.nvim_create_autocmd("BufNewFile", {
    group = augroup("TemplateNewFile"),
    pattern = { "*.cpp" },
    callback = function()
        vim.api.nvim_put(require("core.utils.ReadFile")(vim.fn.stdpath("config") .. "/templates/a.cpp"), "l", false, true)
    end
})


-- -- Highlight search results only in search mode.
-- ---@format disable-next
-- vim.api.nvim_create_autocmd("CmdlineEnter", { group = augroup("HighlightSearch"), pattern = { "/", "\\?" }, command = "set hlsearch" })
-- ---@format disable-next
-- vim.api.nvim_create_autocmd("CmdlineLeave", { group = augroup("HighlightSearch"), pattern = { "/", "\\?" }, command = "set nohlsearch" })

-- Disable smartcase for command line
---@format disable-next
vim.api.nvim_create_autocmd("CmdlineEnter", { group = augroup("NoSmartcaseInCmdline"), pattern = { ":" }, command = "set nosmartcase" })
---@format disable-next
vim.api.nvim_create_autocmd("CmdlineLeave", { group = augroup("NoSmartcaseInCmdline"), pattern = { ":" }, command = "set smartcase" })
