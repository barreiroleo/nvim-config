local cmp     = require("cmp")
local luasnip = require("luasnip")
local icons   = require('core.icons')

-- Insert '(' after select function or method. Via nvim-autopair + nvim-cmp.
cmp.event:on('confirm_done', require("nvim-autopairs.completion.cmp").on_confirm_done({ map_char = { tex = '' } }))

cmp.setup {
    enabled = function()
        return vim.api.nvim_get_option_value("buftype", { buf = 0 }) ~= "prompt"
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
        ['<C-e>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.close()
            elseif luasnip.expand_or_jumpable() then
                luasnip.unlink_current()
            else
                fallback()
            end
        end),
        -- Insert completion or jump next snippet node
        ['<Tab>'] = cmp.mapping(
            function(fallback)
                if cmp.visible() then
                    cmp.confirm()
                elseif vim.env.SNIPPET and vim.snippet.jumpable(1) then
                    vim.snippet.jump(1)
                elseif luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                else
                    fallback()
                end
            end, { 'i', 's' }),
        -- Jump previous snippet node
        ['<S-Tab>'] = cmp.mapping(
            function(fallback)
                if vim.env.SNIPPET and vim.snippet.jumpable(-1) then
                    vim.snippet.jump(-1)
                elseif luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                else
                    fallback()
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
        fields = { 'kind', 'abbr', 'menu' },
        format = function(entry, vim_item)
            local source = ({
                nvim_lsp = "LSP",
                luasnip  = "Snip",
                buffer   = "Buff",
                path     = "Path",
                nvim_lua = "Vim",
            })
            local MAX_KIND_WIDTH, MAX_ABBR_WIDTH, MAX_MENU_WIDTH = 05, 25, 30

            -- Add the icon.
            vim_item.kind = (icons.symbol_kinds[vim_item.kind] or icons.symbol_kinds.Text) .. ' ' .. vim_item.kind
            -- Add the source to description
            vim_item.menu = string.format("[%s] %s", source[entry.source.name] or "", vim_item.menu or "")

            -- Truncate the kind, label, description.
            if vim.api.nvim_strwidth(vim_item.kind) > MAX_KIND_WIDTH then
                vim_item.kind = vim.fn.strcharpart(vim_item.kind, 0, MAX_KIND_WIDTH)
            end
            if vim.api.nvim_strwidth(vim_item.abbr) > MAX_ABBR_WIDTH then
                vim_item.abbr = vim.fn.strcharpart(vim_item.abbr, 0, MAX_ABBR_WIDTH) .. icons.misc.ellipsis
            end
            if vim.api.nvim_strwidth(vim_item.menu or '') > MAX_MENU_WIDTH then
                vim_item.menu = vim.fn.strcharpart(vim_item.menu, 0, MAX_MENU_WIDTH) .. icons.misc.ellipsis
            end

            return vim_item
        end,
    },
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
