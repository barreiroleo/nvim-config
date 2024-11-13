return
{
    {
        'saghen/blink.cmp',
        lazy = false,
        enabled = true,
        dependencies = 'rafamadriz/friendly-snippets',
        build = 'cargo build --release',
        opts = {
            keymap = { preset = 'super-tab' },
            accept = {
                expand_snippet = vim.snippet.expand,
                auto_brackets = { enabled = true }
            },
            signature_help = { enabled = true },
            windows = {
                autocomplete = {
                    border = 'rounded',
                    winbled = 10,
                    draw = {
                        -- for a setup similar to nvim-cmp: https://github.com/Saghen/blink.cmp/pull/245#issuecomment-2463659508
                        columns = { { "label", "label_description", gap = 2 }, { "kind_icon", "kind", gap = 2 }, { 'source' } },
                        components = {
                            source = {
                                text = function(ctx)
                                    local MAX_MENU_WIDTH = 04
                                    local source_name    = ctx.item.source_name or ""
                                    if vim.api.nvim_strwidth(source_name) > MAX_MENU_WIDTH then
                                        source_name = vim.fn.strcharpart(source_name, 0, MAX_MENU_WIDTH) ..
                                            require('core.utils.icons').misc.ellipsis
                                    end
                                    return string.format("[%s]", source_name)
                                end
                            }
                        },
                    }
                },
                documentation = { border = 'rounded', auto_show = true, },
                signature_help = { border = 'rounded', scrollbar = true },
                ghots_text = { enabled = true }
            },
            highlight = { se_nvim_cmp_as_default = false, },
        }
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
