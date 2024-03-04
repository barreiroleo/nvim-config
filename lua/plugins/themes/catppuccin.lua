-- Themes: latte, frappe, macchiato, mocha
-- ~/.local/share/nvim/lazy/catppuccin/lua/catppuccin/palettes/mocha.lua | base, mantle, crust
local flavour_dark = 'mocha'
local flavour_light = 'latte'
local transparent = true

-- AutoLightDark switch colorscheme
local function AutoLightDark()
    vim.api.nvim_create_autocmd('OptionSet', {
        group = vim.api.nvim_create_augroup("CatppuccinAfterUser", { clear = true }),
        pattern = 'background',
        callback = function()
            vim.cmd('Catppuccin ' .. (vim.v.option_new == 'light' and flavour_light or flavour_dark))
        end,
    })
end

---@param _transparent boolean
local function setup_tscontext_hl(_transparent)
    local palette = require('catppuccin.palettes').get_palette(flavour_dark)
    if _transparent then palette.bg = palette.base else palette.bg = palette.crust end
    ---@type TSContext_hl
    local TSContext_hl = {
        ['TC'] = { bg = palette.bg },
        ['TC_Bottom'] = { bg = palette.bg },
        ['TC_LineNumber'] = { bg = palette.bg, fg = palette.surface1 },
    }
    require('plugins.themes.ts-context').setup(TSContext_hl)
end

return {
    "catppuccin/nvim", name = "catppuccin", lazy = false, priority = 1000, enabled = false,
    config = function()
        require("catppuccin").setup {
            flavour = flavour_dark,
            background = {
                light = flavour_light,
                dark = flavour_dark
            },
            transparent_background = transparent,
            -- Special integrations https://github.com/catppuccin/nvim#special-integrations
        }
        vim.cmd.colorscheme("catppuccin-" .. flavour_dark)
        setup_tscontext_hl(transparent)
        AutoLightDark()
    end,
}
