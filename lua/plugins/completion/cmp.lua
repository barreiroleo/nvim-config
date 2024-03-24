local cmp     = require "cmp"
local luasnip = require "luasnip"
local lspkind = require "lspkind"

vim.o.pumheight = 10 -- Limit number of suggestions

-- Insert '(' after select function or method. Via nvim-autopair + nvim-cmp.
cmp.event:on('confirm_done', require("nvim-autopairs.completion.cmp").on_confirm_done({ map_char = { tex = '' } }))

cmp.setup {
    enabled = function()
        return vim.api.nvim_get_option_value("buftype", {buf = 0}) ~= "prompt"
            or require("cmp_dap").is_dap_buffer()
    end,

    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    completion = {
        completeopt = 'menu,menuone,noinsert'
    },

    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },

    mapping = cmp.mapping.preset.insert({
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
        -- Cancel autocompletion and luasnip jumps
        ['<C-e>'] = cmp.mapping(function (fallback)
            if cmp.visible() then
                cmp.close()
            elseif luasnip.expand_or_jumpable() then
                luasnip.unlink_current()
            else fallback()
            end
        end),
        -- Insert completion or jump next snippet node
        ['<Tab>'] = cmp.mapping(
            function(fallback)
                if cmp.visible() then
                    cmp.confirm()
                elseif luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                else fallback()
                end
            end, { 'i', 's' }),
        -- Jump previous snippet node
        ['<S-Tab>'] = cmp.mapping(
            function(fallback)
                if luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                else fallback()
                end
            end, { 'i', 's' }),
    }),

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

cmp.setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
    sources = {
        { name = "dap" },
    },
})

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
