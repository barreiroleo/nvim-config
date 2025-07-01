local custom_menu = {
    draw = {
        -- 󰊕 Function   std::make_unique<typename Tp>(Args &&...)   [LSP]
        columns = {
            { 'kind_icon',  "kind",             gap = 1 },
            { 'label',      'label_description' },
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
}

local copilot_tab_nes = {
    function(cmp)
        if vim.b[vim.api.nvim_get_current_buf()].nes_state then
            cmp.hide()
            return (
                require("copilot-lsp.nes").apply_pending_nes()
                and require("copilot-lsp.nes").walk_cursor_end_edit()
            )
        end
        if cmp.snippet_active() then
            return cmp.accept()
        else
            return cmp.select_and_accept()
        end
    end,
    "snippet_forward",
    "fallback",
}

return {
    {
        "fang2hou/blink-copilot",
        lazy = true,
        opts = {
            max_completions = 3,
            max_attempts = 4,
        }
    },

    {
        'saghen/blink.cmp',
        event = "InsertEnter",
        dependencies = {
            'rafamadriz/friendly-snippets',
            "fang2hou/blink-copilot"
        },
        -- version = '1.*', -- Release tag to download pre-built binaries

        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            cmdline = { enabled = false },
            keymap = {
                preset = 'super-tab',
                -- ["<Tab>"] = copilot_tab_nes,
            },
            fuzzy = { implementation = "lua" },

            completion = {
                menu = custom_menu,
                documentation = { auto_show = true, auto_show_delay_ms = 500 },
                ghost_text = { enabled = true },
            },

            signature = { enabled = true },
            -- snippets = { preset = "luasnip" },
            sources = {
                default = { "lazydev", "lsp", "path", "snippets", "buffer", "omni", "copilot" },
                providers = {
                    lazydev = {
                        name = "Lazy",
                        module = "lazydev.integrations.blink",
                        score_offset = 100,
                    },
                    copilot = {
                        name = "copilot",
                        module = "blink-copilot",
                        score_offset = -1,
                        async = true,
                    },
                },
            },
        },
    },
}
