return {
    {
        'saghen/blink.cmp',
        event = "InsertEnter",
        dependencies = 'rafamadriz/friendly-snippets',
        -- use a release tag to download pre-built binaries
        version = '*',

        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            keymap = { preset = 'super-tab' },
            appearance = {
                use_nvim_cmp_as_default = true,
                nerd_font_variant = 'mono'
            },
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
            },

            completion = {
                menu = {
                    border = "rounded",
                    draw = {
                        -- std::unique_ptr<class Tp, class Dp>      󱡠  Class    [LSP]
                        columns = {
                            { 'label',       'label_description', gap = 1 },
                            { 'kind_icon',   "kind",              gap = 1 },
                            { 'source_name', gap = 1 },
                        },
                        components = {
                            source_name = {
                                text = function(ctx)
                                    if vim.api.nvim_strwidth(ctx.source_name) > 3 then
                                        return string.format("[%s]", vim.fn.strcharpart(ctx.source_name, 0, 3))
                                    end
                                    return string.format("[%s]", ctx.source_name)
                                end,
                                highlight = 'BlinkCmpKind'
                            }
                        }
                    }
                },
                documentation = { window = { border = "rounded" }, auto_show = true, auto_show_delay_ms = 100 },
                ghost_text = { enabled = true },
            },
            signature = { window = { border = "rounded" }, enabled = true }
        },
        opts_extend = { "sources.default" },
    },

    {
        'neovim/nvim-lspconfig',
        dependencies = { 'saghen/blink.cmp' },
        config = function(_, opts)
            local lspconfig = require('lspconfig')
            for server, config in pairs(opts.servers or {}) do
                config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
                lspconfig[server].setup(config)
            end
        end
    }
}
