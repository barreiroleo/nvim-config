-- Credits to: https://github.com/evelez7/auto-switch-theme.nvim

local M = {}

local function apply_theme(background)
    local user_colorscheme = M.config[background]
    if (user_colorscheme) then
        vim.cmd.colorscheme(user_colorscheme)
    end
end

local function setup_background_watcher()
    vim.api.nvim_create_autocmd("OptionSet", {
        pattern = "background",
        desc = "Auto switch colorscheme on background change",
        callback = function()
            vim.notify("Auto switch colorscheme on background change", vim.log.levels.INFO)
            apply_theme(vim.o.background)
        end,
    })
end

local function setup_theme_switcher()
    vim.api.nvim_create_user_command("ColorschemeSwitch", function(opts)
        local _ = opts.args
        local target = (vim.o.background == "dark") and "light" or "dark"
        vim.o.background = target
    end, {
        nargs = 0,
        desc = "Toggle between light and dark theme",
    })
end

--- =======================================================================
--- External API
--- =======================================================================

M.config = {
    light = "default",
    dark = "default",
}

function M.setup(opts)
    M.config = vim.tbl_extend("force", M.config, opts or {})
    setup_background_watcher()
    setup_theme_switcher()
    apply_theme(vim.o.background)
end

function M.lazy_setup(opts)
    vim.api.nvim_create_autocmd("User", {
        pattern = "LazyDone",
        callback = function()
            require("core.utils.auto-switch-theme").setup(opts)
        end
    })
end


return M
