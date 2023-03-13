vim.cmd([[
    let s:wrapenabled = 0
    function! ToggleWrap()
      " set wrap nolist
      if s:wrapenabled
        set nowrap nolinebreak
        unmap j
        unmap k
        unmap 0
        unmap ^
        unmap $
        let s:wrapenabled = 0
      else
        set wrap linebreak
        nnoremap j gj
        nnoremap k gk
        nnoremap 0 g0
        nnoremap ^ g^
        nnoremap $ g$
        vnoremap j gj
        vnoremap k gk
        vnoremap 0 g0
        vnoremap ^ g^
        vnoremap $ g$
        let s:wrapenabled = 1
      endif
    endfunction
]])
