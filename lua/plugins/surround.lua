return {
    "tpope/vim-surround",
    config = function()
        vim.cmd [[
            autocmd FileType tex let b:surround_{char2nr("q")} = "`\r'"
            autocmd FileType tex let b:surround_{char2nr('Q')} = "``\r''"
            autocmd FileType tex let b:surround_{char2nr('i')} = "\\textit{\r}"
            autocmd FileType tex let b:surround_{char2nr('b')} = "\\textbf{\r}"
            autocmd FileType tex let b:surround_{char2nr('t')} = "\\texttt{\r}"
            " autocmd FileType tex let b:surround_{char2nr('s')} = "\\textsc{\r}"
            autocmd FileType tex let b:surround_{char2nr('c')} = "\\corner{\r}"
            autocmd FileType tex let b:surround_{char2nr('s')} = "\\set{\r}"
            autocmd FileType tex let b:surround_{char2nr('$')} = "$\r$"
            autocmd FileType tex let b:surround_96 = "`\r'"
        ]]
    end
}
