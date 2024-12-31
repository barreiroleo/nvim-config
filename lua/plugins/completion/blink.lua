return {
    {
        'saghen/blink.cmp',
        event = "InsertEnter",
        dependencies = { 'rafamadriz/friendly-snippets' },
        -- use a release tag to download pre-built binaries
        version = '*',

        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            keymap = {
                preset = 'default',
                -- NOTE: I tried recreating the nvim-cmp config but, as blink isn't using luasnip,
                -- keymap can be simplified as follows:
                ['<C-e>'] = { 'hide', 'fallback', },
                ['<Tab>'] = { 'select_and_accept', 'snippet_forward', 'fallback', },
                ['<S-Tab>'] = { 'snippet_backward', 'fallback', },
            },

            sources = {
                default = { "lazydev", 'lsp', 'path', 'snippets', 'buffer' },
                providers = {
                    lazydev = {
                        name = "Lazy",
                        module = "lazydev.integrations.blink",
                        score_offset = 100,
                    },
                },
            },

            completion = {
                menu = {
                    border = "rounded",
                    draw = {
                        -- 󰊕 Function   std::make_unique<typename Tp>(Args &&...)   [LSP]
                        columns = {
                            { 'kind_icon',  "kind",              gap = 1 },
                            { 'label',      'label_description', gap = 1 },
                            { 'source_name' },
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
                documentation = {
                    window = { border = "rounded" },
                    auto_show = true,
                    auto_show_delay_ms = 500
                },
                -- ghost_text = { enabled = true },
            },

            signature = {
                window = { border = "rounded" },
                enabled = true
            }
        },

        opts_extend = { "sources.default" },
    },
}
