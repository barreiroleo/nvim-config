local edge_config = function()
    vim.o.termguicolors = true
    vim.g.edge_style = "default" -- default, aura, neon
    vim.g.edge_better_performance = true
    -- Transparent background -> 1
    -- Full ui components -> 2
    vim.g.edge_transparent_background = 1
    vim.cmd.colorscheme("edge")
end

return {
    { "sainnhe/edge",
        enabled = false,
        lazy = false,
        priority = 1000,
        config = edge_config
    }
}
