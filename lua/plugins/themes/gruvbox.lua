local gruvbox_community = function()
    vim.o.termguicolors = true
    vim.o.background = "dark"
    vim.g.gruvbox_italic = true
    vim.g.gruvbox_contrast_dark = "hard"
    vim.g.gruvbox_contrast_light = "hard"
    vim.api.nvim_command("colorscheme gruvbox")
end

local gruvbox_material = function()
    vim.o.termguicolors = true
    vim.o.background = "dark"
    vim.g.gruvbox_material_background = "hard" -- hard, medium(def), soft
    vim.g.gruvbox_material_foreground = "mix" -- material(def), mix, original
    vim.g.gruvbox_material_enable_bold = true
    vim.g.gruvbox_material_enable_italic = true
    vim.g.gruvbox_material_disable_italic_comment = false
    vim.g.gruvbox_material_better_performance = true
    vim.g.gruvbox_material_transparent_background = 1 -- 0, 1, 2 (more or less component)
    vim.g.gruvbox_material_diagnostic_text_highlight = true
    vim.g.gruvbox_material_statusline_style = "original" -- default, mix, original
    vim.api.nvim_command("colorscheme gruvbox-material")
end

return {
    { "gruvbox-community/gruvbox",
        enabled = false,
        lazy = false,
        priority = 1000,
        config = gruvbox_community
    },
    { "sainnhe/gruvbox-material",
        enabled = false,
        lazy = false,
        priority = 1000,
        config = gruvbox_material
    }
}
