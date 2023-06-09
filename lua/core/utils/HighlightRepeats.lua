-- Highlight duplicated lines
vim.cmd([[
    function! HighlightRepeats() range
        let lineCounts = {}
        let lineNum = a:firstline
        while lineNum <= a:lastline
            let lineText = getline(lineNum)
            if lineText != ""
                let lineCounts[lineText] = (has_key(lineCounts, lineText) ? lineCounts[lineText] : 0) + 1
            endif
            let lineNum = lineNum + 1
        endwhile
        exe 'syn clear Repeat'
        for lineText in keys(lineCounts)
            if lineCounts[lineText] >= 2
                exe 'syn match Repeat "^' . escape(lineText, '".\^$*[]') . '$"'
            endif
        endfor
    endfunction

    command! -range=% HighlightRepeats <line1>,<line2>call HighlightRepeats()
]])
-- In oneline (slower)
-- syn clear Repeat | g/^\(.*\)\n\ze\%(.*\n\)*\1$/exe 'syn match Repeat "^' . escape(getline('.'), '".\^$*[]') . '$"' | nohlsearch
