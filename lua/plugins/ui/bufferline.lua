return {
    'akinsho/bufferline.nvim',
    event = { 'BufNewFile', 'BufReadPre' },
    dependencies = { 'kyazdani42/nvim-web-devicons' },
    config = function()
        require('bufferline').setup {
            options = {
                indicator = { style = 'underline' },
                -- indicator = { icon = '░', style = 'icon' },
                separator_style = { '|', '|' },

                offsets = {
                    {
                        filetype = 'neo-tree',
                        text = 'File Explorer',
                        highlight = 'Directory',
                        separator = true,
                        text_align = 'left',
                    },
                },

                groups = {
                    options = { toggle_hidden_on_enter = true },
                    items = {
                        require('bufferline.groups').builtin.ungrouped,
                        {
                            name = 'Tests',
                            matcher = function(buf)
                                return buf.name:match '%test' or buf.name:match '%spec'
                            end,
                        },
                        {
                            name = 'Docs',
                            matcher = function(buf)
                                return buf.name:match '%.md' or buf.name:match '%.txt'
                            end,
                        },
                    },
                },

                -- TODO: Show pin/unpin
                hover = {
                    enabled = true,
                    delay = 200,
                    reveal = { 'close' },
                },
            },
        }
    end,
    keys = {
        { '<leader>bad', '<cmd>BufferLineCloseOthers<cr>', desc = 'Bufferline: Close all other visible buffers' },
        { '<leader>bp', '<cmd>BufferLineTogglePin<cr>', desc = 'Bufferline: Toggle pin buffer' },
    },
}
