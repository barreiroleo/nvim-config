local diagnostics_indicator = function(count, level, diagnostics_dict, context)
    local s = " "
    for e, n in pairs(diagnostics_dict) do
        local sym = e == "error" and " " or (e == "warning" and " " or "")
        s = s .. n .. sym
    end
    return s
end

return {
    "akinsho/bufferline.nvim",
    version = "v2.*",
    event = "VeryLazy",
    dependencies = { "kyazdani42/nvim-web-devicons" },
    opts = {
        options = {
            max_name_length = 15,
            tab_size = 15,
            separator_style = { "|", "|" }, -- [focused and unfocused].
            sort_by = "relative_directory",
            -- For ⁸·₂ (ordinal and buffer_id)
            -- numbers = "both",
            numbers = function(opts)
                return string.format("%s·%s", opts.raise(opts.id), opts.lower(opts.ordinal))
            end,
            offsets = {
                {
                    filetype = "neo-tree",
                    text = "Explorer",
                    text_align = "left",
                },
            },
            diagnostics = "nvim_lsp",
            diagnostics_indicator = diagnostics_indicator,
        },
    },
}
