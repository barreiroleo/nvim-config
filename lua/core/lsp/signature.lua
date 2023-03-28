local on_attach = function(_, bufnr)
    if require("core.utils").has("lsp_signature") then
        require "lsp_signature".on_attach({
            -- Floating windows config
            handler_opts = {
                -- double, rounded, single, shadow, none
                border = "none"
            },
            auto_close_after = 5,
            transparency = 10,
            toggle_key = '<C-e>'
        }, bufnr)
    end
end

return on_attach
