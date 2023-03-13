local sonokai_config = function()
    vim.o.termguicolors = true
    vim.g.sonokai_style = "shusia" -- default, atlantis, andromeda, shusia, maia, espresso

    vim.g.sonokai_disable_italic_comment = 0
    vim.g.sonokai_enable_italic = 1

    vim.g.sonokai_cursor = "auto" -- auto, red, orange, yellow, green, blue, purple`
    vim.g.sonokai_transparent_background = 1 -- 0, 1, 2 (more or less component)
    vim.g.sonokai_menu_selection_background = "blue" -- blue, green, red

    vim.g.sonokai_diagnostic_text_highlight = 1
    vim.g.sonokai_diagnostic_line_highlight = 1
    vim.g.sonokai_diagnostic_virtual_text = "colored" -- grey, colored

    -- grey background on not transparent mode, bold on transparent
    -- vim.g.sonokai_current_word = "grey background" -- grey background, bold, underline, italic
    vim.g.sonokai_better_performance = true

    vim.o.background = "dark"
    vim.cmd.colorscheme("sonokai")
end

return {
    { "sainnhe/sonokai",
        enabled = false,
        lazy = false,
        priority = 1000,
        config = sonokai_config
    }
}
