return {
    "stevearc/conform.nvim",
    event = { "VeryLazy" },
    cmd = { "ConformInfo" },
    config = function()
        require("conform").setup({
            -- log_level = vim.log.levels.DEBUG,
            formatters_by_ft = {
                rust = { "rustfmt" },
                -- lua = { "stylua" },
            }
        })

        vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

        -- Create a range compatible command
        vim.api.nvim_create_user_command("Format", function(args)
            local range = nil
            if args.count ~= -1 then
                local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
                range = {
                    start = { args.line1, 0 },
                    ["end"] = { args.line2, end_line:len() },
                }
            end
            require("conform").format({ async = true, lsp_fallback = true, range = range })
        end, { range = true })

        vim.keymap.set({ "v" }, "gq", "<cmd>Format<CR>", { desc = "Conform: Range format" })
        vim.keymap.set({ "n" }, "gqf", "<cmd>Format<CR>", { desc = "Conform: File format" })
    end,
}
