local cmp     = require "cmp"
local luasnip = require "luasnip"
local lspkind = require "lspkind"

local cmp_mapping = require("plugins.completion.keymaps").cmp

vim.o.pumheight = 10 -- Limit number of suggestions

-- Insert '(' after select function or method. Via nvim-autopair + nvim-cmp.
cmp.event:on('confirm_done', require("nvim-autopairs.completion.cmp").on_confirm_done({ map_char = { tex = '' } }))

cmp.setup {
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },

    window = {
        -- completion = cmp.config.window.bordered(),
        -- documentation = cmp.config.window.bordered(),
    },

    mapping = cmp.mapping.preset.insert(cmp_mapping),

    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        {
            name = 'buffer',
            keyword_length = 5,              -- Trigger completion menu on Nth character.
            option = { keyword_length = 3, } -- Minimum length for completion candidates.
        },
        { name = 'path' },
        { name = 'nvim_lua' },
    },

    formatting = {
        format = lspkind.cmp_format({
            mode = "symbol_text",
            menu = ({
                nvim_lsp = "[LSP]",
                luasnip  = "[Snip]",
                buffer   = "[Buff]",
                path     = "[Path]",
                nvim_lua = "[Vim]",
            })
        }),
    }
}

cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'cmdline' },
        { name = 'path' }
    },
})

cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})
